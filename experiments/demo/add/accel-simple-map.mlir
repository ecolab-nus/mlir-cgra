#map1 = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%arg0, %arg1 : memref<20xi32>, memref<20xi32>) outs(%arg2 : memref<20xi32>) attrs =  {__internal_linalg_transform__ = "offloadedOnCGRA"} {
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %0 = arith.addi %arg3, %arg4 : i32
      linalg.yield %0 : i32
    }
    return
  }
}

