set(LLVM_TARGET_DEFINITIONS MorpherTransformOps.td)
mlir_tablegen(MorpherTransformOps.h.inc -gen-op-decls)
mlir_tablegen(MorpherTransformOps.cpp.inc -gen-op-defs)
add_public_tablegen_target(MLIRMorpherTransformOpsIncGen)

#add_mlir_doc(MorpherTransformOps Dialects/ -gen-op-doc)
