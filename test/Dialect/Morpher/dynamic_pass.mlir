// RUN: mlir-opt --test-transform-dialect-interpreter -canonicalize %s | FileCheck %s
// RUN: soda-opt --interp-region %s | FileCheck %s
