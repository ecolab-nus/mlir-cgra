//
// Created by huiying on 5/3/23.
//
#include "morpher/Dialect/Morpher/TransformOps/Utils.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"

using namespace mlir;
using namespace mlir::func;

/// outline operations in ops to the end of region.
// LogicalResult outlineToRegion(ArrayRef<Operation*> ops, Region& region) 

// }

// template <>
// FailureOr<func::FuncOp> mlir::morpher::outline<func::FuncOp>(ArrayRef<Operation *> ops,
//                                                   StringRef kernel_name) {
//     Region region;
//     if (failed(outlineToRegion(ops, region))) {
//         return failure();
//     }

//     FuncOp func = FuncOp::create(kernel_name);
// }
