add_mlir_dialect_library(SODAMisc
        MiscPasses.cpp
        AffineDataCopyGen.cpp
        AffineLoopTiling.cpp
        AffineLoopPermutation.cpp
        MemrefEraseDealloc.cpp
        ForwardMemrefAlloc.cpp
        ForwardLinalgOps.cpp
        LinalgTilingForCGRA.cpp
        FuncToLLVM.cpp
        Common.cpp
        MemRef.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/

        DEPENDS
        MLIRSODAMiscPassesIncGen

        LINK_LIBS PUBLIC
        MLIRIR
        MLIRPass
        )
