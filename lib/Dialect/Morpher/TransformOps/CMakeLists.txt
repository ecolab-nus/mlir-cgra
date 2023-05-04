add_mlir_dialect_library(MLIRMorpherTransformOps
  MorpherTransformOps.cpp
  Utils.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJ_INCLUDE_DIR}/morpher/Dialect/Morpher/TransformsOps

  DEPENDS
  MLIRMorpherTransformOpsIncGen

  LINK_LIBS PUBLIC
  MLIRAffineDialect
  MLIRArithmeticDialect
  MLIRIR
  MLIRLinalgDialect
  MLIRLinalgTransforms
  MLIRParser
  MLIRPDLDialect
  MLIRSCFDialect
  MLIRSideEffectInterfaces
  MLIRTransformDialect
  MLIRVectorDialect
  )
