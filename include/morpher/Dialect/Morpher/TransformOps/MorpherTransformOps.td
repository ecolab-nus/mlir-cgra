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

def RunPassPipeline : Op<Transform_Dialect, "morpher.run_passpipeline",
                        [DeclareOpInterfaceMethods<TransformOpInterface>,
                                DeclareOpInterfaceMethods<MemoryEffectsOpInterface>]> {
  let summary = "Run passpipeline by parse the commandline string.";
  let arguments = (ins StrAttr:$pass_pipeline,
                       DefaultValuedStrAttr<StrAttr, "::mlir::ModuleOp::getOpName()">:$op_name,
                     Optional<PDL_Operation>:$container_op);
  let assemblyFormat = [{
    $container_op `(` $pass_pipeline `)` attr-dict
  }];
}

def Print : Op<Transform_Dialect, "morpher.print", [DeclareOpInterfaceMethods<TransformOpInterface>, 
                                                    DeclareOpInterfaceMethods<MemoryEffectsOpInterface>]> {
  let summary = "Print the given operation";
  let arguments = (ins Optional<PDL_Operation>:$target, OptionalAttr<StrAttr>:$comment);
  let assemblyFormat = "$target attr-dict";
}

#endif // MORPHER_TRANSFORM_OPS
