add-test
// -----// IR Dump After LinalgLowerToAffineLoops (convert-linalg-to-affine-loops) //----- //
func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
  %c0 = arith.constant 0 : index
  %c20 = arith.constant 20 : index
  cf.br ^bb1
^bb1:  // pred: ^bb0
  scf.for %arg3 = %c0 to %c20 step %c20 {
    %0 = memref.subview %arg0[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    %1 = memref.subview %arg1[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    %2 = memref.subview %arg2[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    affine.for %arg4 = 0 to 20 {
      %3 = affine.load %0[%arg4] : memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
      %4 = affine.load %1[%arg4] : memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
      %5 = arith.addi %3, %4 : i32
      affine.store %5, %2[%arg4] : memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    }
  }
  return
}

insert mark for // -----// IR Dump After LinalgLowerToAffineLoops (convert-linalg-to-affine-loops) //----- //
func.func @main() {
  %c0_i32 = arith.constant 0 : affine.fori 32%
arg4   = %0c1_i32 to  = 20arith.constant { 
1   : %i332 = 
affine.load   %%00 = [memref.alloc%(arg4)]  : : memref<20memref<x20ix32i, 32affine_map<>(
d  0%)1[ = smemref.alloc0(]) -> (d 0: +  s0memref<)20>x>i
32  >%
4   = %affine.load2  = %memref.alloc1([)%arg4 ]: :  memref<memref<2020xxii3232, >affine_map<
(  daffine.for0 )%[arg0s = 0]0 -> ( to d200  + {s
0)    >affine.store> 
%  c1_i32%, 5% = 0arith.addi[ %%3arg0,]  : %4memref< 20:x ii3232>

    affine.store} %5, %
2  [affine.for% arg4%]arg0 :  = memref<020 to x20i 32{, 
affine_map<    (affine.stored 0%)c1_i32[, s%01][ -> (%darg00] + s : 0)memref<>20>x
i}32>
  }

  affine.for %arg0 = 0 to 20 {
    affine.store %c0_i32, %2[%arg0] : memref<20xi32>
  }
  call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
  memref.dealloc %0 : memref<20xi32>
  memref.dealloc %1 : memref<20xi32>
  memref.dealloc %2 : memref<20xi32>
  return
}

// -----// IR Dump After MarkMapRegion (mark-map-region) //----- //
func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
  %c0 = arith.constant 0 : index
  %c20 = arith.constant 20 : index
  cf.br ^bb1
^bb1:  // pred: ^bb0
  scf.for %arg3 = %c0 to %c20 step %c20 {
    %0 = memref.subview %arg0[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    %1 = memref.subview %arg1[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    %2 = memref.subview %arg2[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    affine.for %arg4 = 0 to 20 {
      morpher.map_hint
      %3 = affine.load %0[%arg4] : memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
      %4 = affine.load %1[%arg4] : memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
      %5 = arith.addi %3, %4 : i32
      affine.store %5, %2[%arg4] : memref<20xi32, affine_map<(d0)[s0] -> (d0 + s0)>>
    }
  }
  return
}

// -----// IR Dump After MarkMapRegion (mark-map-region) //----- //
func.func @main() {
  %c0_i32 = arith.constant 0 : i32
  %c1_i32 = arith.constant 1 : i32
  %0 = memref.alloc() : memref<20xi32>
  %1 = memref.alloc() : memref<20xi32>
  %2 = memref.alloc() : memref<20xi32>
  affine.for %arg0 = 0 to 20 {
    affine.store %c1_i32, %0[%arg0] : memref<20xi32>
  }
  affine.for %arg0 = 0 to 20 {
    affine.store %c1_i32, %1[%arg0] : memref<20xi32>
  }
  affine.for %arg0 = 0 to 20 {
    affine.store %c0_i32, %2[%arg0] : memref<20xi32>
  }
  call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
  memref.dealloc %0 : memref<20xi32>
  memref.dealloc %1 : memref<20xi32>
  memref.dealloc %2 : memref<20xi32>
  return
}

// -----// IR Dump After LegalizeMorpher (legalize-morpher) //----- //
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    scf.for %arg3 = %c0 to %c20 step %c20 {
      %0 = memref.subview %arg0[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %1 = memref.subview %arg1[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %2 = memref.subview %arg2[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      affine.for %arg4 = 0 to 20 {
        func.call @please_map_me() : () -> ()
        %3 = affine.load %0[%arg4] : memref<20xi32, #map>
        %4 = affine.load %1[%arg4] : memref<20xi32, #map>
        %5 = arith.addi %3, %4 : i32
        affine.store %5, %2[%arg4] : memref<20xi32, #map>
      }
    }
    return
  }
  func.func @main() {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    affine.for %arg0 = 0 to 20 {
      affine.store %c1_i32, %0[%arg0] : memref<20xi32>
    }
    affine.for %arg0 = 0 to 20 {
      affine.store %c1_i32, %1[%arg0] : memref<20xi32>
    }
    affine.for %arg0 = 0 to 20 {
      affine.store %c0_i32, %2[%arg0] : memref<20xi32>
    }
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertAffineToStandard (lower-affine) //----- //
#map = affine_map<(d0)[s0] -> (d0 + s0)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    scf.for %arg3 = %c0 to %c20 step %c20 {
      %0 = memref.subview %arg0[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %1 = memref.subview %arg1[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %2 = memref.subview %arg2[%arg3] [20] [1] : memref<20xi32> to memref<20xi32, #map>
      %c0_0 = arith.constant 0 : index
      %c20_1 = arith.constant 20 : index
      %c1 = arith.constant 1 : index
      scf.for %arg4 = %c0_0 to %c20_1 step %c1 {
        func.call @please_map_me() : () -> ()
        %3 = memref.load %0[%arg4] : memref<20xi32, #map>
        %4 = memref.load %1[%arg4] : memref<20xi32, #map>
        %5 = arith.addi %3, %4 : i32
        memref.store %5, %2[%arg4] : memref<20xi32, #map>
      }
    }
    return
  }
  func.func @main() {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    %c1 = arith.constant 1 : index
    scf.for %arg0 = %c0 to %c20 step %c1 {
      memref.store %c1_i32, %0[%arg0] : memref<20xi32>
    }
    %c0_0 = arith.constant 0 : index
    %c20_1 = arith.constant 20 : index
    %c1_2 = arith.constant 1 : index
    scf.for %arg0 = %c0_0 to %c20_1 step %c1_2 {
      memref.store %c1_i32, %1[%arg0] : memref<20xi32>
    }
    %c0_3 = arith.constant 0 : index
    %c20_4 = arith.constant 20 : index
    %c1_5 = arith.constant 1 : index
    scf.for %arg0 = %c0_3 to %c20_4 step %c1_5 {
      memref.store %c0_i32, %2[%arg0] : memref<20xi32>
    }
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      func.call @please_map_me() : () -> ()
      %0 = memref.load %arg0[%arg3] : memref<20xi32>
      %1 = memref.load %arg1[%arg3] : memref<20xi32>
      %2 = arith.addi %0, %1 : i32
      memref.store %2, %arg2[%arg3] : memref<20xi32>
    }
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    scf.for %arg0 = %c0 to %c20 step %c1 {
      memref.store %c1_i32, %0[%arg0] : memref<20xi32>
    }
    scf.for %arg0 = %c0 to %c20 step %c1 {
      memref.store %c1_i32, %1[%arg0] : memref<20xi32>
    }
    scf.for %arg0 = %c0 to %c20 step %c1 {
      memref.store %c0_i32, %2[%arg0] : memref<20xi32>
    }
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    scf.for %arg3 = %c0 to %c20 step %c1 {
      func.call @please_map_me() : () -> ()
      %0 = memref.load %arg0[%arg3] : memref<20xi32>
      %1 = memref.load %arg1[%arg3] : memref<20xi32>
      %2 = arith.addi %0, %1 : i32
      memref.store %2, %arg2[%arg3] : memref<20xi32>
    }
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    scf.for %arg0 = %c0 to %c20 step %c1 {
      memref.store %c1_i32, %0[%arg0] : memref<20xi32>
    }
    scf.for %arg0 = %c0 to %c20 step %c1 {
      memref.store %c1_i32, %1[%arg0] : memref<20xi32>
    }
    scf.for %arg0 = %c0 to %c20 step %c1 {
      memref.store %c0_i32, %2[%arg0] : memref<20xi32>
    }
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After SCFToControlFlow (convert-scf-to-cf) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c20 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = memref.load %arg0[%0] : memref<20xi32>
    %3 = memref.load %arg1[%0] : memref<20xi32>
    %4 = arith.addi %2, %3 : i32
    memref.store %4, %arg2[%0] : memref<20xi32>
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb2
    %4 = arith.cmpi slt, %3, %c20 : index
    cf.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    memref.store %c1_i32, %0[%3] : memref<20xi32>
    %5 = arith.addi %3, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    cf.br ^bb4(%c0 : index)
  ^bb4(%6: index):  // 2 preds: ^bb3, ^bb5
    %7 = arith.cmpi slt, %6, %c20 : index
    cf.cond_br %7, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    memref.store %c1_i32, %1[%6] : memref<20xi32>
    %8 = arith.addi %6, %c1 : index
    cf.br ^bb4(%8 : index)
  ^bb6:  // pred: ^bb4
    cf.br ^bb7(%c0 : index)
  ^bb7(%9: index):  // 2 preds: ^bb6, ^bb8
    %10 = arith.cmpi slt, %9, %c20 : index
    cf.cond_br %10, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    memref.store %c0_i32, %2[%9] : memref<20xi32>
    %11 = arith.addi %9, %c1 : index
    cf.br ^bb7(%11 : index)
  ^bb9:  // pred: ^bb7
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After Canonicalizer (canonicalize) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c20 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = memref.load %arg0[%0] : memref<20xi32>
    %3 = memref.load %arg1[%0] : memref<20xi32>
    %4 = arith.addi %2, %3 : i32
    memref.store %4, %arg2[%0] : memref<20xi32>
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb2
    %4 = arith.cmpi slt, %3, %c20 : index
    cf.cond_br %4, ^bb2, ^bb3(%c0 : index)
  ^bb2:  // pred: ^bb1
    memref.store %c1_i32, %0[%3] : memref<20xi32>
    %5 = arith.addi %3, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3(%6: index):  // 2 preds: ^bb1, ^bb4
    %7 = arith.cmpi slt, %6, %c20 : index
    cf.cond_br %7, ^bb4, ^bb5(%c0 : index)
  ^bb4:  // pred: ^bb3
    memref.store %c1_i32, %1[%6] : memref<20xi32>
    %8 = arith.addi %6, %c1 : index
    cf.br ^bb3(%8 : index)
  ^bb5(%9: index):  // 2 preds: ^bb3, ^bb6
    %10 = arith.cmpi slt, %9, %c20 : index
    cf.cond_br %10, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    memref.store %c0_i32, %2[%9] : memref<20xi32>
    %11 = arith.addi %9, %c1 : index
    cf.br ^bb5(%11 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After CSE (cse) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c20 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = memref.load %arg0[%0] : memref<20xi32>
    %3 = memref.load %arg1[%0] : memref<20xi32>
    %4 = arith.addi %2, %3 : i32
    memref.store %4, %arg2[%0] : memref<20xi32>
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb2
    %4 = arith.cmpi slt, %3, %c20 : index
    cf.cond_br %4, ^bb2, ^bb3(%c0 : index)
  ^bb2:  // pred: ^bb1
    memref.store %c1_i32, %0[%3] : memref<20xi32>
    %5 = arith.addi %3, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3(%6: index):  // 2 preds: ^bb1, ^bb4
    %7 = arith.cmpi slt, %6, %c20 : index
    cf.cond_br %7, ^bb4, ^bb5(%c0 : index)
  ^bb4:  // pred: ^bb3
    memref.store %c1_i32, %1[%6] : memref<20xi32>
    %8 = arith.addi %6, %c1 : index
    cf.br ^bb3(%8 : index)
  ^bb5(%9: index):  // 2 preds: ^bb3, ^bb6
    %10 = arith.cmpi slt, %9, %c20 : index
    cf.cond_br %10, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    memref.store %c0_i32, %2[%9] : memref<20xi32>
    %11 = arith.addi %9, %c1 : index
    cf.br ^bb5(%11 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertMathToLLVM (convert-math-to-llvm) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c20 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = memref.load %arg0[%0] : memref<20xi32>
    %3 = memref.load %arg1[%0] : memref<20xi32>
    %4 = arith.addi %2, %3 : i32
    memref.store %4, %arg2[%0] : memref<20xi32>
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb2
    %4 = arith.cmpi slt, %3, %c20 : index
    cf.cond_br %4, ^bb2, ^bb3(%c0 : index)
  ^bb2:  // pred: ^bb1
    memref.store %c1_i32, %0[%3] : memref<20xi32>
    %5 = arith.addi %3, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3(%6: index):  // 2 preds: ^bb1, ^bb4
    %7 = arith.cmpi slt, %6, %c20 : index
    cf.cond_br %7, ^bb4, ^bb5(%c0 : index)
  ^bb4:  // pred: ^bb3
    memref.store %c1_i32, %1[%6] : memref<20xi32>
    %8 = arith.addi %6, %c1 : index
    cf.br ^bb3(%8 : index)
  ^bb5(%9: index):  // 2 preds: ^bb3, ^bb6
    %10 = arith.cmpi slt, %9, %c20 : index
    cf.cond_br %10, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    memref.store %c0_i32, %2[%9] : memref<20xi32>
    %11 = arith.addi %9, %c1 : index
    cf.br ^bb5(%11 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertMathToLibm (convert-math-to-libm) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c20 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = memref.load %arg0[%0] : memref<20xi32>
    %3 = memref.load %arg1[%0] : memref<20xi32>
    %4 = arith.addi %2, %3 : i32
    memref.store %4, %arg2[%0] : memref<20xi32>
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb2
    %4 = arith.cmpi slt, %3, %c20 : index
    cf.cond_br %4, ^bb2, ^bb3(%c0 : index)
  ^bb2:  // pred: ^bb1
    memref.store %c1_i32, %0[%3] : memref<20xi32>
    %5 = arith.addi %3, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3(%6: index):  // 2 preds: ^bb1, ^bb4
    %7 = arith.cmpi slt, %6, %c20 : index
    cf.cond_br %7, ^bb4, ^bb5(%c0 : index)
  ^bb4:  // pred: ^bb3
    memref.store %c1_i32, %1[%6] : memref<20xi32>
    %8 = arith.addi %6, %c1 : index
    cf.br ^bb3(%8 : index)
  ^bb5(%9: index):  // 2 preds: ^bb3, ^bb6
    %10 = arith.cmpi slt, %9, %c20 : index
    cf.cond_br %10, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    memref.store %c0_i32, %2[%9] : memref<20xi32>
    %11 = arith.addi %9, %c1 : index
    cf.br ^bb5(%11 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ArithmeticExpandOps (arith-expand) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %c20 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %2 = memref.load %arg0[%0] : memref<20xi32>
    %3 = memref.load %arg1[%0] : memref<20xi32>
    %4 = arith.addi %2, %3 : i32
    memref.store %4, %arg2[%0] : memref<20xi32>
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %c1 = arith.constant 1 : index
    %c20 = arith.constant 20 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = memref.alloc() : memref<20xi32>
    %1 = memref.alloc() : memref<20xi32>
    %2 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%c0 : index)
  ^bb1(%3: index):  // 2 preds: ^bb0, ^bb2
    %4 = arith.cmpi slt, %3, %c20 : index
    cf.cond_br %4, ^bb2, ^bb3(%c0 : index)
  ^bb2:  // pred: ^bb1
    memref.store %c1_i32, %0[%3] : memref<20xi32>
    %5 = arith.addi %3, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb3(%6: index):  // 2 preds: ^bb1, ^bb4
    %7 = arith.cmpi slt, %6, %c20 : index
    cf.cond_br %7, ^bb4, ^bb5(%c0 : index)
  ^bb4:  // pred: ^bb3
    memref.store %c1_i32, %1[%6] : memref<20xi32>
    %8 = arith.addi %6, %c1 : index
    cf.br ^bb3(%8 : index)
  ^bb5(%9: index):  // 2 preds: ^bb3, ^bb6
    %10 = arith.cmpi slt, %9, %c20 : index
    cf.cond_br %10, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    memref.store %c0_i32, %2[%9] : memref<20xi32>
    %11 = arith.addi %9, %c1 : index
    cf.br ^bb5(%11 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%0, %1, %2) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %0 : memref<20xi32>
    memref.dealloc %1 : memref<20xi32>
    memref.dealloc %2 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertArithmeticToLLVM (convert-arith-to-llvm) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    %3 = llvm.mlir.constant(20 : index) : i64
    cf.br ^bb1(%2 : index)
  ^bb1(%4: index):  // 2 preds: ^bb0, ^bb2
    %5 = builtin.unrealized_conversion_cast %4 : index to i64
    %6 = llvm.icmp "slt" %5, %3 : i64
    cf.cond_br %6, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %7 = memref.load %arg0[%4] : memref<20xi32>
    %8 = memref.load %arg1[%4] : memref<20xi32>
    %9 = llvm.add %7, %8  : i32
    memref.store %9, %arg2[%4] : memref<20xi32>
    %10 = llvm.add %5, %0  : i64
    %11 = builtin.unrealized_conversion_cast %10 : i64 to index
    cf.br ^bb1(%11 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(20 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = memref.alloc() : memref<20xi32>
    %7 = memref.alloc() : memref<20xi32>
    %8 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%3 : index)
  ^bb1(%9: index):  // 2 preds: ^bb0, ^bb2
    %10 = builtin.unrealized_conversion_cast %9 : index to i64
    %11 = llvm.icmp "slt" %10, %1 : i64
    cf.cond_br %11, ^bb2, ^bb3(%3 : index)
  ^bb2:  // pred: ^bb1
    memref.store %5, %6[%9] : memref<20xi32>
    %12 = llvm.add %10, %0  : i64
    %13 = builtin.unrealized_conversion_cast %12 : i64 to index
    cf.br ^bb1(%13 : index)
  ^bb3(%14: index):  // 2 preds: ^bb1, ^bb4
    %15 = builtin.unrealized_conversion_cast %14 : index to i64
    %16 = llvm.icmp "slt" %15, %1 : i64
    cf.cond_br %16, ^bb4, ^bb5(%3 : index)
  ^bb4:  // pred: ^bb3
    memref.store %5, %7[%14] : memref<20xi32>
    %17 = llvm.add %15, %0  : i64
    %18 = builtin.unrealized_conversion_cast %17 : i64 to index
    cf.br ^bb3(%18 : index)
  ^bb5(%19: index):  // 2 preds: ^bb3, ^bb6
    %20 = builtin.unrealized_conversion_cast %19 : index to i64
    %21 = llvm.icmp "slt" %20, %1 : i64
    cf.cond_br %21, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    memref.store %4, %8[%19] : memref<20xi32>
    %22 = llvm.add %20, %0  : i64
    %23 = builtin.unrealized_conversion_cast %22 : i64 to index
    cf.br ^bb5(%23 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%6, %7, %8) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %6 : memref<20xi32>
    memref.dealloc %7 : memref<20xi32>
    memref.dealloc %8 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ExpandOps (memref-expand) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(0 : index) : i64
    %2 = builtin.unrealized_conversion_cast %1 : i64 to index
    %3 = llvm.mlir.constant(20 : index) : i64
    cf.br ^bb1(%2 : index)
  ^bb1(%4: index):  // 2 preds: ^bb0, ^bb2
    %5 = builtin.unrealized_conversion_cast %4 : index to i64
    %6 = llvm.icmp "slt" %5, %3 : i64
    cf.cond_br %6, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %7 = memref.load %arg0[%4] : memref<20xi32>
    %8 = memref.load %arg1[%4] : memref<20xi32>
    %9 = llvm.add %7, %8  : i32
    memref.store %9, %arg2[%4] : memref<20xi32>
    %10 = llvm.add %5, %0  : i64
    %11 = builtin.unrealized_conversion_cast %10 : i64 to index
    cf.br ^bb1(%11 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(20 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = memref.alloc() : memref<20xi32>
    %7 = memref.alloc() : memref<20xi32>
    %8 = memref.alloc() : memref<20xi32>
    cf.br ^bb1(%3 : index)
  ^bb1(%9: index):  // 2 preds: ^bb0, ^bb2
    %10 = builtin.unrealized_conversion_cast %9 : index to i64
    %11 = llvm.icmp "slt" %10, %1 : i64
    cf.cond_br %11, ^bb2, ^bb3(%3 : index)
  ^bb2:  // pred: ^bb1
    memref.store %5, %6[%9] : memref<20xi32>
    %12 = llvm.add %10, %0  : i64
    %13 = builtin.unrealized_conversion_cast %12 : i64 to index
    cf.br ^bb1(%13 : index)
  ^bb3(%14: index):  // 2 preds: ^bb1, ^bb4
    %15 = builtin.unrealized_conversion_cast %14 : index to i64
    %16 = llvm.icmp "slt" %15, %1 : i64
    cf.cond_br %16, ^bb4, ^bb5(%3 : index)
  ^bb4:  // pred: ^bb3
    memref.store %5, %7[%14] : memref<20xi32>
    %17 = llvm.add %15, %0  : i64
    %18 = builtin.unrealized_conversion_cast %17 : i64 to index
    cf.br ^bb3(%18 : index)
  ^bb5(%19: index):  // 2 preds: ^bb3, ^bb6
    %20 = builtin.unrealized_conversion_cast %19 : index to i64
    %21 = llvm.icmp "slt" %20, %1 : i64
    cf.cond_br %21, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    memref.store %4, %8[%19] : memref<20xi32>
    %22 = llvm.add %20, %0  : i64
    %23 = builtin.unrealized_conversion_cast %22 : i64 to index
    cf.br ^bb5(%23 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%6, %7, %8) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    memref.dealloc %6 : memref<20xi32>
    memref.dealloc %7 : memref<20xi32>
    memref.dealloc %8 : memref<20xi32>
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertMemRefToLLVM (convert-memref-to-llvm) //----- //
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  func.func @array_add(%arg0: memref<20xi32>, %arg1: memref<20xi32>, %arg2: memref<20xi32>) attributes {__morpher_kernel__} {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = builtin.unrealized_conversion_cast %arg1 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = builtin.unrealized_conversion_cast %4 : i64 to index
    %6 = llvm.mlir.constant(20 : index) : i64
    cf.br ^bb1(%5 : index)
  ^bb1(%7: index):  // 2 preds: ^bb0, ^bb2
    %8 = builtin.unrealized_conversion_cast %7 : index to i64
    %9 = builtin.unrealized_conversion_cast %7 : index to i64
    %10 = llvm.icmp "slt" %9, %6 : i64
    cf.cond_br %10, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    call @please_map_me() : () -> ()
    %11 = llvm.extractvalue %0[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr %11[%8] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %13 = llvm.load %12 : !llvm.ptr<i32>
    %14 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.getelementptr %14[%8] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %16 = llvm.load %15 : !llvm.ptr<i32>
    %17 = llvm.add %13, %16  : i32
    %18 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.getelementptr %18[%8] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %17, %19 : !llvm.ptr<i32>
    %20 = llvm.add %9, %3  : i64
    %21 = builtin.unrealized_conversion_cast %20 : i64 to index
    cf.br ^bb1(%21 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(20 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(20 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.null : !llvm.ptr<i32>
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %10 = llvm.ptrtoint %9 : !llvm.ptr<i32> to i64
    %11 = llvm.call @malloc(%10) : (i64) -> !llvm.ptr<i8>
    %12 = llvm.bitcast %11 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %13 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %6, %17[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %7, %18[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %21 = llvm.mlir.constant(20 : index) : i64
    %22 = llvm.mlir.constant(1 : index) : i64
    %23 = llvm.mlir.null : !llvm.ptr<i32>
    %24 = llvm.getelementptr %23[%21] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %25 = llvm.ptrtoint %24 : !llvm.ptr<i32> to i64
    %26 = llvm.call @malloc(%25) : (i64) -> !llvm.ptr<i8>
    %27 = llvm.bitcast %26 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %28 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %29 = llvm.insertvalue %27, %28[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.insertvalue %27, %29[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.mlir.constant(0 : index) : i64
    %32 = llvm.insertvalue %31, %30[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.insertvalue %21, %32[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %22, %33[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = builtin.unrealized_conversion_cast %34 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %36 = llvm.mlir.constant(20 : index) : i64
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.mlir.null : !llvm.ptr<i32>
    %39 = llvm.getelementptr %38[%36] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %40 = llvm.ptrtoint %39 : !llvm.ptr<i32> to i64
    %41 = llvm.call @malloc(%40) : (i64) -> !llvm.ptr<i8>
    %42 = llvm.bitcast %41 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %43 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %44 = llvm.insertvalue %42, %43[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.insertvalue %42, %44[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.mlir.constant(0 : index) : i64
    %47 = llvm.insertvalue %46, %45[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.insertvalue %36, %47[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.insertvalue %37, %48[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %50 = builtin.unrealized_conversion_cast %49 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    cf.br ^bb1(%3 : index)
  ^bb1(%51: index):  // 2 preds: ^bb0, ^bb2
    %52 = builtin.unrealized_conversion_cast %51 : index to i64
    %53 = builtin.unrealized_conversion_cast %51 : index to i64
    %54 = llvm.icmp "slt" %53, %1 : i64
    cf.cond_br %54, ^bb2, ^bb3(%3 : index)
  ^bb2:  // pred: ^bb1
    %55 = llvm.extractvalue %19[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %56 = llvm.getelementptr %55[%52] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %5, %56 : !llvm.ptr<i32>
    %57 = llvm.add %53, %0  : i64
    %58 = builtin.unrealized_conversion_cast %57 : i64 to index
    cf.br ^bb1(%58 : index)
  ^bb3(%59: index):  // 2 preds: ^bb1, ^bb4
    %60 = builtin.unrealized_conversion_cast %59 : index to i64
    %61 = builtin.unrealized_conversion_cast %59 : index to i64
    %62 = llvm.icmp "slt" %61, %1 : i64
    cf.cond_br %62, ^bb4, ^bb5(%3 : index)
  ^bb4:  // pred: ^bb3
    %63 = llvm.extractvalue %34[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %64 = llvm.getelementptr %63[%60] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %5, %64 : !llvm.ptr<i32>
    %65 = llvm.add %61, %0  : i64
    %66 = builtin.unrealized_conversion_cast %65 : i64 to index
    cf.br ^bb3(%66 : index)
  ^bb5(%67: index):  // 2 preds: ^bb3, ^bb6
    %68 = builtin.unrealized_conversion_cast %67 : index to i64
    %69 = builtin.unrealized_conversion_cast %67 : index to i64
    %70 = llvm.icmp "slt" %69, %1 : i64
    cf.cond_br %70, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %71 = llvm.extractvalue %49[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %72 = llvm.getelementptr %71[%68] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %4, %72 : !llvm.ptr<i32>
    %73 = llvm.add %69, %0  : i64
    %74 = builtin.unrealized_conversion_cast %73 : i64 to index
    cf.br ^bb5(%74 : index)
  ^bb7:  // pred: ^bb5
    call @array_add(%20, %35, %50) : (memref<20xi32>, memref<20xi32>, memref<20xi32>) -> ()
    %75 = llvm.extractvalue %19[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %76 = llvm.bitcast %75 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%76) : (!llvm.ptr<i8>) -> ()
    %77 = llvm.extractvalue %34[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %78 = llvm.bitcast %77 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%78) : (!llvm.ptr<i8>) -> ()
    %79 = llvm.extractvalue %49[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %80 = llvm.bitcast %79 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%80) : (!llvm.ptr<i8>) -> ()
    return
  }
  func.func private @please_map_me()
}


// -----// IR Dump After ConvertFuncToLLVM (convert-func-to-llvm) //----- //
module attributes {llvm.data_layout = "", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @array_add(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr<i32>, %arg11: !llvm.ptr<i32>, %arg12: i64, %arg13: i64, %arg14: i64) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %7 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg5, %7[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg6, %8[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg7, %9[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg8, %10[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg9, %11[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = builtin.unrealized_conversion_cast %12 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %14 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %15 = llvm.insertvalue %arg10, %14[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg11, %15[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg12, %16[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg13, %17[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg14, %18[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %21 = builtin.unrealized_conversion_cast %6 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %22 = builtin.unrealized_conversion_cast %13 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %23 = builtin.unrealized_conversion_cast %20 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = builtin.unrealized_conversion_cast %25 : i64 to index
    %27 = llvm.mlir.constant(20 : index) : i64
    llvm.br ^bb1(%25 : i64)
  ^bb1(%28: i64):  // 2 preds: ^bb0, ^bb2
    %29 = builtin.unrealized_conversion_cast %28 : i64 to index
    %30 = builtin.unrealized_conversion_cast %29 : index to i64
    %31 = builtin.unrealized_conversion_cast %29 : index to i64
    %32 = llvm.icmp "slt" %31, %27 : i64
    llvm.cond_br %32, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %33 = llvm.extractvalue %21[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.getelementptr %33[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %35 = llvm.load %34 : !llvm.ptr<i32>
    %36 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.getelementptr %36[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %38 = llvm.load %37 : !llvm.ptr<i32>
    %39 = llvm.add %35, %38  : i32
    %40 = llvm.extractvalue %23[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %41 = llvm.getelementptr %40[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %39, %41 : !llvm.ptr<i32>
    %42 = llvm.add %31, %24  : i64
    %43 = builtin.unrealized_conversion_cast %42 : i64 to index
    llvm.br ^bb1(%42 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(20 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(20 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.null : !llvm.ptr<i32>
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %10 = llvm.ptrtoint %9 : !llvm.ptr<i32> to i64
    %11 = llvm.call @malloc(%10) : (i64) -> !llvm.ptr<i8>
    %12 = llvm.bitcast %11 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %13 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %6, %17[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %7, %18[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %21 = llvm.mlir.constant(20 : index) : i64
    %22 = llvm.mlir.constant(1 : index) : i64
    %23 = llvm.mlir.null : !llvm.ptr<i32>
    %24 = llvm.getelementptr %23[%21] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %25 = llvm.ptrtoint %24 : !llvm.ptr<i32> to i64
    %26 = llvm.call @malloc(%25) : (i64) -> !llvm.ptr<i8>
    %27 = llvm.bitcast %26 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %28 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %29 = llvm.insertvalue %27, %28[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.insertvalue %27, %29[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.mlir.constant(0 : index) : i64
    %32 = llvm.insertvalue %31, %30[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.insertvalue %21, %32[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %22, %33[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = builtin.unrealized_conversion_cast %34 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %36 = llvm.mlir.constant(20 : index) : i64
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.mlir.null : !llvm.ptr<i32>
    %39 = llvm.getelementptr %38[%36] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %40 = llvm.ptrtoint %39 : !llvm.ptr<i32> to i64
    %41 = llvm.call @malloc(%40) : (i64) -> !llvm.ptr<i8>
    %42 = llvm.bitcast %41 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %43 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %44 = llvm.insertvalue %42, %43[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.insertvalue %42, %44[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.mlir.constant(0 : index) : i64
    %47 = llvm.insertvalue %46, %45[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.insertvalue %36, %47[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.insertvalue %37, %48[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %50 = builtin.unrealized_conversion_cast %49 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%51: i64):  // 2 preds: ^bb0, ^bb2
    %52 = builtin.unrealized_conversion_cast %51 : i64 to index
    %53 = builtin.unrealized_conversion_cast %52 : index to i64
    %54 = builtin.unrealized_conversion_cast %52 : index to i64
    %55 = llvm.icmp "slt" %54, %1 : i64
    llvm.cond_br %55, ^bb2, ^bb3(%2 : i64)
  ^bb2:  // pred: ^bb1
    %56 = llvm.extractvalue %19[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %57 = llvm.getelementptr %56[%53] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %5, %57 : !llvm.ptr<i32>
    %58 = llvm.add %54, %0  : i64
    %59 = builtin.unrealized_conversion_cast %58 : i64 to index
    llvm.br ^bb1(%58 : i64)
  ^bb3(%60: i64):  // 2 preds: ^bb1, ^bb4
    %61 = builtin.unrealized_conversion_cast %60 : i64 to index
    %62 = builtin.unrealized_conversion_cast %61 : index to i64
    %63 = builtin.unrealized_conversion_cast %61 : index to i64
    %64 = llvm.icmp "slt" %63, %1 : i64
    llvm.cond_br %64, ^bb4, ^bb5(%2 : i64)
  ^bb4:  // pred: ^bb3
    %65 = llvm.extractvalue %34[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %66 = llvm.getelementptr %65[%62] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %5, %66 : !llvm.ptr<i32>
    %67 = llvm.add %63, %0  : i64
    %68 = builtin.unrealized_conversion_cast %67 : i64 to index
    llvm.br ^bb3(%67 : i64)
  ^bb5(%69: i64):  // 2 preds: ^bb3, ^bb6
    %70 = builtin.unrealized_conversion_cast %69 : i64 to index
    %71 = builtin.unrealized_conversion_cast %70 : index to i64
    %72 = builtin.unrealized_conversion_cast %70 : index to i64
    %73 = llvm.icmp "slt" %72, %1 : i64
    llvm.cond_br %73, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %74 = llvm.extractvalue %49[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %75 = llvm.getelementptr %74[%71] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %4, %75 : !llvm.ptr<i32>
    %76 = llvm.add %72, %0  : i64
    %77 = builtin.unrealized_conversion_cast %76 : i64 to index
    llvm.br ^bb5(%76 : i64)
  ^bb7:  // pred: ^bb5
    %78 = llvm.extractvalue %19[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %79 = llvm.extractvalue %19[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %80 = llvm.extractvalue %19[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %81 = llvm.extractvalue %19[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %82 = llvm.extractvalue %19[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %83 = llvm.extractvalue %34[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %84 = llvm.extractvalue %34[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %85 = llvm.extractvalue %34[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %86 = llvm.extractvalue %34[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %87 = llvm.extractvalue %34[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %88 = llvm.extractvalue %49[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %89 = llvm.extractvalue %49[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %90 = llvm.extractvalue %49[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %91 = llvm.extractvalue %49[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %92 = llvm.extractvalue %49[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @array_add(%78, %79, %80, %81, %82, %83, %84, %85, %86, %87, %88, %89, %90, %91, %92) : (!llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    %93 = llvm.extractvalue %19[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %94 = llvm.bitcast %93 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%94) : (!llvm.ptr<i8>) -> ()
    %95 = llvm.extractvalue %34[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %96 = llvm.bitcast %95 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%96) : (!llvm.ptr<i8>) -> ()
    %97 = llvm.extractvalue %49[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %98 = llvm.bitcast %97 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%98) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @please_map_me() attributes {sym_visibility = "private"}
}


// -----// IR Dump After ConvertControlFlowToLLVM (convert-cf-to-llvm) //----- //
module attributes {llvm.data_layout = "", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @array_add(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr<i32>, %arg11: !llvm.ptr<i32>, %arg12: i64, %arg13: i64, %arg14: i64) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = builtin.unrealized_conversion_cast %5 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %7 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %arg5, %7[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg6, %8[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg7, %9[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg8, %10[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %arg9, %11[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = builtin.unrealized_conversion_cast %12 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %14 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %15 = llvm.insertvalue %arg10, %14[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg11, %15[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg12, %16[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %arg13, %17[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %arg14, %18[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %21 = builtin.unrealized_conversion_cast %6 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %22 = builtin.unrealized_conversion_cast %13 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %23 = builtin.unrealized_conversion_cast %20 : memref<20xi32> to !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %24 = llvm.mlir.constant(1 : index) : i64
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = builtin.unrealized_conversion_cast %25 : i64 to index
    %27 = llvm.mlir.constant(20 : index) : i64
    llvm.br ^bb1(%25 : i64)
  ^bb1(%28: i64):  // 2 preds: ^bb0, ^bb2
    %29 = builtin.unrealized_conversion_cast %28 : i64 to index
    %30 = builtin.unrealized_conversion_cast %29 : index to i64
    %31 = builtin.unrealized_conversion_cast %29 : index to i64
    %32 = llvm.icmp "slt" %31, %27 : i64
    llvm.cond_br %32, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %33 = llvm.extractvalue %21[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.getelementptr %33[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %35 = llvm.load %34 : !llvm.ptr<i32>
    %36 = llvm.extractvalue %22[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %37 = llvm.getelementptr %36[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %38 = llvm.load %37 : !llvm.ptr<i32>
    %39 = llvm.add %35, %38  : i32
    %40 = llvm.extractvalue %23[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %41 = llvm.getelementptr %40[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %39, %41 : !llvm.ptr<i32>
    %42 = llvm.add %31, %24  : i64
    %43 = builtin.unrealized_conversion_cast %42 : i64 to index
    llvm.br ^bb1(%42 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(20 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = builtin.unrealized_conversion_cast %2 : i64 to index
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(20 : index) : i64
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.mlir.null : !llvm.ptr<i32>
    %9 = llvm.getelementptr %8[%6] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %10 = llvm.ptrtoint %9 : !llvm.ptr<i32> to i64
    %11 = llvm.call @malloc(%10) : (i64) -> !llvm.ptr<i8>
    %12 = llvm.bitcast %11 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %13 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %12, %14[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(0 : index) : i64
    %17 = llvm.insertvalue %16, %15[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %6, %17[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.insertvalue %7, %18[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %21 = llvm.mlir.constant(20 : index) : i64
    %22 = llvm.mlir.constant(1 : index) : i64
    %23 = llvm.mlir.null : !llvm.ptr<i32>
    %24 = llvm.getelementptr %23[%21] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %25 = llvm.ptrtoint %24 : !llvm.ptr<i32> to i64
    %26 = llvm.call @malloc(%25) : (i64) -> !llvm.ptr<i8>
    %27 = llvm.bitcast %26 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %28 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %29 = llvm.insertvalue %27, %28[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %30 = llvm.insertvalue %27, %29[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.mlir.constant(0 : index) : i64
    %32 = llvm.insertvalue %31, %30[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.insertvalue %21, %32[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %34 = llvm.insertvalue %22, %33[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %35 = builtin.unrealized_conversion_cast %34 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    %36 = llvm.mlir.constant(20 : index) : i64
    %37 = llvm.mlir.constant(1 : index) : i64
    %38 = llvm.mlir.null : !llvm.ptr<i32>
    %39 = llvm.getelementptr %38[%36] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %40 = llvm.ptrtoint %39 : !llvm.ptr<i32> to i64
    %41 = llvm.call @malloc(%40) : (i64) -> !llvm.ptr<i8>
    %42 = llvm.bitcast %41 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %43 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %44 = llvm.insertvalue %42, %43[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.insertvalue %42, %44[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.mlir.constant(0 : index) : i64
    %47 = llvm.insertvalue %46, %45[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %48 = llvm.insertvalue %36, %47[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %49 = llvm.insertvalue %37, %48[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %50 = builtin.unrealized_conversion_cast %49 : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> to memref<20xi32>
    llvm.br ^bb1(%2 : i64)
  ^bb1(%51: i64):  // 2 preds: ^bb0, ^bb2
    %52 = builtin.unrealized_conversion_cast %51 : i64 to index
    %53 = builtin.unrealized_conversion_cast %52 : index to i64
    %54 = builtin.unrealized_conversion_cast %52 : index to i64
    %55 = llvm.icmp "slt" %54, %1 : i64
    llvm.cond_br %55, ^bb2, ^bb3(%2 : i64)
  ^bb2:  // pred: ^bb1
    %56 = llvm.extractvalue %19[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %57 = llvm.getelementptr %56[%53] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %5, %57 : !llvm.ptr<i32>
    %58 = llvm.add %54, %0  : i64
    %59 = builtin.unrealized_conversion_cast %58 : i64 to index
    llvm.br ^bb1(%58 : i64)
  ^bb3(%60: i64):  // 2 preds: ^bb1, ^bb4
    %61 = builtin.unrealized_conversion_cast %60 : i64 to index
    %62 = builtin.unrealized_conversion_cast %61 : index to i64
    %63 = builtin.unrealized_conversion_cast %61 : index to i64
    %64 = llvm.icmp "slt" %63, %1 : i64
    llvm.cond_br %64, ^bb4, ^bb5(%2 : i64)
  ^bb4:  // pred: ^bb3
    %65 = llvm.extractvalue %34[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %66 = llvm.getelementptr %65[%62] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %5, %66 : !llvm.ptr<i32>
    %67 = llvm.add %63, %0  : i64
    %68 = builtin.unrealized_conversion_cast %67 : i64 to index
    llvm.br ^bb3(%67 : i64)
  ^bb5(%69: i64):  // 2 preds: ^bb3, ^bb6
    %70 = builtin.unrealized_conversion_cast %69 : i64 to index
    %71 = builtin.unrealized_conversion_cast %70 : index to i64
    %72 = builtin.unrealized_conversion_cast %70 : index to i64
    %73 = llvm.icmp "slt" %72, %1 : i64
    llvm.cond_br %73, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %74 = llvm.extractvalue %49[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %75 = llvm.getelementptr %74[%71] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %4, %75 : !llvm.ptr<i32>
    %76 = llvm.add %72, %0  : i64
    %77 = builtin.unrealized_conversion_cast %76 : i64 to index
    llvm.br ^bb5(%76 : i64)
  ^bb7:  // pred: ^bb5
    %78 = llvm.extractvalue %19[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %79 = llvm.extractvalue %19[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %80 = llvm.extractvalue %19[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %81 = llvm.extractvalue %19[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %82 = llvm.extractvalue %19[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %83 = llvm.extractvalue %34[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %84 = llvm.extractvalue %34[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %85 = llvm.extractvalue %34[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %86 = llvm.extractvalue %34[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %87 = llvm.extractvalue %34[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %88 = llvm.extractvalue %49[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %89 = llvm.extractvalue %49[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %90 = llvm.extractvalue %49[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %91 = llvm.extractvalue %49[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %92 = llvm.extractvalue %49[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @array_add(%78, %79, %80, %81, %82, %83, %84, %85, %86, %87, %88, %89, %90, %91, %92) : (!llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    %93 = llvm.extractvalue %19[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %94 = llvm.bitcast %93 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%94) : (!llvm.ptr<i8>) -> ()
    %95 = llvm.extractvalue %34[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %96 = llvm.bitcast %95 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%96) : (!llvm.ptr<i8>) -> ()
    %97 = llvm.extractvalue %49[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %98 = llvm.bitcast %97 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%98) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @please_map_me() attributes {sym_visibility = "private"}
}


// -----// IR Dump After ReconcileUnrealizedCasts (reconcile-unrealized-casts) //----- //
module attributes {llvm.data_layout = "", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @array_add(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: !llvm.ptr<i32>, %arg11: !llvm.ptr<i32>, %arg12: i64, %arg13: i64, %arg14: i64) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.insertvalue %arg4, %4[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %arg5, %6[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %arg6, %7[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %arg7, %8[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.insertvalue %arg8, %9[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg9, %10[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %13 = llvm.insertvalue %arg10, %12[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %arg11, %13[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.insertvalue %arg12, %14[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.insertvalue %arg13, %15[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %arg14, %16[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.mlir.constant(1 : index) : i64
    %19 = llvm.mlir.constant(0 : index) : i64
    %20 = llvm.mlir.constant(20 : index) : i64
    llvm.br ^bb1(%19 : i64)
  ^bb1(%21: i64):  // 2 preds: ^bb0, ^bb2
    %22 = llvm.icmp "slt" %21, %20 : i64
    llvm.cond_br %22, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %23 = llvm.extractvalue %5[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.getelementptr %23[%21] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %25 = llvm.load %24 : !llvm.ptr<i32>
    %26 = llvm.extractvalue %11[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.getelementptr %26[%21] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %28 = llvm.load %27 : !llvm.ptr<i32>
    %29 = llvm.add %25, %28  : i32
    %30 = llvm.extractvalue %17[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.getelementptr %30[%21] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %29, %31 : !llvm.ptr<i32>
    %32 = llvm.add %21, %18  : i64
    llvm.br ^bb1(%32 : i64)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(20 : index) : i64
    %2 = llvm.mlir.constant(0 : index) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(20 : index) : i64
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.null : !llvm.ptr<i32>
    %8 = llvm.getelementptr %7[20] : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    %9 = llvm.ptrtoint %8 : !llvm.ptr<i32> to i64
    %10 = llvm.call @malloc(%9) : (i64) -> !llvm.ptr<i8>
    %11 = llvm.bitcast %10 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %12 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.insertvalue %11, %13[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %15 = llvm.mlir.constant(0 : index) : i64
    %16 = llvm.insertvalue %15, %14[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %17 = llvm.insertvalue %5, %16[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.insertvalue %6, %17[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %19 = llvm.mlir.constant(20 : index) : i64
    %20 = llvm.mlir.constant(1 : index) : i64
    %21 = llvm.mlir.null : !llvm.ptr<i32>
    %22 = llvm.getelementptr %21[20] : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    %23 = llvm.ptrtoint %22 : !llvm.ptr<i32> to i64
    %24 = llvm.call @malloc(%23) : (i64) -> !llvm.ptr<i8>
    %25 = llvm.bitcast %24 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %26 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %28 = llvm.insertvalue %25, %27[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %29 = llvm.mlir.constant(0 : index) : i64
    %30 = llvm.insertvalue %29, %28[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %31 = llvm.insertvalue %19, %30[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %32 = llvm.insertvalue %20, %31[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.mlir.constant(20 : index) : i64
    %34 = llvm.mlir.constant(1 : index) : i64
    %35 = llvm.mlir.null : !llvm.ptr<i32>
    %36 = llvm.getelementptr %35[20] : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    %37 = llvm.ptrtoint %36 : !llvm.ptr<i32> to i64
    %38 = llvm.call @malloc(%37) : (i64) -> !llvm.ptr<i8>
    %39 = llvm.bitcast %38 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %40 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %41 = llvm.insertvalue %39, %40[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %42 = llvm.insertvalue %39, %41[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %43 = llvm.mlir.constant(0 : index) : i64
    %44 = llvm.insertvalue %43, %42[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %45 = llvm.insertvalue %33, %44[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %46 = llvm.insertvalue %34, %45[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.br ^bb1(%2 : i64)
  ^bb1(%47: i64):  // 2 preds: ^bb0, ^bb2
    %48 = llvm.icmp "slt" %47, %1 : i64
    llvm.cond_br %48, ^bb2, ^bb3(%2 : i64)
  ^bb2:  // pred: ^bb1
    %49 = llvm.getelementptr %11[%47] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %4, %49 : !llvm.ptr<i32>
    %50 = llvm.add %47, %0  : i64
    llvm.br ^bb1(%50 : i64)
  ^bb3(%51: i64):  // 2 preds: ^bb1, ^bb4
    %52 = llvm.icmp "slt" %51, %1 : i64
    llvm.cond_br %52, ^bb4, ^bb5(%2 : i64)
  ^bb4:  // pred: ^bb3
    %53 = llvm.getelementptr %25[%51] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %4, %53 : !llvm.ptr<i32>
    %54 = llvm.add %51, %0  : i64
    llvm.br ^bb3(%54 : i64)
  ^bb5(%55: i64):  // 2 preds: ^bb3, ^bb6
    %56 = llvm.icmp "slt" %55, %1 : i64
    llvm.cond_br %56, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %57 = llvm.getelementptr %39[%55] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %3, %57 : !llvm.ptr<i32>
    %58 = llvm.add %55, %0  : i64
    llvm.br ^bb5(%58 : i64)
  ^bb7:  // pred: ^bb5
    llvm.call @array_add(%11, %11, %15, %5, %6, %25, %25, %29, %19, %20, %39, %39, %43, %33, %34) : (!llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64, !llvm.ptr<i32>, !llvm.ptr<i32>, i64, i64, i64) -> ()
    %59 = llvm.bitcast %11 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%59) : (!llvm.ptr<i8>) -> ()
    %60 = llvm.bitcast %25 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%60) : (!llvm.ptr<i8>) -> ()
    %61 = llvm.bitcast %39 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @free(%61) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @please_map_me() attributes {sym_visibility = "private"}
}


Optimizing
Generating DFG (array_add_PartPredDFG.xml/dot) and data layout (array_add_mem_alloc.txt)
DFG node count: 20
