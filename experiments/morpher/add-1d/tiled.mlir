#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0) -> (d0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {

  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__ } {
      %c0 = arith.constant 0 : index
      %c20 = arith.constant 20 : index
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    scf.for %arg3 = %c0 to %c20 step %c20 {
      %2 = memref.subview %arg0[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %3 = memref.subview %arg1[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %4 = memref.subview %arg2[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%2, %3 : memref<20xi32, #map>, memref<20xi32, #map>) outs(%4 : memref<20xi32, #map>) attrs =  {__internal_linalg_transform__ = "offloadedOnCGRA"} {
      ^bb0(%a3: i32, %arg4: i32, %arg5: i32):
        %0 = arith.addi %a3, %arg4 : i32
        linalg.yield %0 : i32
      }
   }
   return
  }

  func.func @main() {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index

    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32

    %a = memref.alloc() : memref<20xi32>
    %b = memref.alloc() : memref<20xi32>
    %c = memref.alloc() : memref<20xi32>

    linalg.fill ins(%c1_i32 : i32) outs(%a : memref<20xi32>)
    linalg.fill ins(%c1_i32 : i32) outs(%b : memref<20xi32>)
    linalg.fill ins(%c0_i32 : i32) outs(%c : memref<20xi32>)

    func.call @array_add(%a, %b, %c) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()

    memref.dealloc %a : memref<20xi32>
    memref.dealloc %b : memref<20xi32>
    memref.dealloc %c : memref<20xi32>
    return
  }
}

