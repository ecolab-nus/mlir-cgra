add_mlir_dialect_library(MLIRMorpherTransforms
        MarkMapRegion.cpp
        LegalizeMorpher.cpp
        OutlineMorpherKernels.cpp
        DynamicPassPipeline.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJ_INCLUDE_DIR}/morpher/Dialect/Morpher/Transforms

        DEPENDS
        MLIRMorpherPassIncGen

        LINK_LIBS PUBLIC
        MLIRIR
        MLIRPass
        MLIRTransforms
        MLIRLoopLikeInterface
        MLIRMorpherOps
        )
