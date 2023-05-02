//===-- MorpherOps.td - Morpher dialect operation definitions ----*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Defines some operations of the Morpher dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MORPHER_MORPHER_OPS
#define MORPHER_MORPHER_OPS

include "mlir/IR/OpBase.td"

def Morpher_Dialect : Dialect {
  let name = "morpher";
  let cppNamespace = "::mlir::morpher";
  let extraClassDeclaration = [{
  static llvm::StringRef morpherKernelAttrName() { return "__morpher_kernel__"; }
  }];
}

class Morpher_Op<string mnemonic, list<Trait> traits = []> :
    Op<Morpher_Dialect, mnemonic, traits>;

def Morpher_MapHintOp : Morpher_Op<"map_hint"> {
  let summary = "A hint for mapping a morpher kernel";
  let assemblyFormat = "attr-dict";
  let extraClassDeclaration = [{
  static llvm::StringRef mapHintFuncName() { return "please_map_me"; }
  }];
}

#endif // MORPHER_MORPHER_OPS
