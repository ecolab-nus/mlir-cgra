module attributes {llvm.data_layout = "", llvm.target_triple = "i386-unknown-linux-gnu", soda.container_module} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @array_add(%arg0: !llvm.ptr<i32>, %arg1: !llvm.ptr<i32>, %arg2: !llvm.ptr<i32>) attributes {__morpher_kernel__} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %2 = llvm.insertvalue %arg0, %1[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.mlir.constant(0 : index) : i64
    %4 = llvm.insertvalue %3, %2[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %5 = llvm.mlir.constant(20 : index) : i64
    %6 = llvm.insertvalue %5, %4[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %7 = llvm.mlir.constant(1 : index) : i64
    %8 = llvm.insertvalue %7, %6[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = llvm.insertvalue %arg1, %9[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %arg1, %10[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.mlir.constant(0 : index) : i64
    %13 = llvm.insertvalue %12, %11[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.mlir.constant(20 : index) : i64
    %15 = llvm.insertvalue %14, %13[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %16 = llvm.mlir.constant(1 : index) : i64
    %17 = llvm.insertvalue %16, %15[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %18 = llvm.mlir.undef : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)>
    %19 = llvm.insertvalue %arg2, %18[0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.insertvalue %arg2, %19[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %21 = llvm.mlir.constant(0 : index) : i64
    %22 = llvm.insertvalue %21, %20[2] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %23 = llvm.mlir.constant(20 : index) : i64
    %24 = llvm.insertvalue %23, %22[3, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %25 = llvm.mlir.constant(1 : index) : i64
    %26 = llvm.insertvalue %25, %24[4, 0] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %27 = llvm.mlir.constant(1 : index) : i64
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.mlir.constant(20 : index) : i64
    llvm.br ^bb1(%28 : i64)
  ^bb1(%30: i64):  // 2 preds: ^bb0, ^bb2
    %31 = llvm.icmp "slt" %30, %29 : i64
    llvm.cond_br %31, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @please_map_me() : () -> ()
    %32 = llvm.extractvalue %8[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %33 = llvm.getelementptr %32[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %34 = llvm.load %33 : !llvm.ptr<i32>
    %35 = llvm.extractvalue %17[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %36 = llvm.getelementptr %35[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %37 = llvm.load %36 : !llvm.ptr<i32>
    %38 = llvm.add %34, %37  : i32
    %39 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<i32>, ptr<i32>, i64, array<1 x i64>, array<1 x i64>)> 
    %40 = llvm.getelementptr %39[%30] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %38, %40 : !llvm.ptr<i32>
    %41 = llvm.add %30, %27  : i64
    llvm.br ^bb1(%41 : i64)
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
    llvm.call @array_add(%11, %25, %39) : (!llvm.ptr<i32>, !llvm.ptr<i32>, !llvm.ptr<i32>) -> ()
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

