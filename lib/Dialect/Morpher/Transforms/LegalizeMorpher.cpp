//===- LegalizeMorpher.cpp - Morpher Passes
//---------------------------------------===//

#include "PassDetail.h"
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
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

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
  bool has_map_hint = false;
  moduleOp.walk([func, &builder, &has_map_hint](MapHintOp op)  {
    builder.setInsertionPoint(op.getOperation());
    builder.create<func::CallOp>(op.getLoc(), func, op->getOperands());
    has_map_hint = true;
    op->erase();
  });

  if (has_map_hint) {
    moduleOp.push_back(func);
  }
  return func;
}

class LegalizeMorpher
    : public mlir::morpher::LegalizeMorpherBase<LegalizeMorpher> {
public:
  void runOnOperation() override {
    auto moduleOp = getOperation();
    if (!moduleOp)
      return signalPassFailure();

    replaceMapMeFunc(moduleOp);
  }
};

} // namespace

std::unique_ptr<Pass> mlir::morpher::createLegalizeMorpherPass() {
  return std::make_unique<LegalizeMorpher>();
}
