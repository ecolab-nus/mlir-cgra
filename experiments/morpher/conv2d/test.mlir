  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c1_0 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c1 step %c1_0 {
      %c0_1 = arith.constant 0 : index
      %c2 = arith.constant 2 : index
      %c1_2 = arith.constant 1 : index
      scf.for %arg4 = %c0_1 to %c2 step %c1_2 {
        %c0_3 = arith.constant 0 : index
        %c2_4 = arith.constant 2 : index
        %c1_5 = arith.constant 1 : index
        scf.for %arg5 = %c0_3 to %c2_4 step %c1_5 {
          %c0_6 = arith.constant 0 : index
          %c8 = arith.constant 8 : index
          %c1_7 = arith.constant 1 : index
          scf.for %arg6 = %c0_6 to %c8 step %c1_7 {
            %c0_8 = arith.constant 0 : index
            %c3 = arith.constant 3 : index
            %c1_9 = arith.constant 1 : index
            scf.for %arg7 = %c0_8 to %c3 step %c1_9 {
              %c0_10 = arith.constant 0 : index
              %c3_11 = arith.constant 3 : index
              %c1_12 = arith.constant 1 : index
              scf.for %arg8 = %c0_10 to %c3_11 step %c1_12 {
                %c0_13 = arith.constant 0 : index
                %c1_14 = arith.constant 1 : index
                %c1_15 = arith.constant 1 : index
                scf.for %arg9 = %c0_13 to %c1_14 step %c1_15 {
                  func.call @please_map_me() : () -> ()
                  %0 = arith.addi %arg4, %arg7 : index
                  %1 = arith.addi %arg5, %arg8 : index
                  %2 = memref.load %arg0[%arg3, %0, %1, %arg9] : memref<1x4x4x1xf32>
                  %3 = memref.load %arg1[%arg6, %arg7, %arg8, %arg9] : memref<8x3x3x1xf32>
                  %4 = memref.load %arg2[%arg3, %arg4, %arg5, %arg6] : memref<1x2x2x8xf32>
                  %5 = arith.mulf %2, %3 : f32
                  %6 = arith.addf %4, %5 : f32
                  memref.store %6, %arg2[%arg3, %arg4, %arg5, %arg6] : memref<1x2x2x8xf32>
                }
              }
            }
          }
        }
      }
    }
    return
  }

  func.func private @please_map_me()