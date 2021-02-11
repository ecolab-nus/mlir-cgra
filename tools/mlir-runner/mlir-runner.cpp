//===- mlir-runner.cpp ---------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/ExecutionEngine/JitRunner.h"
#include "mlir/ExecutionEngine/OptUtils.h"
#include "mlir/IR/Dialect.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/TargetSelect.h"

int main(int argc, char **argv) {
  llvm::InitLLVM y(argc, argv);
  llvm::InitializeNativeTarget();
  llvm::InitializeNativeTargetAsmPrinter();
  llvm::InitializeNativeTargetAsmParser();
  mlir::initializeLLVMPasses();

  mlir::DialectRegistry registry;
  registry.insert<mlir::LLVM::LLVMDialect>();
  return mlir::JitRunnerMain(argc, argv, registry);
}
