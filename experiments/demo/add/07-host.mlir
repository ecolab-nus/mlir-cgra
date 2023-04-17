#map = affine_map<(d0)[s0] -> (d0 + s0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", soda.container_module} {
  func.func private @cgra_generic_0(memref<20xi32, #map>, memref<20xi32, #map>, memref<20xi32, #map>)
  func.func @main_graph(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {input_names = ["A", "B"], output_names = ["C"]} {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    %c0_i32 = arith.constant 0 : i32
    %0 = memref.alloc() {alignment = 128 : i64} : memref<20xi32>
    linalg.fill ins(%c0_i32 : i32) outs(%0 : memref<20xi32>)
    memref.dealloc %0 : memref<20xi32>
    %1 = memref.alloc() {alignment = 128 : i64} : memref<20xi32>
    scf.for %arg3 = %c0 to %c20 step %c20 {
      %2 = memref.subview %arg0[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %3 = memref.subview %arg1[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %4 = memref.subview %1[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      func.call @cgra_generic_0(%2, %3, %4) : (memref<20xi32, #map>, memref<20xi32, #map>, memref<20xi32, #map>) -> ()
    }
    memref.copy %1, %arg2 : memref<20xi32> to memref<20xi32>
    return
  }
}

