// RUN: soda-opt --mark-map-region %s | FileCheck %s
func.func @map_me(%arg0: memref<1x?x384xf32, affine_map<(d0, d1, d2)[s0] -> (d0 * 4608 + s0 + d1 * 384 + d2)>>, %arg1: memref<1x?x384xf32, affine_map<(d0, d1, d2)[s0] -> (d0 * 4608 + s0 + d1 * 384 + d2)>>) {
  %c1 = arith.constant 1 : index
  %c0 = arith.constant 0 : index
  %cst = arith.constant 1.000000e+00 : f32
  cf.br ^bb1
^bb1:  // pred: ^bb0
  %0 = memref.dim %arg0, %c1 : memref<1x?x384xf32, affine_map<(d0, d1, d2)[s0] -> (d0 * 4608 + s0 + d1 * 384 + d2)>>
  affine.for %arg2 = 0 to 1 {
    affine.for %arg3 = 0 to %0 {
      affine.for %arg4 = 0 to 384 {
        // CHECK: affine.for 
        // CHECK: morpher.map_hint
        // CHECK: affine.load
        // CHECK-NOT: affine.for
        %1 = affine.load %arg0[%c0, %arg3, %arg4] : memref<1x?x384xf32, affine_map<(d0, d1, d2)[s0] -> (d0 * 4608 + s0 + d1 * 384 + d2)>>
        %2 = arith.addf %1, %cst : f32
        affine.store %2, %arg1[%arg2, %arg3, %arg4] : memref<1x?x384xf32, affine_map<(d0, d1, d2)[s0] -> (d0 * 4608 + s0 + d1 * 384 + d2)>>
      }
    }
  }
  return
}