module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    linalg.conv_2d_nhwc_fhwc ins(%arg0, %arg1 : memref<1x4x4x1xf32>, memref<8x3x3x1xf32>) outs(%arg2 : memref<1x2x2x8xf32>)
    return
  }
}

