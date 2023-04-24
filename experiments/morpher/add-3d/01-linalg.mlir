#map0 = affine_map<(d0, d1, d2)[s0] -> (d0 * 4608 + s0 + d1 * 384 + d2)>
#map1 = affine_map<(d0, d1, d2) -> (0, d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
func.func @generic_0(%arg0: memref<3x3x384xf32, #map0>, %arg1: memref<3x3x384xf32, #map0>) {
  cf.br ^bb1
^bb1:  // pred: ^bb0
  %cst = arith.constant 1.000000e+00 : f32
  linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : memref<1x?x384xf32, #map0>) outs(%arg1 : memref<1x?x384xf32, #map0>) attrs =  {__internal_linalg_transform__ = "offloadedOnCGRA"} {
  ^bb0(%arg2: f32, %arg3: f32):
    %0 = arith.addf %arg2, %cst : f32
    linalg.yield %0 : f32
  }
  return
}
