//===- MorpherDialect.h - MLIR Dialect for Morpher ------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef MORPHER_DIALECT_MORPHER_MORPHERDIALECT_H
#define MORPHER_DIALECT_MORPHER_MORPHERDIALECT_H


#include "mlir/IR/Builders.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/FunctionInterfaces.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#include "morpher/Dialect/Morpher/IR/MorpherOpsDialect.h.inc"

#define GET_OP_CLASSES
#include "morpher/Dialect/Morpher/IR/MorpherOps.h.inc"

#endif // MORPHER_DIALECT_MORPHER_MORPHERDIALECT_H
