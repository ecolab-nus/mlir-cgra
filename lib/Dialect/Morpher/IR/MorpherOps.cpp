//===- MorpherDialect.cpp - MLIR Dialect for Morpher Kernels implementation -----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
#include "morpher/Dialect/Morpher/IR/MorpherDialect.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/FunctionImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/TypeUtilities.h"
#include "llvm/ADT/TypeSwitch.h"

#include <iostream>


using namespace mlir;
using namespace mlir::morpher;

#include "morpher/Dialect/Morpher/IR/MorpherOpsDialect.cpp.inc"

void mlir::morpher::MorpherDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "morpher/Dialect/Morpher/IR/MorpherOps.cpp.inc"
  >();
}

#define GET_OP_CLASSES
#include "morpher/Dialect/Morpher/IR/MorpherOps.cpp.inc"