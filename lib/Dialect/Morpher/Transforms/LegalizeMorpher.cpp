//===- LegalizeMorpher.cpp - Morpher Passes
//---------------------------------------===//

#include "PassDetail.h"
#include "mlir/Dialect/Arithmetic/IR/Arithmetic.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Pass/Pass.h"
#include "morpher/Dialect/Morpher/IR/MorpherDialect.h"
#include "morpher/Dialect/Morpher/Transforms/Passes.h"

#include "mlir/IR/ImplicitLocOpBuilder.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Interfaces/LoopLikeInterface.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Transforms/DialectConversion.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"

#define DEBUG_TYPE "legalize-morpher"

using namespace mlir;
using namespace mlir::morpher;

namespace {

func::FuncOp replaceMapMeFunc(ModuleOp moduleOp) {
  // Create please_map_me() function
  func::FuncOp func =
      func::FuncOp::create(moduleOp.getLoc(), MapHintOp::mapHintFuncName(),
                           FunctionType::get(moduleOp.getContext(), {}, {}));
  func.setSymVisibilityAttr(StringAttr::get(moduleOp.getContext(), "private"));

  OpBuilder builder(moduleOp.getContext());
  bool hasMapHint = false;
  moduleOp.walk([func, &builder, &hasMapHint](MapHintOp op) {
    builder.setInsertionPoint(op.getOperation());
    builder.create<func::CallOp>(op.getLoc(), func, op->getOperands());
    hasMapHint = true;
    op->erase();
  });

  if (hasMapHint) {
    moduleOp.push_back(func);
  }
  return func;
}

// Convert remainder(num, divisor) to (num - divisor * (num / divisor))
struct RemoveRemSIOp : public OpRewritePattern<arith::RemSIOp> {
  using OpRewritePattern<arith::RemSIOp>::OpRewritePattern;
  LogicalResult matchAndRewrite(arith::RemSIOp op,
                                PatternRewriter &rewriter) const override {
    auto num = op.getLhs();
    auto divisor = op.getRhs();
    auto a1 = rewriter.create<arith::FloorDivSIOp>(op.getLoc(), num, divisor);
    auto a2 = rewriter.create<arith::MulIOp>(op.getLoc(), divisor, a1);
    auto a3 = rewriter.create<arith::SubIOp>(op.getLoc(), num, a2);
    rewriter.replaceOp(op.getOperation(), a3->getResults());
    return success();
  }
};

struct RemoveRemUIOp : public OpRewritePattern<arith::RemUIOp> {
  using OpRewritePattern<arith::RemUIOp>::OpRewritePattern;
  LogicalResult matchAndRewrite(arith::RemUIOp op,
                                PatternRewriter &rewriter) const override {
    auto num = op.getLhs();
    auto divisor = op.getRhs();
    auto a1 = rewriter.create<arith::DivUIOp>(op.getLoc(), num, divisor);
    auto a2 = rewriter.create<arith::MulIOp>(op.getLoc(), divisor, a1);
    auto a3 = rewriter.create<arith::SubIOp>(op.getLoc(), num, a2);
    rewriter.replaceOp(op.getOperation(), a3->getResults());
    return success();
  }
};

class LegalizeMorpher
    : public mlir::morpher::LegalizeMorpherBase<LegalizeMorpher> {
public:
  void runOnOperation() override {
    auto moduleOp = getOperation();
    if (!moduleOp)
      return signalPassFailure();

    replaceMapMeFunc(moduleOp);

    // Replace remainder.
    MLIRContext* context = &getContext();
    RewritePatternSet patterns(context);
    patterns.insert<RemoveRemSIOp, RemoveRemUIOp>(context);
    if (failed(applyPatternsAndFoldGreedily(getOperation(), std::move(patterns)))) {
      return signalPassFailure();
    }
  }
};

} // namespace

std::unique_ptr<Pass> mlir::morpher::createLegalizeMorpherPass() {
  return std::make_unique<LegalizeMorpher>();
}
