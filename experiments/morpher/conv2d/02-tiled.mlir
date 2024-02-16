#map = affine_map<(d0) -> (-d0 + 6, 4)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu"} {
  func.func @cgra_kernel(%arg0: tensor<1x6x6x1xf32>) -> tensor<1x4x4x8xf32> {
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %cst = arith.constant dense<1.000000e+00> : tensor<8x3x3x1xf32>
    %0 = linalg.init_tensor [1, 4, 4, 8] : tensor<1x4x4x8xf32>
    %1 = scf.for %arg1 = %c0 to %c4 step %c2 iter_args(%arg2 = %0) -> (tensor<1x4x4x8xf32>) {
      %2 = scf.for %arg3 = %c0 to %c4 step %c2 iter_args(%arg4 = %arg2) -> (tensor<1x4x4x8xf32>) {
        %3 = affine.min #map(%arg1)
        %4 = affine.min #map(%arg3)
        %5 = tensor.extract_slice %arg0[0, %arg1, %arg3, 0] [1, %3, %4, 1] [1, 1, 1, 1] : tensor<1x6x6x1xf32> to tensor<1x?x?x1xf32>
        %6 = tensor.extract_slice %arg4[0, %arg1, %arg3, 0] [1, 2, 2, 8] [1, 1, 1, 1] : tensor<1x4x4x8xf32> to tensor<1x2x2x8xf32>
        %7 = linalg.conv_2d_nhwc_fhwc ins(%5, %cst : tensor<1x?x?x1xf32>, tensor<8x3x3x1xf32>) outs(%6 : tensor<1x2x2x8xf32>) -> tensor<1x2x2x8xf32>
        %8 = tensor.insert_slice %7 into %arg4[0, %arg1, %arg3, 0] [1, 2, 2, 8] [1, 1, 1, 1] : tensor<1x2x2x8xf32> into tensor<1x4x4x8xf32>
        scf.yield %8 : tensor<1x4x4x8xf32>
      }
      scf.yield %2 : tensor<1x4x4x8xf32>
    }
    return %1 : tensor<1x4x4x8xf32>
  }
}

