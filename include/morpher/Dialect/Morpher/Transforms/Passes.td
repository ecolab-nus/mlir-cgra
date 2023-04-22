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
}

#endif // MLIR_DIALECT_MORPHER_PASSES
