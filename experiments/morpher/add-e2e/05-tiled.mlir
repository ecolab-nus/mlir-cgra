#map0 = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu"} {
  transform.with_pdl_patterns {
  ^bb0(%arg0: !pdl.operation):
    sequence %arg0 failures(propagate) {
      ^bb0(%arg1: !pdl.operation):
        %0 = transform.structured.match ops{["linalg.generic"]} in %arg1
        //%1, %loops = transform.structured.tile %0 [32]
        // match morpher supported cgra function


        // bufferize
       //transform.bufferization.one_shot_bufferize %arg1  {allow_return_allocs=true, bufferize_function_boundaries=true}


       %linalg = transform.structured.match ops{["linalg.generic"]} in %arg1
       %2 = transform.structured.promote %linalg { operands_to_promote = [0, 1, 2], use_full_tiles_by_default }
    }
  }
  func.func @main_graph(%arg0: memref<1024xf32>) {
    %c0 = arith.constant 0 : index
    %c1024 = arith.constant 1024 : index
    %c256 = arith.constant 256 : index
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst_0 : f32) outs(%0 : memref<1024xf32>)
    memref.dealloc %0 : memref<1024xf32>
    %1 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst : f32) outs(%1 : memref<1024xf32>)
    %2 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    linalg.fill ins(%cst : f32) outs(%2 : memref<1024xf32>)
    %3 = memref.alloc() {alignment = 128 : i64} : memref<1024xf32>
    scf.for %arg1 = %c0 to %c1024 step %c256 {
      %4 = memref.subview %1[%arg1] [256] [1] : memref<1024xf32> to memref<256xf32, #map0>
      %5 = memref.subview %2[%arg1] [256] [1] : memref<1024xf32> to memref<256xf32, #map0>
      %6 = memref.subview %3[%arg1] [256] [1] : memref<1024xf32> to memref<256xf32, #map0>
      linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%4, %5 : memref<256xf32, #map0>, memref<256xf32, #map0>) outs(%6 : memref<256xf32, #map0>) attrs =  {__internal_linalg_transform__ = "offloadedOnCGRA"} {
      ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
        %7 = arith.addf %arg2, %arg3 : f32
        linalg.yield %7 : f32
      }
    }
    memref.dealloc %2 : memref<1024xf32>
    memref.dealloc %1 : memref<1024xf32>
    memref.copy %3, %arg0 : memref<1024xf32> to memref<1024xf32>
    return
  }
}

