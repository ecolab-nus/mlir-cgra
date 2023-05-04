#map = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: memref<1024xf32>) {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %c1024 = arith.constant 1024 : index
    %0 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst_0 : f32) outs(%0 : memref<1024xf32>)
    memref.dealloc %0 : memref<1024xf32>
    %c1024_1 = arith.constant 1024 : index
    %1 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst : f32) outs(%1 : memref<1024xf32>)
    %c1024_2 = arith.constant 1024 : index
    %2 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst : f32) outs(%2 : memref<1024xf32>)
    %c0 = arith.constant 0 : index
    %c1024_3 = arith.constant 1024 : index
    %3 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%1, %2 : memref<1024xf32>, memref<1024xf32>) outs(%3 : memref<1024xf32>) {
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %4 = arith.addf %arg1, %arg2 : f32
      linalg.yield %4 : f32
    }
    memref.dealloc %2 : memref<1024xf32>
    memref.dealloc %1 : memref<1024xf32>
    memref.copy %3, %arg0 : memref<1024xf32> to memref<1024xf32>
    return
  }
}

