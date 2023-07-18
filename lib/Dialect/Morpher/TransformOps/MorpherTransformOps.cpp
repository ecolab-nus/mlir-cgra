#include "morpher/Dialect/Morpher/TransformOps/MorpherTransformOps.h"
#include "morpher/Dialect/Morpher/TransformOps/Utils.h"
#include "morpher/Dialect/Morpher/Transforms/Passes.h"

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
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

#include <vector>

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

::mlir::DiagnosedSilenceableFailure
mlir::transform::OutlineMorpherKernel::apply(
    ::mlir::transform::TransformResults &transformResults,
    ::mlir::transform::TransformState &state) {

  SmallVector<Operation *> target_ops;

  for (auto target : getTargets()) {
    // Collect all matched operations.
    auto payloads = state.getPayloadOps(target);
    target_ops.append(payloads.begin(), payloads.end());
  }

  // No operation to be outlined.
  if (target_ops.empty())
    return mlir::DiagnosedSilenceableFailure::success();

  // Outline operations to a new function.
  // TODO(hyl): add outline

  return mlir::DiagnosedSilenceableFailure::definiteFailure();
}

::mlir::DiagnosedSilenceableFailure mlir::transform::RunPassPipeline::apply(
    ::mlir::transform::TransformResults &transformResults,
    ::mlir::transform::TransformState &state) {
  std::vector<Operation *> targetOps;
  if (auto containerOp = getContainerOp()) {
    targetOps = state.getPayloadOps(containerOp).vec();
  } else {
    targetOps.push_back(state.getTopLevel());
  }

  MLIRContext *context = getContext();
  auto pipeline = this->getPassPipeline();
  auto opName = this->getOpName();
  for (auto &op : targetOps) {
    mlir::PassManager pm(context);
    pm.addPass(mlir::morpher::createDynamicPassPipelinePass(opName.str(),
                                                            pipeline.str()));
    if (failed(pm.run(op)))
      return DiagnosedSilenceableFailure::definiteFailure();
  }

  return DiagnosedSilenceableFailure::success();
}

void transform::RunPassPipeline::getEffects(
    ::llvm::SmallVectorImpl<
        ::mlir::SideEffects::EffectInstance<::mlir::MemoryEffects::Effect>>
        &effects) {
  transform::modifiesPayload(effects);
}

::mlir::DiagnosedSilenceableFailure
transform::Print::apply(::mlir::transform::TransformResults &transformResults,
                        ::mlir::transform::TransformState &state) {
  std::vector<Operation *> targetOps;
  if (auto target = getTarget()) {
    targetOps = state.getPayloadOps(target).vec();
  } else {
    targetOps.push_back(state.getTopLevel());
  }

  if (targetOps.empty()) {
    llvm::errs() << "[[ Empty target! ]]\n";
    return DiagnosedSilenceableFailure::success();
  }

  assert(targetOps.size() == 1);

  llvm::StringRef comment;
  if (getComment().has_value())
    comment = getCommentAttr().getValue();
  else
    comment = targetOps.front()->getName().getStringRef();

  llvm::errs() << "[[ " << comment << "]]\n";
  targetOps.front()->dump();

  return DiagnosedSilenceableFailure::success();
}

void transform::Print::getEffects(
    ::llvm::SmallVectorImpl<
        ::mlir::SideEffects::EffectInstance<::mlir::MemoryEffects::Effect>>
        &effects) {
  transform::onlyReadsPayload(effects);
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
