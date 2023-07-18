//===------ DynamicPipeline.cpp --- dynamic pipeline test pass --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements a pass to test the dynamic pipeline feature.
//
//===----------------------------------------------------------------------===//

#include "PassDetail.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/DialectRegistry.h"
#include "mlir/InitAllDialects.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Parser/Parser.h"
#include "mlir/Dialect/Transform/IR/TransformInterfaces.h"
#include "mlir/Dialect/Transform/IR/TransformOps.h"
#include "mlir/Dialect/Transform/IR/TransformDialect.h"

#include "morpher/Dialect/Morpher/Transforms/Passes.h"

using namespace mlir;
using namespace mlir::morpher;

namespace {

class DynamicPassPipeline
    : public mlir::morpher::DynamicPassPipelineBase<DynamicPassPipeline> {
public:
  DynamicPassPipeline(const std::string &op_name, const std::string &pipeline) {
    this->opName = op_name;
    this->pipeline = pipeline;
  }

  void runOnOperation() override {
    Operation *currentOp = getOperation();

    llvm::errs() << "Dynamic execute '" << pipeline << "' on "
                 << currentOp->getName() << "\n";
    if (pipeline.empty()) {
      llvm::errs() << "Empty pipeline\n";
      return;
    }
    auto symbolOp = dyn_cast<SymbolOpInterface>(currentOp);
    if (!symbolOp) {
      currentOp->emitWarning()
          << "Ignoring because not implementing SymbolOpInterface\n";
      return;
    }

    OpPassManager pm(currentOp->getName().getIdentifier(),
                     OpPassManager::Nesting::Implicit);
    (void)parsePassPipeline(pipeline, pm, llvm::errs());

    // Load dependent dialects for parsed pipelines
    DialectRegistry registry;
    pm.getDependentDialects(registry);
    getContext().appendDialectRegistry(registry);

    if (symbolOp.getName() != getOpName()) {
      llvm::errs() << "Run on nested op\n";
      currentOp->walk([&](Operation *op) {
        if (op == currentOp || !op->hasTrait<OpTrait::IsIsolatedFromAbove>() ||
            op->getName() != currentOp->getName())
          return;
        llvm::errs() << "Run on " << *op << "\n";
        // Run on the current operation
        if (failed(runPipeline(pm, op)))
          signalPassFailure();
      });
    } else {
      // Run on the current operation
      if (failed(runPipeline(pm, currentOp)))
        signalPassFailure();
    }
  }
};

class TransformDialectInterp
    : public TransformDialectInterpBase<TransformDialectInterp> {
public:

  TransformDialectInterp(const std::string &file) {
    this->transformFile = file;
  }

  void runOnOperation() final {
    ModuleOp module = getOperation();

    // Parse transform file if exists
    if (!this->transformFile.empty()) {
      ParserConfig const config(&getContext());
      auto transformOp = mlir::parseSourceFile<ModuleOp>(this->transformFile.getValue(), config);
      if (!transformOp) {
        module.emitOpError("Parse transform file failed");
        return signalPassFailure();
      }

      // Push new transform module to the original one
      BlockAndValueMapping mapper;
      for (auto &op : *transformOp->getBody()) {
        module.getBody()->push_back(op.clone(mapper));
      }
    }

    transform::TransformState state(
        module.getBodyRegion(), module,
        transform::TransformOptions().enableExpensiveChecks(
            enableExpensiveChecks));
    for (auto op :
         module.getBody()->getOps<transform::TransformOpInterface>()) {
      if (failed(state.applyTransform(op).checkAndReport()))
        return signalPassFailure();
    }
  }
};

} // namespace

std::unique_ptr<Pass>
mlir::morpher::createDynamicPassPipelinePass(const std::string &name,
                                             const std::string &pipeline) {
  return std::make_unique<DynamicPassPipeline>(name, pipeline);
}

std::unique_ptr<Pass>
mlir::morpher::createTransformDialectInterpPass(const std::string &file) {
  return std::make_unique<TransformDialectInterp>(file);
}
