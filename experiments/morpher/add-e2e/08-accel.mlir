#map = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<256xf32>, %arg1: memref<256xf32>, %arg2: memref<256xf32>) attributes {__morpher_kernel__} {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : memref<256xf32>, memref<256xf32>) outs(%arg2 : memref<256xf32>) attrs =  {__internal_linalg_transform__ = "offloadedOnCGRA"} {
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %0 = arith.addf %arg3, %arg4 : f32
      linalg.yield %0 : f32
    }
    return
  }
}

