//===- Passes.h - Pass Entrypoints ------------------------------*- C++ -*-===//

#ifndef MLIR_DIALECT_MORPHER_PASSES_H_
#define MLIR_DIALECT_MORPHER_PASSES_H_

#include "mlir/Pass/Pass.h"
#include "morpher/Dialect/Morpher/IR/MorpherDialect.h"
#include <memory>

namespace mlir {
class ModuleOp;
namespace func {
class FuncOp;
class CallOp;
} // namespace func
namespace morpher {

std::pair<mlir::func::FuncOp, mlir::func::CallOp> outline();

/// This pass automatically analyze affine.for loops and mark the inner-most
/// body with MapRegionOp, which will be lowered to please_map_me() function and
/// passed to morpher dfg generator.
std::unique_ptr<Pass> createMarkMapRegionPass();

/// This pass lower morpher ops to native dialects.
std::unique_ptr<Pass> createLegalizeMorpherPass();

std::unique_ptr<Pass> createDynamicPassPipelinePass(const std::string& name = "",
                                                    const std::string& pipeline = "");

std::unique_ptr<Pass> createTransformDialectInterpPass(const std::string& file = "");

/// This pass outlines kernels for morpher
//std::unique_ptr<OperationPass<ModuleOp>> createOutlineMorpherKernelPass();

// Include autogen pass registration
#define GEN_PASS_REGISTRATION
#include "morpher/Dialect/Morpher/Transforms/Passes.h.inc"

} // namespace morpher
} // namespace mlir

#endif // MLIR_DIALECT_MORPHER_PASSES_H_
