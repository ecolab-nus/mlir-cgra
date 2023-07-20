
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d3)>

module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu"} {

func.func @cgra_kernel(%arg0 : tensor<1x6x6x1xf32>) -> tensor<1x4x4x8xf32> {
    %w = arith.constant dense<1.> : tensor<8x3x3x1xf32>
    %b = arith.constant dense<1.> : tensor<8xf32>

    %conv_out = linalg.init_tensor [1, 4, 4, 8] : tensor<1x4x4x8xf32>

    // compute conv
    %conv = linalg.conv_2d_nhwc_fhwc ins(%arg0, %w : tensor<1x6x6x1xf32>, tensor<8x3x3x1xf32>) outs(%conv_out : tensor<1x4x4x8xf32>) -> tensor<1x4x4x8xf32>

    // // add bias
    // %conv_bias_out = linalg.init_tensor [1, 25, 20, 8] : tensor<1x25x20x8xf32>
    // %add_out = linalg.generic {indexing_maps = [#map1, #map2, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%conv, %b : tensor<1x25x20x8xf32>, tensor<8xf32>) outs(%conv_bias_out : tensor<1x25x20x8xf32>) {
    // ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
    //   %16 = arith.addf %arg4, %arg5 : f32
    //   linalg.yield %16 : f32
    // } -> tensor<1x25x20x8xf32>

    return %conv : tensor<1x4x4x8xf32>
    // return %add_out :  tensor<1x25x20x8xf32>
}

}