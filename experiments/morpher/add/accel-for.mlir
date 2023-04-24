func.func private @please_map_me()

func.func @generic_0(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) {
  cf.br ^bb1
^bb1:  // pred: ^bb0
  affine.for %arg3 = 0 to 20 {
    func.call @please_map_me() : () -> ()    
    %0 = affine.load %arg0[%arg3] : memref<20xi32>
    %1 = affine.load %arg1[%arg3] : memref<20xi32>
    %2 = arith.addi %0, %1 : i32
    affine.store %2, %arg2[%arg3] : memref<20xi32>
  }
  return
}