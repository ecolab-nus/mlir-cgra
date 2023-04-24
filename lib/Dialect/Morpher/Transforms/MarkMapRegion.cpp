//===- MarkMapRegion.cpp - Morpher Passes
//---------------------------------------===//

#include "PassDetail.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Pass/Pass.h"
#include "morpher/Dialect/Morpher/IR/MorpherDialect.h"
#include "morpher/Dialect/Morpher/Transforms/Passes.h"

#include "mlir/IR/ImplicitLocOpBuilder.h"
#include "mlir/Interfaces/LoopLikeInterface.h"
#include "mlir/Support/FileUtilities.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"

#define DEBUG_TYPE "mark-map-region"

using namespace mlir;
using namespace mlir::morpher;

namespace {

/// Is inner body if op's region does not include any operations with interface
/// LoopLikeOpInterface
bool isInnerMostOp(Operation *op) {
  if (op->getNumRegions() == 0)
    return false;

  return llvm::all_of(op->getRegions(), [](Region &r) -> bool {
    return r.getOps<LoopLikeOpInterface>().empty();
  });
}

/// Find the most inner loop body, i.e., region does not contain other for
/// loops.
void findInnerBody(Operation* op, llvm::SmallVectorImpl<Operation *> *inner_ops) {
  if (isInnerMostOp(op)) {
    inner_ops->push_back(op);
    return;
  }

  // Traverse regions of all operations if exist.
  for (auto &r : op->getRegions()) {
    for (auto &body_op : r.getOps()) {
      // Bypass operation without regions.
      if (body_op.getNumRegions() == 0)
        continue;

      // Find inner body recursively.
      findInnerBody(&body_op, inner_ops);
    }
  }
}

/// Add MarkMapOp to region.
void insertMarkMapOp(Operation *op) {
  llvm::errs() << "insert mark for " << *op << "\n";
  assert(op->getNumRegions() > 0 && "Should mark operation with at lease one region!");
  OpBuilder builder(op->getContext());
  auto blk = &op->getRegion(0).front();
  builder.setInsertionPointToStart(blk);
  builder.create<morpher::MapHintOp>(blk->front().getLoc());
}

class MarkMapRegion : public mlir::morpher::MarkMapRegionBase<MarkMapRegion> {
public:
  void runOnOperation() override {
    auto func = this->getOperation();

    // Find all inner bodies.
    llvm::SmallVector<Operation *, 4> inner_most_ops;
    findInnerBody(func.getOperation(), &inner_most_ops);

    // Add MarkMapOp to the inner most region
    for (auto inner_most_op : inner_most_ops) {
      insertMarkMapOp(inner_most_op);
    }
  }
};

} // namespace

std::unique_ptr<OperationPass<mlir::func::FuncOp>>
mlir::morpher::createMarkMapRegionPass() {
  return std::make_unique<MarkMapRegion>();
}
