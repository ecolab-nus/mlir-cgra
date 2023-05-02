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
