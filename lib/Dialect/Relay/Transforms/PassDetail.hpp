#pragma once

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Pass/Pass.h"
#include "soda/Dialect/Relay/RelayDialect.hpp"

namespace mlir {
namespace relay {

#define GEN_PASS_CLASSES
#include "soda/Dialect/Relay/Passes.h.inc"

}  // namespace relay

}  // namespace mlir
