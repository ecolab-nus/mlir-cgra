// RUN: soda-opt --transform-ops-interp --canonicalize %s | FileCheck %s --prefix=NOFILE
// RUN: soda-opt --transform-ops-interp="transform-file=test/Dialect/Morpher/transform-files/tile.mlir" --canonicalize  test/Dialect/Morpher/transform-interp.mlir

#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d3)>

func.func @cgra_kernel(%arg0 : tensor<1x49x40x1xf32>) -> tensor<1x25x20x8xf32> {
    %w = arith.constant dense<1.> : tensor<8x10x8x1xf32>
    %b = arith.constant dense<1.> : tensor<8xf32>

    %conv_out = linalg.init_tensor [1, 25, 20, 8] : tensor<1x25x20x8xf32>

    // compute conv
    %conv = linalg.conv_2d_nhwc_fhwc ins(%arg0, %w : tensor<1x49x40x1xf32>, tensor<8x10x8x1xf32>) outs(%conv_out : tensor<1x25x20x8xf32>) -> tensor<1x25x20x8xf32>

    // add bias
    %conv_bias_out = linalg.init_tensor [1, 25, 20, 8] : tensor<1x25x20x8xf32>
    %add_out = linalg.generic {indexing_maps = [#map1, #map2, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%conv, %b : tensor<1x25x20x8xf32>, tensor<8xf32>) outs(%conv_bias_out : tensor<1x25x20x8xf32>) {
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %16 = arith.addf %arg4, %arg5 : f32
      linalg.yield %16 : f32
    } -> tensor<1x25x20x8xf32>

    return %add_out :  tensor<1x25x20x8xf32>
}
transform.with_pdl_patterns {
  ^bb0(%arg0: !pdl.operation):
    sequence %arg0 failures(propagate) {
      ^bb0(%arg1: !pdl.operation):
        // tile and fuse conv and addf
        %3 = transform.structured.match ops{["linalg.generic"]} in %arg1
        %1, %loops:2 = transform.structured.fuse %3 {tile_sizes = [0, 8, 8, 0]}
    }
}

// NOFILE: #map0 = affine_map<(d0) -> (-d0 + 25, 8)>
// NOFILE: #map1 = affine_map<(d0) -> (-d0 + 20, 8)>
// NOFILE: #map2 = affine_map<(d0, d1) -> (-d0 + 34, d1 + 9)>
// NOFILE: #map3 = affine_map<(d0, d1) -> (-d0 + 27, d1 + 7)>
// NOFILE: #map4 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
// NOFILE: #map5 = affine_map<(d0, d1, d2, d3) -> (d3)>
// NOFILE: module {
// NOFILE:   func.func @cgra_kernel(%arg0: tensor<1x49x40x1xf32>) -> tensor<1x25x20x8xf32> {
// NOFILE:     %c20 = arith.constant 20 : index
// NOFILE:     %c25 = arith.constant 25 : index
// NOFILE:     %c0 = arith.constant 0 : index
// NOFILE:     %c8 = arith.constant 8 : index
// NOFILE:     %cst = arith.constant dense<1.000000e+00> : tensor<8x10x8x1xf32>
// NOFILE:     %cst_0 = arith.constant dense<1.000000e+00> : tensor<8xf32>
// NOFILE:     %0 = linalg.init_tensor [1, 25, 20, 8] : tensor<1x25x20x8xf32>
// NOFILE:     %1 = scf.for %arg1 = %c0 to %c25 step %c8 iter_args(%arg2 = %0) -> (tensor<1x25x20x8xf32>) {
// NOFILE:       %2 = scf.for %arg3 = %c0 to %c20 step %c8 iter_args(%arg4 = %arg2) -> (tensor<1x25x20x8xf32>) {
// NOFILE:         %3 = affine.min #map0(%arg1)
// NOFILE:         %4 = affine.min #map1(%arg3)
// NOFILE:         %5 = affine.min #map0(%arg1)
// NOFILE:         %6 = affine.min #map1(%arg3)
// NOFILE:         %7 = affine.min #map2(%arg1, %3)
// NOFILE:         %8 = affine.min #map3(%arg3, %4)
// NOFILE:         %9 = affine.min #map0(%arg1)
// NOFILE:         %10 = affine.min #map1(%arg3)
// NOFILE:         %11 = tensor.extract_slice %arg0[0, %arg1, %arg3, 0] [1, %7, %8, 1] [1, 1, 1, 1] : tensor<1x49x40x1xf32> to tensor<1x?x?x1xf32>
// NOFILE:         %12 = linalg.init_tensor [1, %9, %10, 8] : tensor<1x?x?x8xf32>
// NOFILE:         %13 = linalg.conv_2d_nhwc_fhwc ins(%11, %cst : tensor<1x?x?x1xf32>, tensor<8x10x8x1xf32>) outs(%12 : tensor<1x?x?x8xf32>) -> tensor<1x?x?x8xf32>
// NOFILE:         %14 = tensor.extract_slice %arg4[0, %arg1, %arg3, 0] [1, %5, %6, 8] [1, 1, 1, 1] : tensor<1x25x20x8xf32> to tensor<1x?x?x8xf32>
// NOFILE:         %15 = linalg.generic {indexing_maps = [#map4, #map5, #map4], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%13, %cst_0 : tensor<1x?x?x8xf32>, tensor<8xf32>) outs(%14 : tensor<1x?x?x8xf32>) {
// NOFILE:         ^bb0(%arg5: f32, %arg6: f32, %arg7: f32):
// NOFILE:           %17 = arith.addf %arg5, %arg6 : f32
// NOFILE:           linalg.yield %17 : f32
// NOFILE:         } -> tensor<1x?x?x8xf32>
// NOFILE:         %16 = tensor.insert_slice %15 into %arg4[0, %arg1, %arg3, 0] [1, %5, %6, 8] [1, 1, 1, 1] : tensor<1x?x?x8xf32> into tensor<1x25x20x8xf32>
// NOFILE:         scf.yield %16 : tensor<1x25x20x8xf32>
// NOFILE:       }
// NOFILE:       scf.yield %2 : tensor<1x25x20x8xf32>
// NOFILE:     }
// NOFILE:     return %1 : tensor<1x25x20x8xf32>
// NOFILE:   }
// NOFILE: }

// -----

#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d3)>

func.func @cgra_kernel(%arg0 : tensor<1x49x40x1xf32>) -> tensor<1x25x20x8xf32> {
    %w = arith.constant dense<1.> : tensor<8x10x8x1xf32>
    %b = arith.constant dense<1.> : tensor<8xf32>

    %conv_out = linalg.init_tensor [1, 25, 20, 8] : tensor<1x25x20x8xf32>

    // compute conv
    %conv = linalg.conv_2d_nhwc_fhwc ins(%arg0, %w : tensor<1x49x40x1xf32>, tensor<8x10x8x1xf32>) outs(%conv_out : tensor<1x25x20x8xf32>) -> tensor<1x25x20x8xf32>

    // add bias
    %conv_bias_out = linalg.init_tensor [1, 25, 20, 8] : tensor<1x25x20x8xf32>
    %add_out = linalg.generic {indexing_maps = [#map1, #map2, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%conv, %b : tensor<1x25x20x8xf32>, tensor<8xf32>) outs(%conv_bias_out : tensor<1x25x20x8xf32>) {
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %16 = arith.addf %arg4, %arg5 : f32
      linalg.yield %16 : f32
    } -> tensor<1x25x20x8xf32>

    return %add_out :  tensor<1x25x20x8xf32>
}