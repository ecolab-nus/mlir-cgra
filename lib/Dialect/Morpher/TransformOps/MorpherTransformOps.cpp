#include "morpher/Dialect/Morpher/TransformOps/MorpherTransformOps.h"

#include "mlir/AsmParser/AsmParser.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arithmetic/IR/Arithmetic.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/Linalg/Transforms/Transforms.h"
#include "mlir/Dialect/PDL/IR/PDL.h"
#include "mlir/Dialect/PDL/IR/PDLTypes.h"
#include "mlir/Dialect/Transform/IR/TransformDialect.h"
#include "mlir/Dialect/Transform/IR/TransformInterfaces.h"
#include "mlir/Interfaces/TilingInterface.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "llvm/ADT/StringSet.h"

using namespace mlir;
using namespace mlir::linalg;
using namespace mlir::morpher;

namespace {
/// A simple pattern rewriter that implements no special logic.
class SimpleRewriter : public PatternRewriter {
public:
  SimpleRewriter(MLIRContext *context) : PatternRewriter(context) {}
};
} // namespace

::mlir::DiagnosedSilenceableFailure mlir::transform::OutlineMorpherKernel::apply(
    ::mlir::transform::TransformResults &transformResults,
    ::mlir::transform::TransformState &state) {


  return mlir::DiagnosedSilenceableFailure::definiteFailure();
}

namespace {

class MorpherTransformDialectExtension
    : public transform::TransformDialectExtension<
          MorpherTransformDialectExtension> {
public:
  using Base::Base;

  void init() {
    declareDependentDialect<pdl::PDLDialect>();

    declareGeneratedDialect<linalg::LinalgDialect>();
    declareGeneratedDialect<arith::ArithmeticDialect>();
    declareGeneratedDialect<scf::SCFDialect>();
    declareGeneratedDialect<vector::VectorDialect>();
    declareGeneratedDialect<memref::MemRefDialect>();
    declareGeneratedDialect<tensor::TensorDialect>();

    registerTransformOps<
#define GET_OP_LIST
#include "morpher/Dialect/Morpher/TransformOps/MorpherTransformOps.cpp.inc"
        >();
  }
};

} // namespace

#define GET_OP_CLASSES
#include "morpher/Dialect/Morpher/TransformOps/MorpherTransformOps.cpp.inc"

void mlir::morpher::registerTransformDialectExtension(
    DialectRegistry &registry) {
  registry.addExtensions<MorpherTransformDialectExtension>();
}