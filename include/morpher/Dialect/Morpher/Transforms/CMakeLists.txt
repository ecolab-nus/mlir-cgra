set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name Morpher)
add_public_tablegen_target(MLIRMorpherPassIncGen)

add_mlir_doc(Passes MorpherPasses ./ -gen-pass-doc)
