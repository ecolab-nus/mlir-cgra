#map = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {input_names = ["A", "B"], output_names = ["C"]} {
    %c0_i32 = arith.constant 0 : i32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<20xi32>
    linalg.fill ins(%c0_i32 : i32) outs(%0 : memref<20xi32>)
    memref.dealloc %0 : memref<20xi32>
    %1 = memref.alloc() {alignment = 128 : i64} : memref<20xi32>
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : memref<20xi32>, memref<20xi32>) outs(%1 : memref<20xi32>) {
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %2 = arith.addi %arg3, %arg4 : i32
      linalg.yield %2 : i32
    }
    memref.copy %1, %arg2 : memref<20xi32> to memref<20xi32>
    return
  }
}

