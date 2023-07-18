//===-- Passes.td - SODA pass definition file --------------*- tablegen -*-===//
//===----------------------------------------------------------------------===//
//
// Defines the Morpher Passes
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_MORPHER_PASSES
#define MLIR_DIALECT_MORPHER_PASSES

include "mlir/Pass/PassBase.td"

def MarkMapRegion : Pass<"mark-map-region", "::mlir::func::FuncOp"> {
  let summary = "Mark the region to be mapped in morpher dfg generator";
  let constructor = "mlir::morpher::createMarkMapRegionPass()";
  let dependentDialects = [
    "mlir::morpher::MorpherDialect"
  ];
}

def LegalizeMorpher : Pass<"legalize-morpher", "::mlir::ModuleOp"> {
  let summary = "Lower morpher dialects to native supported dialects (func/std...)";
  let constructor = "mlir::morpher::createLegalizeMorpherPass()";
  let dependentDialects = [
    "mlir::morpher::MorpherDialect",
    "mlir::func::FuncDialect"
  ];
}

def DynamicPassPipeline : Pass<"dynamic-pass-pipeline", ""> {
  let summary = "Run dynamic pass pipeline";
  let constructor = "mlir::morpher::createDynamicPassPipelinePass()";
  let dependentDialects = [
    "mlir::morpher::MorpherDialect",
    "mlir::func::FuncDialect"
  ];
  let options = [
    Option<"opName", "op-name", "std::string", "\"builtin.module\"", "The operation to apply this pipeline">,
    Option<"pipeline", "pipeline", "std::string", "", "The pipeline parameters">,
  ];
}

def TransformDialectInterp : Pass<"transform-ops-interp", "::mlir::ModuleOp"> {
  let summary = "Interpret transform ops";
  let constructor = "mlir::morpher::createTransformDialectInterpPass()";
  let dependentDialects = [
    "mlir::func::FuncDialect",
    "mlir::transform::TransformDialect",
  ];
  let options = [
    Option<"transformFile", "transform-file", "std::string", "\"\"", "The file holding transform module">,
    Option<"enableExpensiveChecks", "enable-expensive-checks", "bool", "false", "If enable expensive checks">,
  ];
}

//def OutlineMorpherKernels : Pass<"outline-morpher-kernels", "mlir::ModuleOp">  {
//  let summary = "Outlining linalg operations to morpher kernels.";
//  let constructor = "mlir::morpher::createOutlineMorpherKernelPass()";
//  let dependentDialects = [
//    "mlir::morpher::MorpherDialect",
//    "mlir::func::FuncDialect",
//    "mlir::linalg::LinalgDialect"
//  ];
//}

#endif // MLIR_DIALECT_MORPHER_PASSES
