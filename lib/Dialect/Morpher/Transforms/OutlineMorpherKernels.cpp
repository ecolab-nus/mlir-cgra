//===- OutlineMorpherKernels.cpp -------------===//
//--------------------------------------------===//

#include "PassDetail.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Pass/Pass.h"
#include "morpher/Dialect/Morpher/IR/MorpherDialect.h"
#include "morpher/Dialect/Morpher/Transforms/Passes.h"

#include "mlir/IR/ImplicitLocOpBuilder.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Interfaces/LoopLikeInterface.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Transforms/DialectConversion.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

#define DEBUG_TYPE "outline-morpher-kernels"

using namespace mlir;
using namespace mlir::morpher;

//namespace {
//
//class OutlineMorpherKernels :
//    public OutlineMorpherKernelsBase<OutlineMorpherKernels> {
//public:
//  void runOnOperation() override {
//
//  }
//
//};
//
//} // namespace
//
//std::unique_ptr<mlir::OperationPass<ModuleOp>> mlir::morpher::createOutlineMorpherKernelPass() {
//  return std::make_unique<OutlineMorpherKernels>();
//}
