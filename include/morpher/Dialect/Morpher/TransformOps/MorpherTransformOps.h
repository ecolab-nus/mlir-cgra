#ifndef SODA_OPT_MORPHERTRANSFORMOPS_H
#define SODA_OPT_MORPHERTRANSFORMOPS_H

#include "mlir/Dialect/PDL/IR/PDLTypes.h"
#include "mlir/Dialect/Transform/IR/TransformInterfaces.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

namespace mlir {
namespace linalg {
class GenericOp;
class LinalgOp;
} // namespace linalg
namespace func {
class FuncOp;
} // namespace func
} // namespace mlir

//===----------------------------------------------------------------------===//
// Morpher Transform Operations
//===----------------------------------------------------------------------===//

#define GET_OP_CLASSES
#include "morpher/Dialect/Morpher/TransformOps/MorpherTransformOps.h.inc"

namespace mlir {
class DialectRegistry;

namespace morpher {
void registerTransformDialectExtension(DialectRegistry &registry);
} // namespace morpher
} // namespace mlir

#endif // SODA_OPT_MORPHERTRANSFORMOPS_H
