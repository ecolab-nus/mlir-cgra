//===- PassDetail.h - PassHelper  -------------------------------*- C++ -*-===//

#ifndef DIALECT_MORPHER_PASSDETAIL_H_
#define DIALECT_MORPHER_PASSDETAIL_H_

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"

namespace mlir {
namespace morpher {
class MorpherDialect;
}
namespace func {
class FuncOp;
class FuncDialect;
}
namespace morpher {
#define GEN_PASS_CLASSES
#include "morpher/Dialect/Morpher/Transforms/Passes.h.inc"
}
}

#endif  // DIALECT_MORPHER_PASSDETAIL_H_
