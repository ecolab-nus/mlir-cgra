//===- HostGeneration.cpp - Implementation of host call generation --------===//
//===----------------------------------------------------------------------===//
//
// This file implements the SODA dialect host genration pass.
//
// It transforms soda.launch_func operations in the host code into call to the
// bambu host api.
//
//===----------------------------------------------------------------------===//

#include "mlir/Conversion/LLVMCommon/Pattern.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "morpher/Dialect/Morpher/IR/MorpherDialect.h"
#include "mlir/IR/BuiltinDialect.h"
#include "mlir/IR/ImplicitLocOpBuilder.h"

#include "PassDetail.h"
#include "soda/Dialect/SODA/Passes.h"
#include "soda/Dialect/SODA/SODADialect.h"
#include "soda/Dialect/SODA/Utils.h"

#include <iostream>
#include <map>
#include <string>

using namespace std;
using namespace mlir;

namespace {

class SodaHostGenerationPass
    : public SodaHostGenerationBase<SodaHostGenerationPass> {
public:
  void runOnOperation() override {

    RewritePatternSet patterns(&getContext());
    soda::populateHostGenerationConversionPatterns(patterns);
    ConversionTarget target(getContext());
    target.addLegalDialect<func::FuncDialect, BuiltinDialect>();
    if (failed(applyPartialConversion(getOperation(), target,
                                      std::move(patterns)))) {
      signalPassFailure();
    }
  }
};

} // namespace

namespace {

class CGRAHostGenerationPass
    : public CGRAHostGenerationBase<CGRAHostGenerationPass> {
public:
  void runOnOperation() override {

    RewritePatternSet patterns(&getContext());
    soda::populateCGRAHostGenerationConversionPatterns(patterns, this->genMorpherKernel);
    ConversionTarget target(getContext());
    target.addLegalDialect<func::FuncDialect, BuiltinDialect>();
    if (failed(applyPartialConversion(getOperation(), target,
                                      std::move(patterns)))) {
      signalPassFailure();
    }
  }
};

} // namespace

namespace {
class SODALaunchFuncLowering : public OpRewritePattern<soda::LaunchFuncOp> {
public:
  using OpRewritePattern<soda::LaunchFuncOp>::OpRewritePattern;

  LogicalResult matchAndRewrite(soda::LaunchFuncOp op,
                                PatternRewriter &rewriter) const override {

    ModuleOp module = op->getParentOfType<ModuleOp>();

    // Build final function name
    auto newName =
        (Twine(op.getKernelModuleName()) + "_" + Twine(op.getKernelName()))
            .str();

    auto func = module.lookupSymbol<func::FuncOp>(newName);

    if (!func) {

      // Get callee
      Operation *kernelFunc = module.lookupSymbol(op.kernelAttr());
      auto kernelSODAFunction = dyn_cast_or_null<soda::SODAFuncOp>(kernelFunc);

      // Add a private function with same prototype on the top of parent module
      OpBuilder::InsertionGuard guard(rewriter);
      rewriter.setInsertionPointToStart(module.getBody());
      FunctionType funcTy = kernelSODAFunction.getFunctionType();
      func::FuncOp func = rewriter.create<func::FuncOp>(
          rewriter.getUnknownLoc(), newName, funcTy);
      func.setPrivate();

      rewriter.setInsertionPoint(op);
    }

    assert(
        isa<FunctionOpInterface>(SymbolTable::lookupSymbolIn(module, newName)));

    rewriter.replaceOpWithNewOp<func::CallOp>(op, TypeRange{}, newName,
                                              op.getOperands());

    return success();
  }
};

class SODALaunchCGRALowering : public OpRewritePattern<soda::LaunchCGRAOp> {
public:
  using OpRewritePattern<soda::LaunchCGRAOp>::OpRewritePattern;
  bool morpherKernel;

  SODALaunchCGRALowering(MLIRContext *context, bool morpherK)
      : morpherKernel(morpherK), OpRewritePattern<soda::LaunchCGRAOp>(context) {
  }

  LogicalResult matchAndRewrite(soda::LaunchCGRAOp op,
                                PatternRewriter &rewriter) const override {

    ModuleOp module = op->getParentOfType<ModuleOp>();

    // Build final function name
    auto newName = "cgra_" + Twine(op.getKernelName()).str();
    auto func = module.lookupSymbol<func::FuncOp>(newName);

    // std::cout<<"found func... "<<newName<<std::endl;
    while (func) {
      newName += "_";
      func = module.lookupSymbol<func::FuncOp>(newName);
    }

    // Get callee
    Operation *kernelFunc = module.lookupSymbol(op.kernelAttr());
    auto kernelSODAFunction = dyn_cast_or_null<soda::SODAFuncOp>(kernelFunc);

    // Add a private function with same prototype on the top of parent module
    OpBuilder::InsertionGuard guard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    if (kernelSODAFunction == NULL)
      std::cout << "kernelSODAFunction is NULL" << std::endl;
    FunctionType funcTy = kernelSODAFunction.getFunctionType();
    func::FuncOp updatedFunc = rewriter.create<func::FuncOp>(
        rewriter.getUnknownLoc(), newName, funcTy);
    updatedFunc.setPrivate();

    rewriter.setInsertionPoint(op);
    // }

    assert(
        isa<FunctionOpInterface>(SymbolTable::lookupSymbolIn(module, newName)));

    auto callOp = rewriter.replaceOpWithNewOp<func::CallOp>(op, TypeRange{}, newName,
                                              op.getOperands());

    if (morpherKernel) {
      callOp->setAttr(morpher::MorpherDialect::morpherKernelAttrName(), rewriter.getUnitAttr());
    }

    return success();
  }
};

class SODAModuleDeletion : public OpRewritePattern<soda::SODAModuleOp> {
public:
  using OpRewritePattern<soda::SODAModuleOp>::OpRewritePattern;

  LogicalResult matchAndRewrite(soda::SODAModuleOp op,
                                PatternRewriter &rewriter) const override {
    rewriter.eraseOp(op);
    return success();
  }
};

} // namespace

void soda::populateHostGenerationConversionPatterns(
    RewritePatternSet &patterns) {
  // clang-format off
  patterns.add<
      SODALaunchFuncLowering,
      SODAModuleDeletion
      >(patterns.getContext());
  // clang-format on
}

void soda::populateCGRAHostGenerationConversionPatterns(
    RewritePatternSet &patterns, bool morpherKernel) {
  // clang-format off
  patterns.add<SODAModuleDeletion>(patterns.getContext());
  patterns.add<SODALaunchCGRALowering>(patterns.getContext(), morpherKernel);
  // clang-format on
}

std::unique_ptr<Pass> mlir::soda::createSodaHostGenerationPass() {
  return std::make_unique<SodaHostGenerationPass>();
}

std::unique_ptr<Pass> mlir::soda::createCGRAHostGenerationPass() {
  return std::make_unique<CGRAHostGenerationPass>();
}