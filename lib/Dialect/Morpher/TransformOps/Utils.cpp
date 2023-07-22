//
// Created by huiying on 5/3/23.
//
#include "morpher/Dialect/Morpher/TransformOps/Utils.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "easylogging++.h"
#include "llvm/ADT/SmallPtrSet.h"

using namespace mlir;
using namespace mlir::func;

/// outline operations in ops to the end of region.
LogicalResult outlineToRegion(ArrayRef<Operation *> ops, Region &region,
                              llvm::SmallPtrSetImpl<Value> *ins,
                              llvm::SmallPtrSetImpl<Value> *outs) {
  // check if all ops are in the same block
  Block *parentBlock = ops.front()->getBlock();
  if (!llvm::all_of(ops, [&](Operation *_op) {
        return _op->getBlock() == parentBlock;
      })) {
    LOG(ERROR) << "Error: Can not outline, all ops should be defined in the "
                  "same block\n";
    return failure();
  }

  ins->clear();
  outs->clear();

  BlockAndValueMapping mapping;
  Block *new_block = new Block();
  OpBuilder builder(new_block, new_block->begin());
  region.push_back(new_block);

  for (Operation *op : ops) {
    builder.clone(*op, mapping);
  }

  // Collect the input values
  for (auto &op : *new_block) {
    // Return if used by operations outside this block.
    for (auto result : op.getResults()) {
      if (result.isUsedOutsideOfBlock(new_block)) {
        outs->insert(result);
      }
    }

    // Input if defined by operations outside this block.
    for (auto opr : op.getOperands()) {
      if (opr.getDefiningOp()->getBlock() != new_block) {
        ins->insert(opr);
      }
    }
  }

  return success();
}

template <>
FailureOr<func::FuncOp> mlir::morpher::outline<func::FuncOp>(
    ArrayRef<Operation *> ops, StringRef kernelName,
    std::function<void(mlir::OpBuilder &, llvm::ArrayRef<Value>)>
        buildLaunchOp) {
  if (ops.empty())
    return failure();

  Region region;
  SmallPtrSet<Value, 16> ins, outs;
  if (failed(outlineToRegion(ops, region, &ins, &outs))) {
    return failure();
  }

  MLIRContext* context = ops.front()->getContext();

  auto inTypes = mlir::TypeRange(ValueRange(llvm::to_vector(ins)));
  auto outTypes = mlir::TypeRange(ValueRange(llvm::to_vector(outs)));
  // Create new function.
  auto fType = FunctionType::get(context, inTypes, outTypes);

  auto func = FuncOp::create(ops.front()->getLoc(), kernelName, fType);

  BlockAndValueMapping mapping;
  region.cloneInto(&func.getRegion(), mapping);

  //  OpBuilder builder(ops.front()->getContext());
}
