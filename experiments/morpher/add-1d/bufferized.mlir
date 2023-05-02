#map0 = affine_map<(d0)[s0, s1] -> (d0 * s1 + s0)>
#map1 = affine_map<(d0)[s0] -> (d0 + s0)>
#map2 = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: memref<1024xf32, #map0>, %arg1: memref<1024xf32, #map0>) -> memref<1024xf32> attributes {input_names = ["A", "B"], output_names = ["C"]} {
    %c0 = arith.constant 0 : index
    %c32 = arith.constant 32 : index
    %c1024 = arith.constant 1024 : index
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 0.000000e+00 : f32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst_0 : f32) outs(%0 : memref<1024xf32>)
    linalg.fill ins(%cst : f32) outs(%arg0 : memref<1024xf32, #map0>)
    linalg.fill ins(%cst : f32) outs(%arg1 : memref<1024xf32, #map0>)
    scf.for %arg2 = %c0 to %c1024 step %c32 {
      %1 = memref.subview %arg0[%arg2] [32] [1] : memref<1024xf32, #map0> to memref<32xf32, #map0>
      %2 = memref.subview %arg1[%arg2] [32] [1] : memref<1024xf32, #map0> to memref<32xf32, #map0>
      %3 = memref.subview %0[%arg2] [32] [1] : memref<1024xf32> to memref<32xf32, #map1>
      %4 = memref.alloc() : memref<128xi8>
      %5 = memref.view %4[%c0][] : memref<128xi8> to memref<32xf32>
      linalg.fill ins(%cst_0 : f32) outs(%5 : memref<32xf32>)
      %6 = memref.alloc() : memref<128xi8>
      %7 = memref.view %6[%c0][] : memref<128xi8> to memref<32xf32>
      linalg.fill ins(%cst_0 : f32) outs(%7 : memref<32xf32>)
      %8 = memref.alloc() : memref<128xi8>
      %9 = memref.view %8[%c0][] : memref<128xi8> to memref<32xf32>
      linalg.fill ins(%cst_0 : f32) outs(%9 : memref<32xf32>)
      memref.copy %1, %5 : memref<32xf32, #map0> to memref<32xf32>
      memref.copy %2, %7 : memref<32xf32, #map0> to memref<32xf32>
      memref.copy %3, %9 : memref<32xf32, #map1> to memref<32xf32>
      linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel"]} ins(%5, %7 : memref<32xf32>, memref<32xf32>) outs(%9 : memref<32xf32>) {
      ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
        %11 = arith.addf %arg3, %arg4 : f32
        linalg.yield %11 : f32
      }
      memref.copy %9, %3 : memref<32xf32> to memref<32xf32, #map1>
      memref.dealloc %4 : memref<128xi8>
      memref.dealloc %6 : memref<128xi8>
      memref.dealloc %8 : memref<128xi8>
      %10 = memref.subview %0[%arg2] [32] [1] : memref<1024xf32> to memref<32xf32, #map1>
      memref.copy %3, %10 : memref<32xf32, #map1> to memref<32xf32, #map1>
    }
    return %0 : memref<1024xf32>
  }
}

