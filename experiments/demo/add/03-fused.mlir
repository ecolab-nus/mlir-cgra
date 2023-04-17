#map = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  func.func @main_graph(%arg0: tensor<20xi32>, %arg1: tensor<20xi32>) -> tensor<20xi32> attributes {input_names = ["A", "B"], output_names = ["C"]} {
    %cst = arith.constant 0 : i32
    %0 = linalg.init_tensor [20] : tensor<20xi32>
    %1 = linalg.fill ins(%cst : i32) outs(%0 : tensor<20xi32>) -> tensor<20xi32>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1: tensor<20xi32>, tensor<20xi32>) outs(%1 : tensor<20xi32>) {
    ^bb0(%arg4: i32, %arg5: i32, %arg7: i32):
      %5 = arith.addi %arg4, %arg5 : i32
      linalg.yield %5 : i32
    } -> tensor<20xi32>
    return %4 : tensor<20xi32>
  }
}

