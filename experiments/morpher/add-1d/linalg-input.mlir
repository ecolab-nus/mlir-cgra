#map = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"} {
  transform.with_pdl_patterns {
  ^bb0(%arg0: !pdl.operation):
    sequence %arg0 failures(propagate) {
      ^bb0(%arg1: !pdl.operation):
        %0 = transform.structured.match ops{["linalg.generic"]} in %arg1
        %1, %loops = transform.structured.tile %0 [32]
        // match morpher supported cgra function
        // bufferize
       transform.bufferization.one_shot_bufferize %arg1  {allow_return_allocs=true, bufferize_function_boundaries=true}
       %linalg = transform.structured.match ops{["linalg.generic"]} in %arg1
       %2 = transform.structured.promote %linalg { operands_to_promote = [0, 1, 2], use_full_tiles_by_default }
    }
  }
  
  func.func @main_graph(%arg0: tensor<1024xf32>, %arg1: tensor<1024xf32>) -> tensor<1024xf32> attributes {input_names = ["A", "B"], output_names = ["C"]} {
    %0 = linalg.init_tensor [1024] : tensor<1024xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %cst1 = arith.constant 1.000000e+00 : f32
  
    %c = linalg.fill ins(%cst : f32) outs(%0 : tensor<1024xf32>) -> tensor<1024xf32>
    %a = linalg.fill ins(%cst1 : f32) outs(%arg0 : tensor<1024xf32>) -> tensor<1024xf32>
    %b = linalg.fill ins(%cst1 : f32) outs(%arg1 : tensor<1024xf32>) -> tensor<1024xf32>
  
    %4 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%a, %b : tensor<1024xf32>, tensor<1024xf32>) outs(%c : tensor<1024xf32>) {
    ^bb0(%arg4: f32, %arg5: f32, %arg6: f32):
      %16 = arith.addf %arg4, %arg5 : f32
      linalg.yield %16 : f32
    } -> tensor<1024xf32>
    return %4 : tensor<1024xf32>
  }
}
