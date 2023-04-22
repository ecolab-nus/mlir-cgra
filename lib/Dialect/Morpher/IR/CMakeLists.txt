add_mlir_dialect_library(MLIRMorpherOps
        MorpherOps.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJ_INCLUDE_DIR}/morpher/Dialect/Morpher/IR

        DEPENDS
        MLIRMorpherOpsIncGen

        LINK_LIBS PUBLIC
        MLIRDLTIDialect
        MLIRIR
        MLIRMemRefDialect
        MLIRSideEffectInterfaces
        MLIRSupport
        )
