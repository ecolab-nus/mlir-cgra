#map0 = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: memref<1024xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c1024 = arith.constant 1024 : index
    %c256 = arith.constant 256 : index
    %cst_0 = arith.constant 1.000000e+00 : f32
    %cst_1 = arith.constant 2.000000e+00 : f32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst_1 : f32) outs(%0 : memref<1024xf32>)
    memref.dealloc %0 : memref<1024xf32>
    %1 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst_0 : f32) outs(%1 : memref<1024xf32>)
    %2 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst_0 : f32) outs(%2 : memref<1024xf32>)
    %3 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    scf.for %arg1 = %c0 to %c1024 step %c256 {
      %4 = memref.subview %1[%arg1] [256] [1] : memref<1024xf32> to memref<256xf32, #map0>
      %5 = memref.subview %2[%arg1] [256] [1] : memref<1024xf32> to memref<256xf32, #map0>
      %6 = memref.subview %3[%arg1] [256] [1] : memref<1024xf32> to memref<256xf32, #map0>
      %7 = memref.alloc() : memref<1024xi8>
      %8 = memref.view %7[%c0][] : memref<1024xi8> to memref<256xf32>
      linalg.fill ins(%cst : f32) outs(%8 : memref<256xf32>)
      %9 = memref.alloc() : memref<1024xi8>
      %10 = memref.view %9[%c0][] : memref<1024xi8> to memref<256xf32>
      linalg.fill ins(%cst : f32) outs(%10 : memref<256xf32>)
      %11 = memref.alloc() : memref<1024xi8>
      %12 = memref.view %11[%c0][] : memref<1024xi8> to memref<256xf32>
      linalg.fill ins(%cst : f32) outs(%12 : memref<256xf32>)
      memref.copy %4, %8 : memref<256xf32, #map0> to memref<256xf32>
      memref.copy %5, %10 : memref<256xf32, #map0> to memref<256xf32>
      memref.copy %6, %12 : memref<256xf32, #map0> to memref<256xf32>
      linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%8, %10 : memref<256xf32>, memref<256xf32>) outs(%12 : memref<256xf32>) attrs =  {__internal_linalg_transform__ = "offloadedOnCGRA"} {
      ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
        %13 = arith.addf %arg2, %arg3 : f32
        linalg.yield %13 : f32
      }
      memref.copy %12, %6 : memref<256xf32> to memref<256xf32, #map0>
      memref.dealloc %7 : memref<1024xi8>
      memref.dealloc %9 : memref<1024xi8>
      memref.dealloc %11 : memref<1024xi8>
    }
    memref.dealloc %2 : memref<1024xf32>
    memref.dealloc %1 : memref<1024xf32>
    memref.copy %3, %arg0 : memref<1024xf32> to memref<1024xf32>
    return
  }
}

