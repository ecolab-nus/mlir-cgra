// -----// IR Dump After LinalgLowerToAffineLoops (convert-linalg-to-affine-loops) //----- //
func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
  cf.br ^bb1
^bb1:  // pred: ^bb0
  affine.for %arg3 = 0 to 1 {
    affine.for %arg4 = 0 to 2 {
      affine.for %arg5 = 0 to 2 {
        affine.for %arg6 = 0 to 8 {
          affine.for %arg7 = 0 to 3 {
            affine.for %arg8 = 0 to 3 {
              affine.for %arg9 = 0 to 1 {
                %0 = affine.apply affine_map<(d0, d1) -> (d0 + d1)>(%arg4, %arg7)
                %1 = affine.apply affine_map<(d0, d1) -> (d0 + d1)>(%arg5, %arg8)
                %2 = affine.load %arg0[%arg3, %0, %1, %arg9] : memref<1x4x4x1xf32>
                %3 = affine.load %arg1[%arg6, %arg7, %arg8, %arg9] : memref<8x3x3x1xf32>
                %4 = affine.load %arg2[%arg3, %arg4, %arg5, %arg6] : memref<1x2x2x8xf32>
                %5 = arith.mulf %2, %3 : f32
                %6 = arith.addf %4, %5 : f32
                affine.store %6, %arg2[%arg3, %arg4, %arg5, %arg6] : memref<1x2x2x8xf32>
              }
            }
          }
        }
      }
    }
  }
  return
}

// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    affine.for %arg3 = 0 to 1 {
      affine.for %arg4 = 0 to 2 {
        affine.for %arg5 = 0 to 2 {
          affine.for %arg6 = 0 to 8 {
            affine.for %arg7 = 0 to 3 {
              affine.for %arg8 = 0 to 3 {
                affine.for %arg9 = 0 to 1 {
                  %0 = affine.load %arg0[%arg3, %arg4 + %arg7, %arg5 + %arg8, %arg9] : memref<1x4x4x1xf32>
                  %1 = affine.load %arg1[%arg6, %arg7, %arg8, %arg9] : memref<8x3x3x1xf32>
                  %2 = affine.load %arg2[%arg3, %arg4, %arg5, %arg6] : memref<1x2x2x8xf32>
                  %3 = arith.mulf %0, %1 : f32
                  %4 = arith.addf %2, %3 : f32
                  affine.store %4, %arg2[%arg3, %arg4, %arg5, %arg6] : memref<1x2x2x8xf32>
                }
              }
            }
          }
        }
      }
    }
    return
  }
}


// -----// IR Dump After ConvertAffineToStandard (lower-affine) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
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
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c2 step %c1 {
      scf.for %arg4 = %c0 to %c2 step %c1 {
        scf.for %arg5 = %c0 to %c8 step %c1 {
          scf.for %arg6 = %c0 to %c3 step %c1 {
            scf.for %arg7 = %c0 to %c3 step %c1 {
              %0 = arith.addi %arg3, %arg6 : index
              %1 = arith.addi %arg4, %arg7 : index
              %2 = memref.load %arg0[%c0, %0, %1, %c0] : memref<1x4x4x1xf32>
              %3 = memref.load %arg1[%arg5, %arg6, %arg7, %c0] : memref<8x3x3x1xf32>
              %4 = memref.load %arg2[%c0, %arg3, %arg4, %arg5] : memref<1x2x2x8xf32>
              %5 = arith.mulf %2, %3 : f32
              %6 = arith.addf %4, %5 : f32
              memref.store %6, %arg2[%c0, %arg3, %arg4, %arg5] : memref<1x2x2x8xf32>
            }
          }
        }
      }
    }
    return
  }
}


// -----// IR Dump After LoopCoalescing (affine-loop-coalescing) //----- //
func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
  %c3 = arith.constant 3 : index
  %c8 = arith.constant 8 : index
  %c2 = arith.constant 2 : index
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %0 = arith.muli %c2, %c2 : index
  %1 = arith.muli %0, %c8 : index
  %2 = arith.muli %1, %c3 : index
  %3 = arith.muli %2, %c3 : index
  scf.for %arg3 = %c0 to %3 step %c1 {
    %4 = arith.remsi %arg3, %c3 : index
    %5 = arith.divsi %arg3, %c3 : index
    %6 = arith.remsi %5, %c3 : index
    %7 = arith.divsi %5, %c3 : index
    %8 = arith.remsi %7, %c8 : index
    %9 = arith.divsi %7, %c8 : index
    %10 = arith.remsi %9, %c2 : index
    %11 = arith.divsi %9, %c2 : index
    %12 = arith.addi %11, %6 : index
    %13 = arith.addi %10, %4 : index
    %14 = memref.load %arg0[%c0, %12, %13, %c0] : memref<1x4x4x1xf32>
    %15 = memref.load %arg1[%8, %6, %4, %c0] : memref<8x3x3x1xf32>
    %16 = memref.load %arg2[%c0, %11, %10, %8] : memref<1x2x2x8xf32>
    %17 = arith.mulf %14, %15 : f32
    %18 = arith.addf %16, %17 : f32
    memref.store %18, %arg2[%c0, %11, %10, %8] : memref<1x2x2x8xf32>
  }
  return
}

// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c288 step %c1 {
      %0 = arith.remsi %arg3, %c3 : index
      %1 = arith.divsi %arg3, %c3 : index
      %2 = arith.remsi %1, %c3 : index
      %3 = arith.divsi %1, %c3 : index
      %4 = arith.remsi %3, %c8 : index
      %5 = arith.divsi %3, %c8 : index
      %6 = arith.remsi %5, %c2 : index
      %7 = arith.divsi %5, %c2 : index
      %8 = arith.addi %7, %2 : index
      %9 = arith.addi %6, %0 : index
      %10 = memref.load %arg0[%c0, %8, %9, %c0] : memref<1x4x4x1xf32>
      %11 = memref.load %arg1[%4, %2, %0, %c0] : memref<8x3x3x1xf32>
      %12 = memref.load %arg2[%c0, %7, %6, %4] : memref<1x2x2x8xf32>
      %13 = arith.mulf %10, %11 : f32
      %14 = arith.addf %12, %13 : f32
      memref.store %14, %arg2[%c0, %7, %6, %4] : memref<1x2x2x8xf32>
    }
    return
  }
}


// -----// IR Dump After MarkMapRegion (mark-map-region) //----- //
func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
  %c288 = arith.constant 288 : index
  %c3 = arith.constant 3 : index
  %c8 = arith.constant 8 : index
  %c2 = arith.constant 2 : index
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  scf.for %arg3 = %c0 to %c288 step %c1 {
    morpher.map_hint
    %0 = arith.remsi %arg3, %c3 : index
    %1 = arith.divsi %arg3, %c3 : index
    %2 = arith.remsi %1, %c3 : index
    %3 = arith.divsi %1, %c3 : index
    %4 = arith.remsi %3, %c8 : index
    %5 = arith.divsi %3, %c8 : index
    %6 = arith.remsi %5, %c2 : index
    %7 = arith.divsi %5, %c2 : index
    %8 = arith.addi %7, %2 : index
    %9 = arith.addi %6, %0 : index
    %10 = memref.load %arg0[%c0, %8, %9, %c0] : memref<1x4x4x1xf32>
    %11 = memref.load %arg1[%4, %2, %0, %c0] : memref<8x3x3x1xf32>
    %12 = memref.load %arg2[%c0, %7, %6, %4] : memref<1x2x2x8xf32>
    %13 = arith.mulf %10, %11 : f32
    %14 = arith.addf %12, %13 : f32
    memref.store %14, %arg2[%c0, %7, %6, %4] : memref<1x2x2x8xf32>
  }
  return
}

// -----// IR Dump After LegalizeMorpher (legalize-morpher) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c288 step %c1 {
      func.call @please_map_me() : () -> ()
      %0 = arith.floordivsi %arg3, %c3 : index
      %1 = arith.muli %0, %c3 : index
      %2 = arith.subi %arg3, %1 : index
      %3 = arith.divsi %arg3, %c3 : index
      %4 = arith.floordivsi %3, %c3 : index
      %5 = arith.muli %4, %c3 : index
      %6 = arith.subi %3, %5 : index
      %7 = arith.divsi %3, %c3 : index
      %8 = arith.floordivsi %7, %c8 : index
      %9 = arith.muli %8, %c8 : index
      %10 = arith.subi %7, %9 : index
      %11 = arith.divsi %7, %c8 : index
      %12 = arith.floordivsi %11, %c2 : index
      %13 = arith.muli %12, %c2 : index
      %14 = arith.subi %11, %13 : index
      %15 = arith.divsi %11, %c2 : index
      %16 = arith.addi %15, %6 : index
      %17 = arith.addi %14, %2 : index
      %18 = memref.load %arg0[%c0, %16, %17, %c0] : memref<1x4x4x1xf32>
      %19 = memref.load %arg1[%10, %6, %2, %c0] : memref<8x3x3x1xf32>
      %20 = memref.load %arg2[%c0, %15, %14, %10] : memref<1x2x2x8xf32>
      %21 = arith.mulf %18, %19 : f32
      %22 = arith.addf %20, %21 : f32
      memref.store %22, %arg2[%c0, %15, %14, %10] : memref<1x2x2x8xf32>
    }
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c288 step %c1 {
      func.call @please_map_me() : () -> ()
      %0 = arith.floordivsi %arg3, %c3 : index
      %1 = arith.muli %0, %c3 : index
      %2 = arith.subi %arg3, %1 : index
      %3 = arith.divsi %arg3, %c3 : index
      %4 = arith.floordivsi %3, %c3 : index
      %5 = arith.muli %4, %c3 : index
      %6 = arith.subi %3, %5 : index
      %7 = arith.divsi %3, %c3 : index
      %8 = arith.floordivsi %7, %c8 : index
      %9 = arith.muli %8, %c8 : index
      %10 = arith.subi %7, %9 : index
      %11 = arith.divsi %7, %c8 : index
      %12 = arith.floordivsi %11, %c2 : index
      %13 = arith.muli %12, %c2 : index
      %14 = arith.subi %11, %13 : index
      %15 = arith.divsi %11, %c2 : index
      %16 = arith.addi %15, %6 : index
      %17 = arith.addi %14, %2 : index
      %18 = memref.load %arg0[%c0, %16, %17, %c0] : memref<1x4x4x1xf32>
      %19 = memref.load %arg1[%10, %6, %2, %c0] : memref<8x3x3x1xf32>
      %20 = memref.load %arg2[%c0, %15, %14, %10] : memref<1x2x2x8xf32>
      %21 = arith.mulf %18, %19 : f32
      %22 = arith.addf %20, %21 : f32
      memref.store %22, %arg2[%c0, %15, %14, %10] : memref<1x2x2x8xf32>
    }
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c288 step %c1 {
      func.call @please_map_me() : () -> ()
      %0 = arith.floordivsi %arg3, %c3 : index
      %1 = arith.muli %0, %c3 : index
      %2 = arith.subi %arg3, %1 : index
      %3 = arith.divsi %arg3, %c3 : index
      %4 = arith.floordivsi %3, %c3 : index
      %5 = arith.muli %4, %c3 : index
      %6 = arith.subi %3, %5 : index
      %7 = arith.divsi %3, %c3 : index
      %8 = arith.floordivsi %7, %c8 : index
      %9 = arith.muli %8, %c8 : index
      %10 = arith.subi %7, %9 : index
      %11 = arith.divsi %7, %c8 : index
      %12 = arith.floordivsi %11, %c2 : index
      %13 = arith.muli %12, %c2 : index
      %14 = arith.subi %11, %13 : index
      %15 = arith.divsi %11, %c2 : index
      %16 = arith.addi %15, %6 : index
      %17 = arith.addi %14, %2 : index
      %18 = memref.load %arg0[%c0, %16, %17, %c0] : memref<1x4x4x1xf32>
      %19 = memref.load %arg1[%10, %6, %2, %c0] : memref<8x3x3x1xf32>
      %20 = memref.load %arg2[%c0, %15, %14, %10] : memref<1x2x2x8xf32>
      %21 = arith.mulf %18, %19 : f32
      %22 = arith.addf %20, %21 : f32
      memref.store %22, %arg2[%c0, %15, %14, %10] : memref<1x2x2x8xf32>
    }
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After SCFToControlFlow (convert-scf-to-cf) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c288 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = arith.floordivsi %0, %c3 : index
    %3 = arith.muli %2, %c3 : index
    %4 = arith.subi %0, %3 : index
    %5 = arith.divsi %0, %c3 : index
    %6 = arith.floordivsi %5, %c3 : index
    %7 = arith.muli %6, %c3 : index
    %8 = arith.subi %5, %7 : index
    %9 = arith.divsi %5, %c3 : index
    %10 = arith.floordivsi %9, %c8 : index
    %11 = arith.muli %10, %c8 : index
    %12 = arith.subi %9, %11 : index
    %13 = arith.divsi %9, %c8 : index
    %14 = arith.floordivsi %13, %c2 : index
    %15 = arith.muli %14, %c2 : index
    %16 = arith.subi %13, %15 : index
    %17 = arith.divsi %13, %c2 : index
    %18 = arith.addi %17, %8 : index
    %19 = arith.addi %16, %4 : index
    %20 = memref.load %arg0[%c0, %18, %19, %c0] : memref<1x4x4x1xf32>
    %21 = memref.load %arg1[%12, %8, %4, %c0] : memref<8x3x3x1xf32>
    %22 = memref.load %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %23 = arith.mulf %20, %21 : f32
    %24 = arith.addf %22, %23 : f32
    memref.store %24, %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %25 = arith.addi %0, %c1 : index
    cf.br ^bb1(%25 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c288 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = arith.floordivsi %0, %c3 : index
    %3 = arith.muli %2, %c3 : index
    %4 = arith.subi %0, %3 : index
    %5 = arith.divsi %0, %c3 : index
    %6 = arith.floordivsi %5, %c3 : index
    %7 = arith.muli %6, %c3 : index
    %8 = arith.subi %5, %7 : index
    %9 = arith.divsi %5, %c3 : index
    %10 = arith.floordivsi %9, %c8 : index
    %11 = arith.muli %10, %c8 : index
    %12 = arith.subi %9, %11 : index
    %13 = arith.divsi %9, %c8 : index
    %14 = arith.floordivsi %13, %c2 : index
    %15 = arith.muli %14, %c2 : index
    %16 = arith.subi %13, %15 : index
    %17 = arith.divsi %13, %c2 : index
    %18 = arith.addi %17, %8 : index
    %19 = arith.addi %16, %4 : index
    %20 = memref.load %arg0[%c0, %18, %19, %c0] : memref<1x4x4x1xf32>
    %21 = memref.load %arg1[%12, %8, %4, %c0] : memref<8x3x3x1xf32>
    %22 = memref.load %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %23 = arith.mulf %20, %21 : f32
    %24 = arith.addf %22, %23 : f32
    memref.store %24, %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %25 = arith.addi %0, %c1 : index
    cf.br ^bb1(%25 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c288 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = arith.floordivsi %0, %c3 : index
    %3 = arith.muli %2, %c3 : index
    %4 = arith.subi %0, %3 : index
    %5 = arith.divsi %0, %c3 : index
    %6 = arith.floordivsi %5, %c3 : index
    %7 = arith.muli %6, %c3 : index
    %8 = arith.subi %5, %7 : index
    %9 = arith.divsi %5, %c3 : index
    %10 = arith.floordivsi %9, %c8 : index
    %11 = arith.muli %10, %c8 : index
    %12 = arith.subi %9, %11 : index
    %13 = arith.divsi %9, %c8 : index
    %14 = arith.floordivsi %13, %c2 : index
    %15 = arith.muli %14, %c2 : index
    %16 = arith.subi %13, %15 : index
    %17 = arith.divsi %13, %c2 : index
    %18 = arith.addi %17, %8 : index
    %19 = arith.addi %16, %4 : index
    %20 = memref.load %arg0[%c0, %18, %19, %c0] : memref<1x4x4x1xf32>
    %21 = memref.load %arg1[%12, %8, %4, %c0] : memref<8x3x3x1xf32>
    %22 = memref.load %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %23 = arith.mulf %20, %21 : f32
    %24 = arith.addf %22, %23 : f32
    memref.store %24, %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %25 = arith.addi %0, %c1 : index
    cf.br ^bb1(%25 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertMathToLLVM (convert-math-to-llvm) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c288 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = arith.floordivsi %0, %c3 : index
    %3 = arith.muli %2, %c3 : index
    %4 = arith.subi %0, %3 : index
    %5 = arith.divsi %0, %c3 : index
    %6 = arith.floordivsi %5, %c3 : index
    %7 = arith.muli %6, %c3 : index
    %8 = arith.subi %5, %7 : index
    %9 = arith.divsi %5, %c3 : index
    %10 = arith.floordivsi %9, %c8 : index
    %11 = arith.muli %10, %c8 : index
    %12 = arith.subi %9, %11 : index
    %13 = arith.divsi %9, %c8 : index
    %14 = arith.floordivsi %13, %c2 : index
    %15 = arith.muli %14, %c2 : index
    %16 = arith.subi %13, %15 : index
    %17 = arith.divsi %13, %c2 : index
    %18 = arith.addi %17, %8 : index
    %19 = arith.addi %16, %4 : index
    %20 = memref.load %arg0[%c0, %18, %19, %c0] : memref<1x4x4x1xf32>
    %21 = memref.load %arg1[%12, %8, %4, %c0] : memref<8x3x3x1xf32>
    %22 = memref.load %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %23 = arith.mulf %20, %21 : f32
    %24 = arith.addf %22, %23 : f32
    memref.store %24, %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %25 = arith.addi %0, %c1 : index
    cf.br ^bb1(%25 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertMathToLibm (convert-math-to-libm) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c288 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = arith.floordivsi %0, %c3 : index
    %3 = arith.muli %2, %c3 : index
    %4 = arith.subi %0, %3 : index
    %5 = arith.divsi %0, %c3 : index
    %6 = arith.floordivsi %5, %c3 : index
    %7 = arith.muli %6, %c3 : index
    %8 = arith.subi %5, %7 : index
    %9 = arith.divsi %5, %c3 : index
    %10 = arith.floordivsi %9, %c8 : index
    %11 = arith.muli %10, %c8 : index
    %12 = arith.subi %9, %11 : index
    %13 = arith.divsi %9, %c8 : index
    %14 = arith.floordivsi %13, %c2 : index
    %15 = arith.muli %14, %c2 : index
    %16 = arith.subi %13, %15 : index
    %17 = arith.divsi %13, %c2 : index
    %18 = arith.addi %17, %8 : index
    %19 = arith.addi %16, %4 : index
    %20 = memref.load %arg0[%c0, %18, %19, %c0] : memref<1x4x4x1xf32>
    %21 = memref.load %arg1[%12, %8, %4, %c0] : memref<8x3x3x1xf32>
    %22 = memref.load %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %23 = arith.mulf %20, %21 : f32
    %24 = arith.addf %22, %23 : f32
    memref.store %24, %arg2[%c0, %17, %16, %12] : memref<1x2x2x8xf32>
    %25 = arith.addi %0, %c1 : index
    cf.br ^bb1(%25 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ArithmeticExpandOps (arith-expand) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %c288 = arith.constant 288 : index
    %c3 = arith.constant 3 : index
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c288 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %c1_0 = arith.constant 1 : index
    %c0_1 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %2 = arith.cmpi slt, %c3, %c0_1 : index
    %3 = arith.select %2, %c1_0, %c-1 : index
    %4 = arith.subi %3, %0 : index
    %5 = arith.divsi %4, %c3 : index
    %6 = arith.subi %c-1, %5 : index
    %7 = arith.divsi %0, %c3 : index
    %8 = arith.cmpi slt, %0, %c0_1 : index
    %9 = arith.cmpi sgt, %0, %c0_1 : index
    %10 = arith.cmpi slt, %c3, %c0_1 : index
    %11 = arith.cmpi sgt, %c3, %c0_1 : index
    %12 = arith.andi %8, %11 : i1
    %13 = arith.andi %9, %10 : i1
    %14 = arith.ori %12, %13 : i1
    %15 = arith.select %14, %6, %7 : index
    %16 = arith.muli %15, %c3 : index
    %17 = arith.subi %0, %16 : index
    %18 = arith.divsi %0, %c3 : index
    %c1_2 = arith.constant 1 : index
    %c0_3 = arith.constant 0 : index
    %c-1_4 = arith.constant -1 : index
    %19 = arith.cmpi slt, %c3, %c0_3 : index
    %20 = arith.select %19, %c1_2, %c-1_4 : index
    %21 = arith.subi %20, %18 : index
    %22 = arith.divsi %21, %c3 : index
    %23 = arith.subi %c-1_4, %22 : index
    %24 = arith.divsi %18, %c3 : index
    %25 = arith.cmpi slt, %18, %c0_3 : index
    %26 = arith.cmpi sgt, %18, %c0_3 : index
    %27 = arith.cmpi slt, %c3, %c0_3 : index
    %28 = arith.cmpi sgt, %c3, %c0_3 : index
    %29 = arith.andi %25, %28 : i1
    %30 = arith.andi %26, %27 : i1
    %31 = arith.ori %29, %30 : i1
    %32 = arith.select %31, %23, %24 : index
    %33 = arith.muli %32, %c3 : index
    %34 = arith.subi %18, %33 : index
    %35 = arith.divsi %18, %c3 : index
    %c1_5 = arith.constant 1 : index
    %c0_6 = arith.constant 0 : index
    %c-1_7 = arith.constant -1 : index
    %36 = arith.cmpi slt, %c8, %c0_6 : index
    %37 = arith.select %36, %c1_5, %c-1_7 : index
    %38 = arith.subi %37, %35 : index
    %39 = arith.divsi %38, %c8 : index
    %40 = arith.subi %c-1_7, %39 : index
    %41 = arith.divsi %35, %c8 : index
    %42 = arith.cmpi slt, %35, %c0_6 : index
    %43 = arith.cmpi sgt, %35, %c0_6 : index
    %44 = arith.cmpi slt, %c8, %c0_6 : index
    %45 = arith.cmpi sgt, %c8, %c0_6 : index
    %46 = arith.andi %42, %45 : i1
    %47 = arith.andi %43, %44 : i1
    %48 = arith.ori %46, %47 : i1
    %49 = arith.select %48, %40, %41 : index
    %50 = arith.muli %49, %c8 : index
    %51 = arith.subi %35, %50 : index
    %52 = arith.divsi %35, %c8 : index
    %c1_8 = arith.constant 1 : index
    %c0_9 = arith.constant 0 : index
    %c-1_10 = arith.constant -1 : index
    %53 = arith.cmpi slt, %c2, %c0_9 : index
    %54 = arith.select %53, %c1_8, %c-1_10 : index
    %55 = arith.subi %54, %52 : index
    %56 = arith.divsi %55, %c2 : index
    %57 = arith.subi %c-1_10, %56 : index
    %58 = arith.divsi %52, %c2 : index
    %59 = arith.cmpi slt, %52, %c0_9 : index
    %60 = arith.cmpi sgt, %52, %c0_9 : index
    %61 = arith.cmpi slt, %c2, %c0_9 : index
    %62 = arith.cmpi sgt, %c2, %c0_9 : index
    %63 = arith.andi %59, %62 : i1
    %64 = arith.andi %60, %61 : i1
    %65 = arith.ori %63, %64 : i1
    %66 = arith.select %65, %57, %58 : index
    %67 = arith.muli %66, %c2 : index
    %68 = arith.subi %52, %67 : index
    %69 = arith.divsi %52, %c2 : index
    %70 = arith.addi %69, %34 : index
    %71 = arith.addi %68, %17 : index
    %72 = memref.load %arg0[%c0, %70, %71, %c0] : memref<1x4x4x1xf32>
    %73 = memref.load %arg1[%51, %34, %17, %c0] : memref<8x3x3x1xf32>
    %74 = memref.load %arg2[%c0, %69, %68, %51] : memref<1x2x2x8xf32>
    %75 = arith.mulf %72, %73 : f32
    %76 = arith.addf %74, %75 : f32
    memref.store %76, %arg2[%c0, %69, %68, %51] : memref<1x2x2x8xf32>
    %77 = arith.addi %0, %c1 : index
    cf.br ^bb1(%77 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertArithmeticToLLVM (convert-arith-to-llvm) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.constant(288 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(8 : index) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    %6 = llvm.mlir.constant(1 : index) : i64
    cf.br ^bb1(%5 : index)
  ^bb1(%7: index):  // 2 preds: ^bb0, ^bb2
    %8 = builtin.unrealized_conversion_cast %7 : index to i64
    %9 = llvm.icmp "slt" %8, %0 : i64
    cf.cond_br %9, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.mlir.constant(-1 : index) : i64
    %13 = llvm.mlir.constant(false) : i1
    %14 = llvm.select %13, %10, %12 : i1, i64
    %15 = llvm.sub %14, %8  : i64
    %16 = llvm.sdiv %15, %1  : i64
    %17 = llvm.sub %12, %16  : i64
    %18 = llvm.sdiv %8, %1  : i64
    %19 = llvm.icmp "slt" %8, %11 : i64
    %20 = llvm.icmp "sgt" %8, %11 : i64
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.mlir.constant(true) : i1
    %23 = llvm.and %19, %22  : i1
    %24 = llvm.and %20, %21  : i1
    %25 = llvm.or %23, %24  : i1
    %26 = llvm.select %25, %17, %18 : i1, i64
    %27 = llvm.mul %26, %1  : i64
    %28 = llvm.sub %8, %27  : i64
    %29 = builtin.unrealized_conversion_cast %28 : i64 to index
    %30 = llvm.sdiv %8, %1  : i64
    %31 = llvm.mlir.constant(1 : index) : i64
    %32 = llvm.mlir.constant(0 : index) : i64
    %33 = llvm.mlir.constant(-1 : index) : i64
    %34 = llvm.mlir.constant(false) : i1
    %35 = llvm.select %34, %31, %33 : i1, i64
    %36 = llvm.sub %35, %30  : i64
    %37 = llvm.sdiv %36, %1  : i64
    %38 = llvm.sub %33, %37  : i64
    %39 = llvm.sdiv %30, %1  : i64
    %40 = llvm.icmp "slt" %30, %32 : i64
    %41 = llvm.icmp "sgt" %30, %32 : i64
    %42 = llvm.mlir.constant(false) : i1
    %43 = llvm.mlir.constant(true) : i1
    %44 = llvm.and %40, %43  : i1
    %45 = llvm.and %41, %42  : i1
    %46 = llvm.or %44, %45  : i1
    %47 = llvm.select %46, %38, %39 : i1, i64
    %48 = llvm.mul %47, %1  : i64
    %49 = llvm.sub %30, %48  : i64
    %50 = builtin.unrealized_conversion_cast %49 : i64 to index
    %51 = llvm.sdiv %30, %1  : i64
    %52 = llvm.mlir.constant(1 : index) : i64
    %53 = llvm.mlir.constant(0 : index) : i64
    %54 = llvm.mlir.constant(-1 : index) : i64
    %55 = llvm.mlir.constant(false) : i1
    %56 = llvm.select %55, %52, %54 : i1, i64
    %57 = llvm.sub %56, %51  : i64
    %58 = llvm.sdiv %57, %2  : i64
    %59 = llvm.sub %54, %58  : i64
    %60 = llvm.sdiv %51, %2  : i64
    %61 = llvm.icmp "slt" %51, %53 : i64
    %62 = llvm.icmp "sgt" %51, %53 : i64
    %63 = llvm.mlir.constant(false) : i1
    %64 = llvm.mlir.constant(true) : i1
    %65 = llvm.and %61, %64  : i1
    %66 = llvm.and %62, %63  : i1
    %67 = llvm.or %65, %66  : i1
    %68 = llvm.select %67, %59, %60 : i1, i64
    %69 = llvm.mul %68, %2  : i64
    %70 = llvm.sub %51, %69  : i64
    %71 = builtin.unrealized_conversion_cast %70 : i64 to index
    %72 = llvm.sdiv %51, %2  : i64
    %73 = llvm.mlir.constant(1 : index) : i64
    %74 = llvm.mlir.constant(0 : index) : i64
    %75 = llvm.mlir.constant(-1 : index) : i64
    %76 = llvm.mlir.constant(false) : i1
    %77 = llvm.select %76, %73, %75 : i1, i64
    %78 = llvm.sub %77, %72  : i64
    %79 = llvm.sdiv %78, %3  : i64
    %80 = llvm.sub %75, %79  : i64
    %81 = llvm.sdiv %72, %3  : i64
    %82 = llvm.icmp "slt" %72, %74 : i64
    %83 = llvm.icmp "sgt" %72, %74 : i64
    %84 = llvm.mlir.constant(false) : i1
    %85 = llvm.mlir.constant(true) : i1
    %86 = llvm.and %82, %85  : i1
    %87 = llvm.and %83, %84  : i1
    %88 = llvm.or %86, %87  : i1
    %89 = llvm.select %88, %80, %81 : i1, i64
    %90 = llvm.mul %89, %3  : i64
    %91 = llvm.sub %72, %90  : i64
    %92 = builtin.unrealized_conversion_cast %91 : i64 to index
    %93 = llvm.sdiv %72, %3  : i64
    %94 = builtin.unrealized_conversion_cast %93 : i64 to index
    %95 = llvm.add %93, %49  : i64
    %96 = builtin.unrealized_conversion_cast %95 : i64 to index
    %97 = llvm.add %91, %28  : i64
    %98 = builtin.unrealized_conversion_cast %97 : i64 to index
    %99 = memref.load %arg0[%5, %96, %98, %5] : memref<1x4x4x1xf32>
    %100 = memref.load %arg1[%71, %50, %29, %5] : memref<8x3x3x1xf32>
    %101 = memref.load %arg2[%5, %94, %92, %71] : memref<1x2x2x8xf32>
    %102 = llvm.fmul %99, %100  : f32
    %103 = llvm.fadd %101, %102  : f32
    memref.store %103, %arg2[%5, %94, %92, %71] : memref<1x2x2x8xf32>
    %104 = llvm.add %8, %6  : i64
    %105 = builtin.unrealized_conversion_cast %104 : i64 to index
    cf.br ^bb1(%105 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ExpandOps (memref-expand) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.constant(288 : index) : i64
    %1 = llvm.mlir.constant(3 : index) : i64
    %2 = llvm.mlir.constant(8 : index) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    %6 = llvm.mlir.constant(1 : index) : i64
    cf.br ^bb1(%5 : index)
  ^bb1(%7: index):  // 2 preds: ^bb0, ^bb2
    %8 = builtin.unrealized_conversion_cast %7 : index to i64
    %9 = llvm.icmp "slt" %8, %0 : i64
    cf.cond_br %9, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.mlir.constant(-1 : index) : i64
    %13 = llvm.mlir.constant(false) : i1
    %14 = llvm.select %13, %10, %12 : i1, i64
    %15 = llvm.sub %14, %8  : i64
    %16 = llvm.sdiv %15, %1  : i64
    %17 = llvm.sub %12, %16  : i64
    %18 = llvm.sdiv %8, %1  : i64
    %19 = llvm.icmp "slt" %8, %11 : i64
    %20 = llvm.icmp "sgt" %8, %11 : i64
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.mlir.constant(true) : i1
    %23 = llvm.and %19, %22  : i1
    %24 = llvm.and %20, %21  : i1
    %25 = llvm.or %23, %24  : i1
    %26 = llvm.select %25, %17, %18 : i1, i64
    %27 = llvm.mul %26, %1  : i64
    %28 = llvm.sub %8, %27  : i64
    %29 = builtin.unrealized_conversion_cast %28 : i64 to index
    %30 = llvm.sdiv %8, %1  : i64
    %31 = llvm.mlir.constant(1 : index) : i64
    %32 = llvm.mlir.constant(0 : index) : i64
    %33 = llvm.mlir.constant(-1 : index) : i64
    %34 = llvm.mlir.constant(false) : i1
    %35 = llvm.select %34, %31, %33 : i1, i64
    %36 = llvm.sub %35, %30  : i64
    %37 = llvm.sdiv %36, %1  : i64
    %38 = llvm.sub %33, %37  : i64
    %39 = llvm.sdiv %30, %1  : i64
    %40 = llvm.icmp "slt" %30, %32 : i64
    %41 = llvm.icmp "sgt" %30, %32 : i64
    %42 = llvm.mlir.constant(false) : i1
    %43 = llvm.mlir.constant(true) : i1
    %44 = llvm.and %40, %43  : i1
    %45 = llvm.and %41, %42  : i1
    %46 = llvm.or %44, %45  : i1
    %47 = llvm.select %46, %38, %39 : i1, i64
    %48 = llvm.mul %47, %1  : i64
    %49 = llvm.sub %30, %48  : i64
    %50 = builtin.unrealized_conversion_cast %49 : i64 to index
    %51 = llvm.sdiv %30, %1  : i64
    %52 = llvm.mlir.constant(1 : index) : i64
    %53 = llvm.mlir.constant(0 : index) : i64
    %54 = llvm.mlir.constant(-1 : index) : i64
    %55 = llvm.mlir.constant(false) : i1
    %56 = llvm.select %55, %52, %54 : i1, i64
    %57 = llvm.sub %56, %51  : i64
    %58 = llvm.sdiv %57, %2  : i64
    %59 = llvm.sub %54, %58  : i64
    %60 = llvm.sdiv %51, %2  : i64
    %61 = llvm.icmp "slt" %51, %53 : i64
    %62 = llvm.icmp "sgt" %51, %53 : i64
    %63 = llvm.mlir.constant(false) : i1
    %64 = llvm.mlir.constant(true) : i1
    %65 = llvm.and %61, %64  : i1
    %66 = llvm.and %62, %63  : i1
    %67 = llvm.or %65, %66  : i1
    %68 = llvm.select %67, %59, %60 : i1, i64
    %69 = llvm.mul %68, %2  : i64
    %70 = llvm.sub %51, %69  : i64
    %71 = builtin.unrealized_conversion_cast %70 : i64 to index
    %72 = llvm.sdiv %51, %2  : i64
    %73 = llvm.mlir.constant(1 : index) : i64
    %74 = llvm.mlir.constant(0 : index) : i64
    %75 = llvm.mlir.constant(-1 : index) : i64
    %76 = llvm.mlir.constant(false) : i1
    %77 = llvm.select %76, %73, %75 : i1, i64
    %78 = llvm.sub %77, %72  : i64
    %79 = llvm.sdiv %78, %3  : i64
    %80 = llvm.sub %75, %79  : i64
    %81 = llvm.sdiv %72, %3  : i64
    %82 = llvm.icmp "slt" %72, %74 : i64
    %83 = llvm.icmp "sgt" %72, %74 : i64
    %84 = llvm.mlir.constant(false) : i1
    %85 = llvm.mlir.constant(true) : i1
    %86 = llvm.and %82, %85  : i1
    %87 = llvm.and %83, %84  : i1
    %88 = llvm.or %86, %87  : i1
    %89 = llvm.select %88, %80, %81 : i1, i64
    %90 = llvm.mul %89, %3  : i64
    %91 = llvm.sub %72, %90  : i64
    %92 = builtin.unrealized_conversion_cast %91 : i64 to index
    %93 = llvm.sdiv %72, %3  : i64
    %94 = builtin.unrealized_conversion_cast %93 : i64 to index
    %95 = llvm.add %93, %49  : i64
    %96 = builtin.unrealized_conversion_cast %95 : i64 to index
    %97 = llvm.add %91, %28  : i64
    %98 = builtin.unrealized_conversion_cast %97 : i64 to index
    %99 = memref.load %arg0[%5, %96, %98, %5] : memref<1x4x4x1xf32>
    %100 = memref.load %arg1[%71, %50, %29, %5] : memref<8x3x3x1xf32>
    %101 = memref.load %arg2[%5, %94, %92, %71] : memref<1x2x2x8xf32>
    %102 = llvm.fmul %99, %100  : f32
    %103 = llvm.fadd %101, %102  : f32
    memref.store %103, %arg2[%5, %94, %92, %71] : memref<1x2x2x8xf32>
    %104 = llvm.add %8, %6  : i64
    %105 = builtin.unrealized_conversion_cast %104 : i64 to index
    cf.br ^bb1(%105 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertMemRefToLLVM (convert-memref-to-llvm) //----- //
module attributes {soda.bambu.container_module, soda.container_module} {
  func.func @generic_0(%arg0: memref<1x4x4x1xf32>, %arg1: memref<8x3x3x1xf32>, %arg2: memref<1x2x2x8xf32>) attributes {__morpher_kernel__} {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1x4x4x1xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<8x3x3x1xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<1x2x2x8xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %3 = llvm.mlir.constant(288 : index) : i64
    %4 = llvm.mlir.constant(3 : index) : i64
    %5 = llvm.mlir.constant(8 : index) : i64
    %6 = llvm.mlir.constant(2 : index) : i64
    %7 = llvm.mlir.constant(0 : index) : i64
    %8 = builtin.unrealized_conversion_cast %7 : i64 to index
    %9 = llvm.mlir.constant(1 : index) : i64
    cf.br ^bb1(%8 : index)
  ^bb1(%10: index):  // 2 preds: ^bb0, ^bb2
    %11 = builtin.unrealized_conversion_cast %10 : index to i64
    %12 = llvm.icmp "slt" %11, %3 : i64
    cf.cond_br %12, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %13 = llvm.mlir.constant(1 : index) : i64
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.mlir.constant(-1 : index) : i64
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.select %16, %13, %15 : i1, i64
    %18 = llvm.sub %17, %11  : i64
    %19 = llvm.sdiv %18, %4  : i64
    %20 = llvm.sub %15, %19  : i64
    %21 = llvm.sdiv %11, %4  : i64
    %22 = llvm.icmp "slt" %11, %14 : i64
    %23 = llvm.icmp "sgt" %11, %14 : i64
    %24 = llvm.mlir.constant(false) : i1
    %25 = llvm.mlir.constant(true) : i1
    %26 = llvm.and %22, %25  : i1
    %27 = llvm.and %23, %24  : i1
    %28 = llvm.or %26, %27  : i1
    %29 = llvm.select %28, %20, %21 : i1, i64
    %30 = llvm.mul %29, %4  : i64
    %31 = llvm.sub %11, %30  : i64
    %32 = builtin.unrealized_conversion_cast %31 : i64 to index
    %33 = llvm.sdiv %11, %4  : i64
    %34 = llvm.mlir.constant(1 : index) : i64
    %35 = llvm.mlir.constant(0 : index) : i64
    %36 = llvm.mlir.constant(-1 : index) : i64
    %37 = llvm.mlir.constant(false) : i1
    %38 = llvm.select %37, %34, %36 : i1, i64
    %39 = llvm.sub %38, %33  : i64
    %40 = llvm.sdiv %39, %4  : i64
    %41 = llvm.sub %36, %40  : i64
    %42 = llvm.sdiv %33, %4  : i64
    %43 = llvm.icmp "slt" %33, %35 : i64
    %44 = llvm.icmp "sgt" %33, %35 : i64
    %45 = llvm.mlir.constant(false) : i1
    %46 = llvm.mlir.constant(true) : i1
    %47 = llvm.and %43, %46  : i1
    %48 = llvm.and %44, %45  : i1
    %49 = llvm.or %47, %48  : i1
    %50 = llvm.select %49, %41, %42 : i1, i64
    %51 = llvm.mul %50, %4  : i64
    %52 = llvm.sub %33, %51  : i64
    %53 = builtin.unrealized_conversion_cast %52 : i64 to index
    %54 = llvm.sdiv %33, %4  : i64
    %55 = llvm.mlir.constant(1 : index) : i64
    %56 = llvm.mlir.constant(0 : index) : i64
    %57 = llvm.mlir.constant(-1 : index) : i64
    %58 = llvm.mlir.constant(false) : i1
    %59 = llvm.select %58, %55, %57 : i1, i64
    %60 = llvm.sub %59, %54  : i64
    %61 = llvm.sdiv %60, %5  : i64
    %62 = llvm.sub %57, %61  : i64
    %63 = llvm.sdiv %54, %5  : i64
    %64 = llvm.icmp "slt" %54, %56 : i64
    %65 = llvm.icmp "sgt" %54, %56 : i64
    %66 = llvm.mlir.constant(false) : i1
    %67 = llvm.mlir.constant(true) : i1
    %68 = llvm.and %64, %67  : i1
    %69 = llvm.and %65, %66  : i1
    %70 = llvm.or %68, %69  : i1
    %71 = llvm.select %70, %62, %63 : i1, i64
    %72 = llvm.mul %71, %5  : i64
    %73 = llvm.sub %54, %72  : i64
    %74 = builtin.unrealized_conversion_cast %73 : i64 to index
    %75 = llvm.sdiv %54, %5  : i64
    %76 = llvm.mlir.constant(1 : index) : i64
    %77 = llvm.mlir.constant(0 : index) : i64
    %78 = llvm.mlir.constant(-1 : index) : i64
    %79 = llvm.mlir.constant(false) : i1
    %80 = llvm.select %79, %76, %78 : i1, i64
    %81 = llvm.sub %80, %75  : i64
    %82 = llvm.sdiv %81, %6  : i64
    %83 = llvm.sub %78, %82  : i64
    %84 = llvm.sdiv %75, %6  : i64
    %85 = llvm.icmp "slt" %75, %77 : i64
    %86 = llvm.icmp "sgt" %75, %77 : i64
    %87 = llvm.mlir.constant(false) : i1
    %88 = llvm.mlir.constant(true) : i1
    %89 = llvm.and %85, %88  : i1
    %90 = llvm.and %86, %87  : i1
    %91 = llvm.or %89, %90  : i1
    %92 = llvm.select %91, %83, %84 : i1, i64
    %93 = llvm.mul %92, %6  : i64
    %94 = llvm.sub %75, %93  : i64
    %95 = builtin.unrealized_conversion_cast %94 : i64 to index
    %96 = llvm.sdiv %75, %6  : i64
    %97 = builtin.unrealized_conversion_cast %96 : i64 to index
    %98 = llvm.add %96, %52  : i64
    %99 = builtin.unrealized_conversion_cast %98 : i64 to index
    %100 = llvm.add %94, %31  : i64
    %101 = builtin.unrealized_conversion_cast %100 : i64 to index
    %102 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %103 = llvm.mlir.constant(16 : index) : i64
    %104 = llvm.mul %7, %103  : i64
    %105 = llvm.mlir.constant(4 : index) : i64
    %106 = llvm.mul %98, %105  : i64
    %107 = llvm.add %104, %106  : i64
    %108 = llvm.add %107, %100  : i64
    %109 = llvm.add %108, %7  : i64
    %110 = llvm.getelementptr %102[%109] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %111 = llvm.load %110 : !llvm.ptr<f32>
    %112 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %113 = llvm.mlir.constant(9 : index) : i64
    %114 = llvm.mul %73, %113  : i64
    %115 = llvm.mlir.constant(3 : index) : i64
    %116 = llvm.mul %52, %115  : i64
    %117 = llvm.add %114, %116  : i64
    %118 = llvm.add %117, %31  : i64
    %119 = llvm.add %118, %7  : i64
    %120 = llvm.getelementptr %112[%119] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %121 = llvm.load %120 : !llvm.ptr<f32>
    %122 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %123 = llvm.mlir.constant(32 : index) : i64
    %124 = llvm.mul %7, %123  : i64
    %125 = llvm.mlir.constant(16 : index) : i64
    %126 = llvm.mul %96, %125  : i64
    %127 = llvm.add %124, %126  : i64
    %128 = llvm.mlir.constant(8 : index) : i64
    %129 = llvm.mul %94, %128  : i64
    %130 = llvm.add %127, %129  : i64
    %131 = llvm.add %130, %73  : i64
    %132 = llvm.getelementptr %122[%131] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %133 = llvm.load %132 : !llvm.ptr<f32>
    %134 = llvm.fmul %111, %121  : f32
    %135 = llvm.fadd %133, %134  : f32
    %136 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %137 = llvm.mlir.constant(32 : index) : i64
    %138 = llvm.mul %7, %137  : i64
    %139 = llvm.mlir.constant(16 : index) : i64
    %140 = llvm.mul %96, %139  : i64
    %141 = llvm.add %138, %140  : i64
    %142 = llvm.mlir.constant(8 : index) : i64
    %143 = llvm.mul %94, %142  : i64
    %144 = llvm.add %141, %143  : i64
    %145 = llvm.add %144, %73  : i64
    %146 = llvm.getelementptr %136[%145] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %135, %146 : !llvm.ptr<f32>
    %147 = llvm.add %11, %9  : i64
    %148 = builtin.unrealized_conversion_cast %147 : i64 to index
    cf.br ^bb1(%148 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertFuncToLLVM (convert-func-to-llvm) //----- //
module attributes {llvm.data_layout = "", soda.bambu.container_module, soda.container_module} {
  llvm.func @generic_0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %7 = llvm.mlir.constant(16 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %9 = llvm.mlir.constant(4 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %11 = llvm.mlir.constant(4 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %13 = llvm.mlir.constant(4 : index) : i64
    %14 = llvm.insertvalue %13, %12[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.insertvalue %15, %14[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.insertvalue %17, %16[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.insertvalue %19, %18[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %21 = builtin.unrealized_conversion_cast %20 : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> to memref<1x4x4x1xf32>
    %22 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %23 = llvm.insertvalue %arg1, %22[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.insertvalue %arg1, %23[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %27 = llvm.mlir.constant(8 : index) : i64
    %28 = llvm.insertvalue %27, %26[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %29 = llvm.mlir.constant(9 : index) : i64
    %30 = llvm.insertvalue %29, %28[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %31 = llvm.mlir.constant(3 : index) : i64
    %32 = llvm.insertvalue %31, %30[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %33 = llvm.mlir.constant(3 : index) : i64
    %34 = llvm.insertvalue %33, %32[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %35 = llvm.mlir.constant(3 : index) : i64
    %36 = llvm.insertvalue %35, %34[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.insertvalue %37, %36[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %39 = llvm.mlir.constant(1 : index) : i64
    %40 = llvm.insertvalue %39, %38[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.insertvalue %41, %40[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %43 = builtin.unrealized_conversion_cast %42 : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> to memref<8x3x3x1xf32>
    %44 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %45 = llvm.insertvalue %arg2, %44[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %46 = llvm.insertvalue %arg2, %45[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %47 = llvm.mlir.constant(0 : index) : i64
    %48 = llvm.insertvalue %47, %46[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %49 = llvm.mlir.constant(1 : index) : i64
    %50 = llvm.insertvalue %49, %48[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %51 = llvm.mlir.constant(32 : index) : i64
    %52 = llvm.insertvalue %51, %50[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %53 = llvm.mlir.constant(2 : index) : i64
    %54 = llvm.insertvalue %53, %52[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %55 = llvm.mlir.constant(16 : index) : i64
    %56 = llvm.insertvalue %55, %54[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %57 = llvm.mlir.constant(2 : index) : i64
    %58 = llvm.insertvalue %57, %56[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %59 = llvm.mlir.constant(8 : index) : i64
    %60 = llvm.insertvalue %59, %58[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %61 = llvm.mlir.constant(8 : index) : i64
    %62 = llvm.insertvalue %61, %60[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.insertvalue %63, %62[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %65 = builtin.unrealized_conversion_cast %64 : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> to memref<1x2x2x8xf32>
    %66 = builtin.unrealized_conversion_cast %21 : memref<1x4x4x1xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %67 = builtin.unrealized_conversion_cast %43 : memref<8x3x3x1xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %68 = builtin.unrealized_conversion_cast %65 : memref<1x2x2x8xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %69 = llvm.mlir.constant(288 : index) : i64
    %70 = llvm.mlir.constant(3 : index) : i64
    %71 = llvm.mlir.constant(8 : index) : i64
    %72 = llvm.mlir.constant(2 : index) : i64
    %73 = llvm.mlir.constant(0 : index) : i64
    %74 = builtin.unrealized_conversion_cast %73 : i64 to index
    %75 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%73 : i64)
  ^bb1(%76: i64):  // 2 preds: ^bb0, ^bb2
    %77 = builtin.unrealized_conversion_cast %76 : i64 to index
    %78 = builtin.unrealized_conversion_cast %77 : index to i64
    %79 = llvm.icmp "slt" %78, %69 : i64
    llvm.cond_br %79, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %80 = llvm.mlir.constant(1 : index) : i64
    %81 = llvm.mlir.constant(0 : index) : i64
    %82 = llvm.mlir.constant(-1 : index) : i64
    %83 = llvm.mlir.constant(false) : i1
    %84 = llvm.select %83, %80, %82 : i1, i64
    %85 = llvm.sub %84, %78  : i64
    %86 = llvm.sdiv %85, %70  : i64
    %87 = llvm.sub %82, %86  : i64
    %88 = llvm.sdiv %78, %70  : i64
    %89 = llvm.icmp "slt" %78, %81 : i64
    %90 = llvm.icmp "sgt" %78, %81 : i64
    %91 = llvm.mlir.constant(false) : i1
    %92 = llvm.mlir.constant(true) : i1
    %93 = llvm.and %89, %92  : i1
    %94 = llvm.and %90, %91  : i1
    %95 = llvm.or %93, %94  : i1
    %96 = llvm.select %95, %87, %88 : i1, i64
    %97 = llvm.mul %96, %70  : i64
    %98 = llvm.sub %78, %97  : i64
    %99 = builtin.unrealized_conversion_cast %98 : i64 to index
    %100 = llvm.sdiv %78, %70  : i64
    %101 = llvm.mlir.constant(1 : index) : i64
    %102 = llvm.mlir.constant(0 : index) : i64
    %103 = llvm.mlir.constant(-1 : index) : i64
    %104 = llvm.mlir.constant(false) : i1
    %105 = llvm.select %104, %101, %103 : i1, i64
    %106 = llvm.sub %105, %100  : i64
    %107 = llvm.sdiv %106, %70  : i64
    %108 = llvm.sub %103, %107  : i64
    %109 = llvm.sdiv %100, %70  : i64
    %110 = llvm.icmp "slt" %100, %102 : i64
    %111 = llvm.icmp "sgt" %100, %102 : i64
    %112 = llvm.mlir.constant(false) : i1
    %113 = llvm.mlir.constant(true) : i1
    %114 = llvm.and %110, %113  : i1
    %115 = llvm.and %111, %112  : i1
    %116 = llvm.or %114, %115  : i1
    %117 = llvm.select %116, %108, %109 : i1, i64
    %118 = llvm.mul %117, %70  : i64
    %119 = llvm.sub %100, %118  : i64
    %120 = builtin.unrealized_conversion_cast %119 : i64 to index
    %121 = llvm.sdiv %100, %70  : i64
    %122 = llvm.mlir.constant(1 : index) : i64
    %123 = llvm.mlir.constant(0 : index) : i64
    %124 = llvm.mlir.constant(-1 : index) : i64
    %125 = llvm.mlir.constant(false) : i1
    %126 = llvm.select %125, %122, %124 : i1, i64
    %127 = llvm.sub %126, %121  : i64
    %128 = llvm.sdiv %127, %71  : i64
    %129 = llvm.sub %124, %128  : i64
    %130 = llvm.sdiv %121, %71  : i64
    %131 = llvm.icmp "slt" %121, %123 : i64
    %132 = llvm.icmp "sgt" %121, %123 : i64
    %133 = llvm.mlir.constant(false) : i1
    %134 = llvm.mlir.constant(true) : i1
    %135 = llvm.and %131, %134  : i1
    %136 = llvm.and %132, %133  : i1
    %137 = llvm.or %135, %136  : i1
    %138 = llvm.select %137, %129, %130 : i1, i64
    %139 = llvm.mul %138, %71  : i64
    %140 = llvm.sub %121, %139  : i64
    %141 = builtin.unrealized_conversion_cast %140 : i64 to index
    %142 = llvm.sdiv %121, %71  : i64
    %143 = llvm.mlir.constant(1 : index) : i64
    %144 = llvm.mlir.constant(0 : index) : i64
    %145 = llvm.mlir.constant(-1 : index) : i64
    %146 = llvm.mlir.constant(false) : i1
    %147 = llvm.select %146, %143, %145 : i1, i64
    %148 = llvm.sub %147, %142  : i64
    %149 = llvm.sdiv %148, %72  : i64
    %150 = llvm.sub %145, %149  : i64
    %151 = llvm.sdiv %142, %72  : i64
    %152 = llvm.icmp "slt" %142, %144 : i64
    %153 = llvm.icmp "sgt" %142, %144 : i64
    %154 = llvm.mlir.constant(false) : i1
    %155 = llvm.mlir.constant(true) : i1
    %156 = llvm.and %152, %155  : i1
    %157 = llvm.and %153, %154  : i1
    %158 = llvm.or %156, %157  : i1
    %159 = llvm.select %158, %150, %151 : i1, i64
    %160 = llvm.mul %159, %72  : i64
    %161 = llvm.sub %142, %160  : i64
    %162 = builtin.unrealized_conversion_cast %161 : i64 to index
    %163 = llvm.sdiv %142, %72  : i64
    %164 = builtin.unrealized_conversion_cast %163 : i64 to index
    %165 = llvm.add %163, %119  : i64
    %166 = builtin.unrealized_conversion_cast %165 : i64 to index
    %167 = llvm.add %161, %98  : i64
    %168 = builtin.unrealized_conversion_cast %167 : i64 to index
    %169 = llvm.extractvalue %66[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %170 = llvm.mlir.constant(16 : index) : i64
    %171 = llvm.mul %73, %170  : i64
    %172 = llvm.mlir.constant(4 : index) : i64
    %173 = llvm.mul %165, %172  : i64
    %174 = llvm.add %171, %173  : i64
    %175 = llvm.add %174, %167  : i64
    %176 = llvm.add %175, %73  : i64
    %177 = llvm.getelementptr %169[%176] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %178 = llvm.load %177 : !llvm.ptr<f32>
    %179 = llvm.extractvalue %67[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %180 = llvm.mlir.constant(9 : index) : i64
    %181 = llvm.mul %140, %180  : i64
    %182 = llvm.mlir.constant(3 : index) : i64
    %183 = llvm.mul %119, %182  : i64
    %184 = llvm.add %181, %183  : i64
    %185 = llvm.add %184, %98  : i64
    %186 = llvm.add %185, %73  : i64
    %187 = llvm.getelementptr %179[%186] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %188 = llvm.load %187 : !llvm.ptr<f32>
    %189 = llvm.extractvalue %68[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %190 = llvm.mlir.constant(32 : index) : i64
    %191 = llvm.mul %73, %190  : i64
    %192 = llvm.mlir.constant(16 : index) : i64
    %193 = llvm.mul %163, %192  : i64
    %194 = llvm.add %191, %193  : i64
    %195 = llvm.mlir.constant(8 : index) : i64
    %196 = llvm.mul %161, %195  : i64
    %197 = llvm.add %194, %196  : i64
    %198 = llvm.add %197, %140  : i64
    %199 = llvm.getelementptr %189[%198] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %200 = llvm.load %199 : !llvm.ptr<f32>
    %201 = llvm.fmul %178, %188  : f32
    %202 = llvm.fadd %200, %201  : f32
    %203 = llvm.extractvalue %68[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %204 = llvm.mlir.constant(32 : index) : i64
    %205 = llvm.mul %73, %204  : i64
    %206 = llvm.mlir.constant(16 : index) : i64
    %207 = llvm.mul %163, %206  : i64
    %208 = llvm.add %205, %207  : i64
    %209 = llvm.mlir.constant(8 : index) : i64
    %210 = llvm.mul %161, %209  : i64
    %211 = llvm.add %208, %210  : i64
    %212 = llvm.add %211, %140  : i64
    %213 = llvm.getelementptr %203[%212] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %202, %213 : !llvm.ptr<f32>
    %214 = llvm.add %78, %75  : i64
    %215 = builtin.unrealized_conversion_cast %214 : i64 to index
    llvm.br ^bb1(%214 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @please_map_me() attributes {sym_visibility = "private"}
}


// -----// IR Dump After ConvertControlFlowToLLVM (convert-cf-to-llvm) //----- //
module attributes {llvm.data_layout = "", soda.bambu.container_module, soda.container_module} {
  llvm.func @generic_0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %7 = llvm.mlir.constant(16 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %9 = llvm.mlir.constant(4 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %11 = llvm.mlir.constant(4 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %13 = llvm.mlir.constant(4 : index) : i64
    %14 = llvm.insertvalue %13, %12[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.insertvalue %15, %14[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.insertvalue %17, %16[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.insertvalue %19, %18[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %21 = builtin.unrealized_conversion_cast %20 : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> to memref<1x4x4x1xf32>
    %22 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %23 = llvm.insertvalue %arg1, %22[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.insertvalue %arg1, %23[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %27 = llvm.mlir.constant(8 : index) : i64
    %28 = llvm.insertvalue %27, %26[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %29 = llvm.mlir.constant(9 : index) : i64
    %30 = llvm.insertvalue %29, %28[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %31 = llvm.mlir.constant(3 : index) : i64
    %32 = llvm.insertvalue %31, %30[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %33 = llvm.mlir.constant(3 : index) : i64
    %34 = llvm.insertvalue %33, %32[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %35 = llvm.mlir.constant(3 : index) : i64
    %36 = llvm.insertvalue %35, %34[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.insertvalue %37, %36[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %39 = llvm.mlir.constant(1 : index) : i64
    %40 = llvm.insertvalue %39, %38[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %41 = llvm.mlir.constant(1 : index) : i64
    %42 = llvm.insertvalue %41, %40[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %43 = builtin.unrealized_conversion_cast %42 : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> to memref<8x3x3x1xf32>
    %44 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %45 = llvm.insertvalue %arg2, %44[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %46 = llvm.insertvalue %arg2, %45[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %47 = llvm.mlir.constant(0 : index) : i64
    %48 = llvm.insertvalue %47, %46[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %49 = llvm.mlir.constant(1 : index) : i64
    %50 = llvm.insertvalue %49, %48[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %51 = llvm.mlir.constant(32 : index) : i64
    %52 = llvm.insertvalue %51, %50[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %53 = llvm.mlir.constant(2 : index) : i64
    %54 = llvm.insertvalue %53, %52[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %55 = llvm.mlir.constant(16 : index) : i64
    %56 = llvm.insertvalue %55, %54[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %57 = llvm.mlir.constant(2 : index) : i64
    %58 = llvm.insertvalue %57, %56[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %59 = llvm.mlir.constant(8 : index) : i64
    %60 = llvm.insertvalue %59, %58[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %61 = llvm.mlir.constant(8 : index) : i64
    %62 = llvm.insertvalue %61, %60[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %63 = llvm.mlir.constant(1 : index) : i64
    %64 = llvm.insertvalue %63, %62[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %65 = builtin.unrealized_conversion_cast %64 : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> to memref<1x2x2x8xf32>
    %66 = builtin.unrealized_conversion_cast %21 : memref<1x4x4x1xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %67 = builtin.unrealized_conversion_cast %43 : memref<8x3x3x1xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %68 = builtin.unrealized_conversion_cast %65 : memref<1x2x2x8xf32> to !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %69 = llvm.mlir.constant(288 : index) : i64
    %70 = llvm.mlir.constant(3 : index) : i64
    %71 = llvm.mlir.constant(8 : index) : i64
    %72 = llvm.mlir.constant(2 : index) : i64
    %73 = llvm.mlir.constant(0 : index) : i64
    %74 = builtin.unrealized_conversion_cast %73 : i64 to index
    %75 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%73 : i64)
  ^bb1(%76: i64):  // 2 preds: ^bb0, ^bb2
    %77 = builtin.unrealized_conversion_cast %76 : i64 to index
    %78 = builtin.unrealized_conversion_cast %77 : index to i64
    %79 = llvm.icmp "slt" %78, %69 : i64
    llvm.cond_br %79, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %80 = llvm.mlir.constant(1 : index) : i64
    %81 = llvm.mlir.constant(0 : index) : i64
    %82 = llvm.mlir.constant(-1 : index) : i64
    %83 = llvm.mlir.constant(false) : i1
    %84 = llvm.select %83, %80, %82 : i1, i64
    %85 = llvm.sub %84, %78  : i64
    %86 = llvm.sdiv %85, %70  : i64
    %87 = llvm.sub %82, %86  : i64
    %88 = llvm.sdiv %78, %70  : i64
    %89 = llvm.icmp "slt" %78, %81 : i64
    %90 = llvm.icmp "sgt" %78, %81 : i64
    %91 = llvm.mlir.constant(false) : i1
    %92 = llvm.mlir.constant(true) : i1
    %93 = llvm.and %89, %92  : i1
    %94 = llvm.and %90, %91  : i1
    %95 = llvm.or %93, %94  : i1
    %96 = llvm.select %95, %87, %88 : i1, i64
    %97 = llvm.mul %96, %70  : i64
    %98 = llvm.sub %78, %97  : i64
    %99 = builtin.unrealized_conversion_cast %98 : i64 to index
    %100 = llvm.sdiv %78, %70  : i64
    %101 = llvm.mlir.constant(1 : index) : i64
    %102 = llvm.mlir.constant(0 : index) : i64
    %103 = llvm.mlir.constant(-1 : index) : i64
    %104 = llvm.mlir.constant(false) : i1
    %105 = llvm.select %104, %101, %103 : i1, i64
    %106 = llvm.sub %105, %100  : i64
    %107 = llvm.sdiv %106, %70  : i64
    %108 = llvm.sub %103, %107  : i64
    %109 = llvm.sdiv %100, %70  : i64
    %110 = llvm.icmp "slt" %100, %102 : i64
    %111 = llvm.icmp "sgt" %100, %102 : i64
    %112 = llvm.mlir.constant(false) : i1
    %113 = llvm.mlir.constant(true) : i1
    %114 = llvm.and %110, %113  : i1
    %115 = llvm.and %111, %112  : i1
    %116 = llvm.or %114, %115  : i1
    %117 = llvm.select %116, %108, %109 : i1, i64
    %118 = llvm.mul %117, %70  : i64
    %119 = llvm.sub %100, %118  : i64
    %120 = builtin.unrealized_conversion_cast %119 : i64 to index
    %121 = llvm.sdiv %100, %70  : i64
    %122 = llvm.mlir.constant(1 : index) : i64
    %123 = llvm.mlir.constant(0 : index) : i64
    %124 = llvm.mlir.constant(-1 : index) : i64
    %125 = llvm.mlir.constant(false) : i1
    %126 = llvm.select %125, %122, %124 : i1, i64
    %127 = llvm.sub %126, %121  : i64
    %128 = llvm.sdiv %127, %71  : i64
    %129 = llvm.sub %124, %128  : i64
    %130 = llvm.sdiv %121, %71  : i64
    %131 = llvm.icmp "slt" %121, %123 : i64
    %132 = llvm.icmp "sgt" %121, %123 : i64
    %133 = llvm.mlir.constant(false) : i1
    %134 = llvm.mlir.constant(true) : i1
    %135 = llvm.and %131, %134  : i1
    %136 = llvm.and %132, %133  : i1
    %137 = llvm.or %135, %136  : i1
    %138 = llvm.select %137, %129, %130 : i1, i64
    %139 = llvm.mul %138, %71  : i64
    %140 = llvm.sub %121, %139  : i64
    %141 = builtin.unrealized_conversion_cast %140 : i64 to index
    %142 = llvm.sdiv %121, %71  : i64
    %143 = llvm.mlir.constant(1 : index) : i64
    %144 = llvm.mlir.constant(0 : index) : i64
    %145 = llvm.mlir.constant(-1 : index) : i64
    %146 = llvm.mlir.constant(false) : i1
    %147 = llvm.select %146, %143, %145 : i1, i64
    %148 = llvm.sub %147, %142  : i64
    %149 = llvm.sdiv %148, %72  : i64
    %150 = llvm.sub %145, %149  : i64
    %151 = llvm.sdiv %142, %72  : i64
    %152 = llvm.icmp "slt" %142, %144 : i64
    %153 = llvm.icmp "sgt" %142, %144 : i64
    %154 = llvm.mlir.constant(false) : i1
    %155 = llvm.mlir.constant(true) : i1
    %156 = llvm.and %152, %155  : i1
    %157 = llvm.and %153, %154  : i1
    %158 = llvm.or %156, %157  : i1
    %159 = llvm.select %158, %150, %151 : i1, i64
    %160 = llvm.mul %159, %72  : i64
    %161 = llvm.sub %142, %160  : i64
    %162 = builtin.unrealized_conversion_cast %161 : i64 to index
    %163 = llvm.sdiv %142, %72  : i64
    %164 = builtin.unrealized_conversion_cast %163 : i64 to index
    %165 = llvm.add %163, %119  : i64
    %166 = builtin.unrealized_conversion_cast %165 : i64 to index
    %167 = llvm.add %161, %98  : i64
    %168 = builtin.unrealized_conversion_cast %167 : i64 to index
    %169 = llvm.extractvalue %66[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %170 = llvm.mlir.constant(16 : index) : i64
    %171 = llvm.mul %73, %170  : i64
    %172 = llvm.mlir.constant(4 : index) : i64
    %173 = llvm.mul %165, %172  : i64
    %174 = llvm.add %171, %173  : i64
    %175 = llvm.add %174, %167  : i64
    %176 = llvm.add %175, %73  : i64
    %177 = llvm.getelementptr %169[%176] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %178 = llvm.load %177 : !llvm.ptr<f32>
    %179 = llvm.extractvalue %67[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %180 = llvm.mlir.constant(9 : index) : i64
    %181 = llvm.mul %140, %180  : i64
    %182 = llvm.mlir.constant(3 : index) : i64
    %183 = llvm.mul %119, %182  : i64
    %184 = llvm.add %181, %183  : i64
    %185 = llvm.add %184, %98  : i64
    %186 = llvm.add %185, %73  : i64
    %187 = llvm.getelementptr %179[%186] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %188 = llvm.load %187 : !llvm.ptr<f32>
    %189 = llvm.extractvalue %68[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %190 = llvm.mlir.constant(32 : index) : i64
    %191 = llvm.mul %73, %190  : i64
    %192 = llvm.mlir.constant(16 : index) : i64
    %193 = llvm.mul %163, %192  : i64
    %194 = llvm.add %191, %193  : i64
    %195 = llvm.mlir.constant(8 : index) : i64
    %196 = llvm.mul %161, %195  : i64
    %197 = llvm.add %194, %196  : i64
    %198 = llvm.add %197, %140  : i64
    %199 = llvm.getelementptr %189[%198] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %200 = llvm.load %199 : !llvm.ptr<f32>
    %201 = llvm.fmul %178, %188  : f32
    %202 = llvm.fadd %200, %201  : f32
    %203 = llvm.extractvalue %68[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %204 = llvm.mlir.constant(32 : index) : i64
    %205 = llvm.mul %73, %204  : i64
    %206 = llvm.mlir.constant(16 : index) : i64
    %207 = llvm.mul %163, %206  : i64
    %208 = llvm.add %205, %207  : i64
    %209 = llvm.mlir.constant(8 : index) : i64
    %210 = llvm.mul %161, %209  : i64
    %211 = llvm.add %208, %210  : i64
    %212 = llvm.add %211, %140  : i64
    %213 = llvm.getelementptr %203[%212] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %202, %213 : !llvm.ptr<f32>
    %214 = llvm.add %78, %75  : i64
    %215 = builtin.unrealized_conversion_cast %214 : i64 to index
    llvm.br ^bb1(%214 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @please_map_me() attributes {sym_visibility = "private"}
}


// -----// IR Dump After ReconcileUnrealizedCasts (reconcile-unrealized-casts) //----- //
module attributes {llvm.data_layout = "", soda.bambu.container_module, soda.container_module} {
  llvm.func @generic_0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %7 = llvm.mlir.constant(16 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %9 = llvm.mlir.constant(4 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %11 = llvm.mlir.constant(4 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %13 = llvm.mlir.constant(4 : index) : i64
    %14 = llvm.insertvalue %13, %12[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.insertvalue %15, %14[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.insertvalue %17, %16[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.insertvalue %19, %18[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %21 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %22 = llvm.insertvalue %arg1, %21[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %23 = llvm.insertvalue %arg1, %22[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.mlir.constant(0 : index) : i64
    %25 = llvm.insertvalue %24, %23[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %26 = llvm.mlir.constant(8 : index) : i64
    %27 = llvm.insertvalue %26, %25[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %28 = llvm.mlir.constant(9 : index) : i64
    %29 = llvm.insertvalue %28, %27[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %30 = llvm.mlir.constant(3 : index) : i64
    %31 = llvm.insertvalue %30, %29[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %32 = llvm.mlir.constant(3 : index) : i64
    %33 = llvm.insertvalue %32, %31[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %34 = llvm.mlir.constant(3 : index) : i64
    %35 = llvm.insertvalue %34, %33[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %36 = llvm.mlir.constant(1 : index) : i64
    %37 = llvm.insertvalue %36, %35[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %38 = llvm.mlir.constant(1 : index) : i64
    %39 = llvm.insertvalue %38, %37[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.insertvalue %40, %39[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %42 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %43 = llvm.insertvalue %arg2, %42[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %44 = llvm.insertvalue %arg2, %43[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %45 = llvm.mlir.constant(0 : index) : i64
    %46 = llvm.insertvalue %45, %44[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %47 = llvm.mlir.constant(1 : index) : i64
    %48 = llvm.insertvalue %47, %46[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %49 = llvm.mlir.constant(32 : index) : i64
    %50 = llvm.insertvalue %49, %48[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %51 = llvm.mlir.constant(2 : index) : i64
    %52 = llvm.insertvalue %51, %50[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %53 = llvm.mlir.constant(16 : index) : i64
    %54 = llvm.insertvalue %53, %52[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %55 = llvm.mlir.constant(2 : index) : i64
    %56 = llvm.insertvalue %55, %54[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %57 = llvm.mlir.constant(8 : index) : i64
    %58 = llvm.insertvalue %57, %56[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %59 = llvm.mlir.constant(8 : index) : i64
    %60 = llvm.insertvalue %59, %58[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %61 = llvm.mlir.constant(1 : index) : i64
    %62 = llvm.insertvalue %61, %60[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %63 = llvm.mlir.constant(288 : index) : i64
    %64 = llvm.mlir.constant(3 : index) : i64
    %65 = llvm.mlir.constant(8 : index) : i64
    %66 = llvm.mlir.constant(2 : index) : i64
    %67 = llvm.mlir.constant(0 : index) : i64
    %68 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%67 : i64)
  ^bb1(%69: i64):  // 2 preds: ^bb0, ^bb2
    %70 = llvm.icmp "slt" %69, %63 : i64
    llvm.cond_br %70, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %71 = llvm.mlir.constant(1 : index) : i64
    %72 = llvm.mlir.constant(0 : index) : i64
    %73 = llvm.mlir.constant(-1 : index) : i64
    %74 = llvm.mlir.constant(false) : i1
    %75 = llvm.select %74, %71, %73 : i1, i64
    %76 = llvm.sub %75, %69  : i64
    %77 = llvm.sdiv %76, %64  : i64
    %78 = llvm.sub %73, %77  : i64
    %79 = llvm.sdiv %69, %64  : i64
    %80 = llvm.icmp "slt" %69, %72 : i64
    %81 = llvm.icmp "sgt" %69, %72 : i64
    %82 = llvm.mlir.constant(false) : i1
    %83 = llvm.mlir.constant(true) : i1
    %84 = llvm.and %80, %83  : i1
    %85 = llvm.and %81, %82  : i1
    %86 = llvm.or %84, %85  : i1
    %87 = llvm.select %86, %78, %79 : i1, i64
    %88 = llvm.mul %87, %64  : i64
    %89 = llvm.sub %69, %88  : i64
    %90 = llvm.sdiv %69, %64  : i64
    %91 = llvm.mlir.constant(1 : index) : i64
    %92 = llvm.mlir.constant(0 : index) : i64
    %93 = llvm.mlir.constant(-1 : index) : i64
    %94 = llvm.mlir.constant(false) : i1
    %95 = llvm.select %94, %91, %93 : i1, i64
    %96 = llvm.sub %95, %90  : i64
    %97 = llvm.sdiv %96, %64  : i64
    %98 = llvm.sub %93, %97  : i64
    %99 = llvm.sdiv %90, %64  : i64
    %100 = llvm.icmp "slt" %90, %92 : i64
    %101 = llvm.icmp "sgt" %90, %92 : i64
    %102 = llvm.mlir.constant(false) : i1
    %103 = llvm.mlir.constant(true) : i1
    %104 = llvm.and %100, %103  : i1
    %105 = llvm.and %101, %102  : i1
    %106 = llvm.or %104, %105  : i1
    %107 = llvm.select %106, %98, %99 : i1, i64
    %108 = llvm.mul %107, %64  : i64
    %109 = llvm.sub %90, %108  : i64
    %110 = llvm.sdiv %90, %64  : i64
    %111 = llvm.mlir.constant(1 : index) : i64
    %112 = llvm.mlir.constant(0 : index) : i64
    %113 = llvm.mlir.constant(-1 : index) : i64
    %114 = llvm.mlir.constant(false) : i1
    %115 = llvm.select %114, %111, %113 : i1, i64
    %116 = llvm.sub %115, %110  : i64
    %117 = llvm.sdiv %116, %65  : i64
    %118 = llvm.sub %113, %117  : i64
    %119 = llvm.sdiv %110, %65  : i64
    %120 = llvm.icmp "slt" %110, %112 : i64
    %121 = llvm.icmp "sgt" %110, %112 : i64
    %122 = llvm.mlir.constant(false) : i1
    %123 = llvm.mlir.constant(true) : i1
    %124 = llvm.and %120, %123  : i1
    %125 = llvm.and %121, %122  : i1
    %126 = llvm.or %124, %125  : i1
    %127 = llvm.select %126, %118, %119 : i1, i64
    %128 = llvm.mul %127, %65  : i64
    %129 = llvm.sub %110, %128  : i64
    %130 = llvm.sdiv %110, %65  : i64
    %131 = llvm.mlir.constant(1 : index) : i64
    %132 = llvm.mlir.constant(0 : index) : i64
    %133 = llvm.mlir.constant(-1 : index) : i64
    %134 = llvm.mlir.constant(false) : i1
    %135 = llvm.select %134, %131, %133 : i1, i64
    %136 = llvm.sub %135, %130  : i64
    %137 = llvm.sdiv %136, %66  : i64
    %138 = llvm.sub %133, %137  : i64
    %139 = llvm.sdiv %130, %66  : i64
    %140 = llvm.icmp "slt" %130, %132 : i64
    %141 = llvm.icmp "sgt" %130, %132 : i64
    %142 = llvm.mlir.constant(false) : i1
    %143 = llvm.mlir.constant(true) : i1
    %144 = llvm.and %140, %143  : i1
    %145 = llvm.and %141, %142  : i1
    %146 = llvm.or %144, %145  : i1
    %147 = llvm.select %146, %138, %139 : i1, i64
    %148 = llvm.mul %147, %66  : i64
    %149 = llvm.sub %130, %148  : i64
    %150 = llvm.sdiv %130, %66  : i64
    %151 = llvm.add %150, %109  : i64
    %152 = llvm.add %149, %89  : i64
    %153 = llvm.extractvalue %20[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %154 = llvm.mlir.constant(16 : index) : i64
    %155 = llvm.mul %67, %154  : i64
    %156 = llvm.mlir.constant(4 : index) : i64
    %157 = llvm.mul %151, %156  : i64
    %158 = llvm.add %155, %157  : i64
    %159 = llvm.add %158, %152  : i64
    %160 = llvm.add %159, %67  : i64
    %161 = llvm.getelementptr %153[%160] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %162 = llvm.load %161 : !llvm.ptr<f32>
    %163 = llvm.extractvalue %41[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %164 = llvm.mlir.constant(9 : index) : i64
    %165 = llvm.mul %129, %164  : i64
    %166 = llvm.mlir.constant(3 : index) : i64
    %167 = llvm.mul %109, %166  : i64
    %168 = llvm.add %165, %167  : i64
    %169 = llvm.add %168, %89  : i64
    %170 = llvm.add %169, %67  : i64
    %171 = llvm.getelementptr %163[%170] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %172 = llvm.load %171 : !llvm.ptr<f32>
    %173 = llvm.extractvalue %62[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %174 = llvm.mlir.constant(32 : index) : i64
    %175 = llvm.mul %67, %174  : i64
    %176 = llvm.mlir.constant(16 : index) : i64
    %177 = llvm.mul %150, %176  : i64
    %178 = llvm.add %175, %177  : i64
    %179 = llvm.mlir.constant(8 : index) : i64
    %180 = llvm.mul %149, %179  : i64
    %181 = llvm.add %178, %180  : i64
    %182 = llvm.add %181, %129  : i64
    %183 = llvm.getelementptr %173[%182] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %184 = llvm.load %183 : !llvm.ptr<f32>
    %185 = llvm.fmul %162, %172  : f32
    %186 = llvm.fadd %184, %185  : f32
    %187 = llvm.extractvalue %62[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %188 = llvm.mlir.constant(32 : index) : i64
    %189 = llvm.mul %67, %188  : i64
    %190 = llvm.mlir.constant(16 : index) : i64
    %191 = llvm.mul %150, %190  : i64
    %192 = llvm.add %189, %191  : i64
    %193 = llvm.mlir.constant(8 : index) : i64
    %194 = llvm.mul %149, %193  : i64
    %195 = llvm.add %192, %194  : i64
    %196 = llvm.add %195, %129  : i64
    %197 = llvm.getelementptr %187[%196] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %186, %197 : !llvm.ptr<f32>
    %198 = llvm.add %69, %68  : i64
    llvm.br ^bb1(%198 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @please_map_me() attributes {sym_visibility = "private"}
}


module attributes {llvm.data_layout = "", soda.bambu.container_module, soda.container_module} {
  llvm.func @generic_0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<f32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %5 = llvm.mlir.constant(1 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %7 = llvm.mlir.constant(16 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %9 = llvm.mlir.constant(4 : index) : i64
    %10 = llvm.insertvalue %9, %8[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %11 = llvm.mlir.constant(4 : index) : i64
    %12 = llvm.insertvalue %11, %10[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %13 = llvm.mlir.constant(4 : index) : i64
    %14 = llvm.insertvalue %13, %12[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %15 = llvm.mlir.constant(1 : index) : i64
    %16 = llvm.insertvalue %15, %14[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.insertvalue %17, %16[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %19 = llvm.mlir.constant(1 : index) : i64
    %20 = llvm.insertvalue %19, %18[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %21 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %22 = llvm.insertvalue %arg1, %21[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %23 = llvm.insertvalue %arg1, %22[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %24 = llvm.mlir.constant(0 : index) : i64
    %25 = llvm.insertvalue %24, %23[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %26 = llvm.mlir.constant(8 : index) : i64
    %27 = llvm.insertvalue %26, %25[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %28 = llvm.mlir.constant(9 : index) : i64
    %29 = llvm.insertvalue %28, %27[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %30 = llvm.mlir.constant(3 : index) : i64
    %31 = llvm.insertvalue %30, %29[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %32 = llvm.mlir.constant(3 : index) : i64
    %33 = llvm.insertvalue %32, %31[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %34 = llvm.mlir.constant(3 : index) : i64
    %35 = llvm.insertvalue %34, %33[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %36 = llvm.mlir.constant(1 : index) : i64
    %37 = llvm.insertvalue %36, %35[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %38 = llvm.mlir.constant(1 : index) : i64
    %39 = llvm.insertvalue %38, %37[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %40 = llvm.mlir.constant(1 : index) : i64
    %41 = llvm.insertvalue %40, %39[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %42 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %43 = llvm.insertvalue %arg2, %42[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %44 = llvm.insertvalue %arg2, %43[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %45 = llvm.mlir.constant(0 : index) : i64
    %46 = llvm.insertvalue %45, %44[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %47 = llvm.mlir.constant(1 : index) : i64
    %48 = llvm.insertvalue %47, %46[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %49 = llvm.mlir.constant(32 : index) : i64
    %50 = llvm.insertvalue %49, %48[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %51 = llvm.mlir.constant(2 : index) : i64
    %52 = llvm.insertvalue %51, %50[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %53 = llvm.mlir.constant(16 : index) : i64
    %54 = llvm.insertvalue %53, %52[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %55 = llvm.mlir.constant(2 : index) : i64
    %56 = llvm.insertvalue %55, %54[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %57 = llvm.mlir.constant(8 : index) : i64
    %58 = llvm.insertvalue %57, %56[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %59 = llvm.mlir.constant(8 : index) : i64
    %60 = llvm.insertvalue %59, %58[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %61 = llvm.mlir.constant(1 : index) : i64
    %62 = llvm.insertvalue %61, %60[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %63 = llvm.mlir.constant(288 : index) : i64
    %64 = llvm.mlir.constant(3 : index) : i64
    %65 = llvm.mlir.constant(8 : index) : i64
    %66 = llvm.mlir.constant(2 : index) : i64
    %67 = llvm.mlir.constant(0 : index) : i64
    %68 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%67 : i64)
  ^bb1(%69: i64):  // 2 preds: ^bb0, ^bb2
    %70 = llvm.icmp "slt" %69, %63 : i64
    llvm.cond_br %70, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %71 = llvm.mlir.constant(1 : index) : i64
    %72 = llvm.mlir.constant(0 : index) : i64
    %73 = llvm.mlir.constant(-1 : index) : i64
    %74 = llvm.mlir.constant(false) : i1
    %75 = llvm.select %74, %71, %73 : i1, i64
    %76 = llvm.sub %75, %69  : i64
    %77 = llvm.sdiv %76, %64  : i64
    %78 = llvm.sub %73, %77  : i64
    %79 = llvm.sdiv %69, %64  : i64
    %80 = llvm.icmp "slt" %69, %72 : i64
    %81 = llvm.icmp "sgt" %69, %72 : i64
    %82 = llvm.mlir.constant(false) : i1
    %83 = llvm.mlir.constant(true) : i1
    %84 = llvm.and %80, %83  : i1
    %85 = llvm.and %81, %82  : i1
    %86 = llvm.or %84, %85  : i1
    %87 = llvm.select %86, %78, %79 : i1, i64
    %88 = llvm.mul %87, %64  : i64
    %89 = llvm.sub %69, %88  : i64
    %90 = llvm.sdiv %69, %64  : i64
    %91 = llvm.mlir.constant(1 : index) : i64
    %92 = llvm.mlir.constant(0 : index) : i64
    %93 = llvm.mlir.constant(-1 : index) : i64
    %94 = llvm.mlir.constant(false) : i1
    %95 = llvm.select %94, %91, %93 : i1, i64
    %96 = llvm.sub %95, %90  : i64
    %97 = llvm.sdiv %96, %64  : i64
    %98 = llvm.sub %93, %97  : i64
    %99 = llvm.sdiv %90, %64  : i64
    %100 = llvm.icmp "slt" %90, %92 : i64
    %101 = llvm.icmp "sgt" %90, %92 : i64
    %102 = llvm.mlir.constant(false) : i1
    %103 = llvm.mlir.constant(true) : i1
    %104 = llvm.and %100, %103  : i1
    %105 = llvm.and %101, %102  : i1
    %106 = llvm.or %104, %105  : i1
    %107 = llvm.select %106, %98, %99 : i1, i64
    %108 = llvm.mul %107, %64  : i64
    %109 = llvm.sub %90, %108  : i64
    %110 = llvm.sdiv %90, %64  : i64
    %111 = llvm.mlir.constant(1 : index) : i64
    %112 = llvm.mlir.constant(0 : index) : i64
    %113 = llvm.mlir.constant(-1 : index) : i64
    %114 = llvm.mlir.constant(false) : i1
    %115 = llvm.select %114, %111, %113 : i1, i64
    %116 = llvm.sub %115, %110  : i64
    %117 = llvm.sdiv %116, %65  : i64
    %118 = llvm.sub %113, %117  : i64
    %119 = llvm.sdiv %110, %65  : i64
    %120 = llvm.icmp "slt" %110, %112 : i64
    %121 = llvm.icmp "sgt" %110, %112 : i64
    %122 = llvm.mlir.constant(false) : i1
    %123 = llvm.mlir.constant(true) : i1
    %124 = llvm.and %120, %123  : i1
    %125 = llvm.and %121, %122  : i1
    %126 = llvm.or %124, %125  : i1
    %127 = llvm.select %126, %118, %119 : i1, i64
    %128 = llvm.mul %127, %65  : i64
    %129 = llvm.sub %110, %128  : i64
    %130 = llvm.sdiv %110, %65  : i64
    %131 = llvm.mlir.constant(1 : index) : i64
    %132 = llvm.mlir.constant(0 : index) : i64
    %133 = llvm.mlir.constant(-1 : index) : i64
    %134 = llvm.mlir.constant(false) : i1
    %135 = llvm.select %134, %131, %133 : i1, i64
    %136 = llvm.sub %135, %130  : i64
    %137 = llvm.sdiv %136, %66  : i64
    %138 = llvm.sub %133, %137  : i64
    %139 = llvm.sdiv %130, %66  : i64
    %140 = llvm.icmp "slt" %130, %132 : i64
    %141 = llvm.icmp "sgt" %130, %132 : i64
    %142 = llvm.mlir.constant(false) : i1
    %143 = llvm.mlir.constant(true) : i1
    %144 = llvm.and %140, %143  : i1
    %145 = llvm.and %141, %142  : i1
    %146 = llvm.or %144, %145  : i1
    %147 = llvm.select %146, %138, %139 : i1, i64
    %148 = llvm.mul %147, %66  : i64
    %149 = llvm.sub %130, %148  : i64
    %150 = llvm.sdiv %130, %66  : i64
    %151 = llvm.add %150, %109  : i64
    %152 = llvm.add %149, %89  : i64
    %153 = llvm.extractvalue %20[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %154 = llvm.mlir.constant(16 : index) : i64
    %155 = llvm.mul %67, %154  : i64
    %156 = llvm.mlir.constant(4 : index) : i64
    %157 = llvm.mul %151, %156  : i64
    %158 = llvm.add %155, %157  : i64
    %159 = llvm.add %158, %152  : i64
    %160 = llvm.add %159, %67  : i64
    %161 = llvm.getelementptr %153[%160] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %162 = llvm.load %161 : !llvm.ptr<f32>
    %163 = llvm.extractvalue %41[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %164 = llvm.mlir.constant(9 : index) : i64
    %165 = llvm.mul %129, %164  : i64
    %166 = llvm.mlir.constant(3 : index) : i64
    %167 = llvm.mul %109, %166  : i64
    %168 = llvm.add %165, %167  : i64
    %169 = llvm.add %168, %89  : i64
    %170 = llvm.add %169, %67  : i64
    %171 = llvm.getelementptr %163[%170] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %172 = llvm.load %171 : !llvm.ptr<f32>
    %173 = llvm.extractvalue %62[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %174 = llvm.mlir.constant(32 : index) : i64
    %175 = llvm.mul %67, %174  : i64
    %176 = llvm.mlir.constant(16 : index) : i64
    %177 = llvm.mul %150, %176  : i64
    %178 = llvm.add %175, %177  : i64
    %179 = llvm.mlir.constant(8 : index) : i64
    %180 = llvm.mul %149, %179  : i64
    %181 = llvm.add %178, %180  : i64
    %182 = llvm.add %181, %129  : i64
    %183 = llvm.getelementptr %173[%182] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %184 = llvm.load %183 : !llvm.ptr<f32>
    %185 = llvm.fmul %162, %172  : f32
    %186 = llvm.fadd %184, %185  : f32
    %187 = llvm.extractvalue %62[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> 
    %188 = llvm.mlir.constant(32 : index) : i64
    %189 = llvm.mul %67, %188  : i64
    %190 = llvm.mlir.constant(16 : index) : i64
    %191 = llvm.mul %150, %190  : i64
    %192 = llvm.add %189, %191  : i64
    %193 = llvm.mlir.constant(8 : index) : i64
    %194 = llvm.mul %149, %193  : i64
    %195 = llvm.add %192, %194  : i64
    %196 = llvm.add %195, %129  : i64
    %197 = llvm.getelementptr %187[%196] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %186, %197 : !llvm.ptr<f32>
    %198 = llvm.add %69, %68  : i64
    llvm.br ^bb1(%198 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @please_map_me() attributes {sym_visibility = "private"}
}

