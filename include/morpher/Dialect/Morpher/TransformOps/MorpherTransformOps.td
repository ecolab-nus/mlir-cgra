#ifndef MORPHER_TRANSFORM_OPS
#define MORPHER_TRANSFORM_OPS

include "mlir/Dialect/Transform/IR/TransformDialect.td"
include "mlir/Dialect/Transform/IR/TransformEffects.td"
include "mlir/Dialect/Transform/IR/TransformInterfaces.td"
include "mlir/Dialect/PDL/IR/PDLTypes.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/IR/OpBase.td"


def OutlineMorpherKernel  : Op<Transform_Dialect, "morpher.outline",
    [FunctionalStyleTransformOpTrait, MemoryEffectsOpInterface,
     DeclareOpInterfaceMethods<TransformOpInterface>]> {
  let summary = "Outlines operations into a named function for morpher";
  let arguments = (ins Variadic<PDL_Operation>:$targets, 
                       StrAttr:$func_name);
  let results = (outs PDL_Operation:$tansformed);
  let assemblyFormat = "$targets attr-dict";
}

#endif // MORPHER_TRANSFORM_OPS