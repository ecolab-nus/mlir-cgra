#map0 = affine_map<(d0, d1, d2, d3)[s0, s1, s2, s3, s4] -> (d0 * s1 + s0 + d1 * s2 + d2 * s3 + d3 * s4)>
#map1 = affine_map<(d0) -> (-d0 + 6, 4)>
#map2 = affine_map<(d0, d1, d2, d3)[s0] -> (d0 * 128 + s0 + d1 * 32 + d2 * 8 + d3)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0 * 16 + d1 * 4 + d2 + d3)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu"} {
  memref.global "private" constant @__constant_8x3x3x1xf32 : memref<8x3x3x1xf32> = dense<1.000000e+00> {alignment = 128 : i64}
  func.func @cgra_kernel(%arg0: memref<1x6x6x1xf32, #map0>) -> memref<1x4x4x8xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %0 = memref.get_global @__constant_8x3x3x1xf32 : memref<8x3x3x1xf32>
    %1 = memref.alloc() {alignment = 128 : i64} : memref<1x4x4x8xf32>
    scf.for %arg1 = %c0 to %c4 step %c2 {
      scf.for %arg2 = %c0 to %c4 step %c2 {
        %2 = affine.min #map1(%arg1)
        %3 = affine.min #map1(%arg2)
        %4 = memref.subview %arg0[0, %arg1, %arg2, 0] [1, %2, %3, 1] [1, 1, 1, 1] : memref<1x6x6x1xf32, #map0> to memref<1x?x?x1xf32, #map0>
        %5 = memref.subview %1[0, %arg1, %arg2, 0] [1, 2, 2, 8] [1, 1, 1, 1] : memref<1x4x4x8xf32> to memref<1x2x2x8xf32, #map2>
        %6 = memref.alloc() : memref<64xi8>
        %7 = memref.view %6[%c0][] : memref<64xi8> to memref<1x4x4x1xf32>
        %8 = memref.subview %7[0, 0, 0, 0] [1, %2, %3, 1] [1, 1, 1, 1] : memref<1x4x4x1xf32> to memref<1x?x?x1xf32, #map3>
        linalg.fill ins(%cst : f32) outs(%7 : memref<1x4x4x1xf32>)
        %9 = memref.alloc() : memref<128xi8>
        %10 = memref.view %9[%c0][] : memref<128xi8> to memref<1x2x2x8xf32>
        linalg.fill ins(%cst : f32) outs(%10 : memref<1x2x2x8xf32>)
        memref.copy %4, %8 : memref<1x?x?x1xf32, #map0> to memref<1x?x?x1xf32, #map3>
        memref.copy %5, %10 : memref<1x2x2x8xf32, #map2> to memref<1x2x2x8xf32>
        linalg.conv_2d_nhwc_fhwc ins(%7, %0 : memref<1x4x4x1xf32>, memref<8x3x3x1xf32>) outs(%10 : memref<1x2x2x8xf32>)
        memref.copy %10, %5 : memref<1x2x2x8xf32> to memref<1x2x2x8xf32, #map2>
        memref.dealloc %6 : memref<64xi8>
        memref.dealloc %9 : memref<128xi8>
        %11 = memref.subview %1[0, %arg1, %arg2, 0] [1, 2, 2, 8] [1, 1, 1, 1] : memref<1x4x4x8xf32> to memref<1x2x2x8xf32, #map2>
        memref.copy %5, %11 : memref<1x2x2x8xf32, #map2> to memref<1x2x2x8xf32, #map2>
      }
    }
    return %1 : memref<1x4x4x8xf32>
  }
}

