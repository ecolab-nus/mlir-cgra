#pragma once

#include "mlir/IR/BuiltinDialect.h"
#include "soda/Transforms/Passes.hpp"

namespace mlir {

class AffineDialect;

namespace func {
class FuncDialect;
class FuncOp;
}

namespace memref {
class MemRefDialect;
}

namespace arith {
class ArithmeticDialect;
}

class ModuleOp;

#define GEN_PASS_CLASSES
#include "relay/Transforms/Passes.h.inc"

}  // namespace mlir
