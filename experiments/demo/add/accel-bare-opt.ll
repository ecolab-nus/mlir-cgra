; ModuleID = 'accel-bare.ll'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @generic_0(ptr %0, ptr %1, ptr %2) !dbg !3 {
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0, !dbg !7
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, ptr %0, 1, !dbg !9
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 0, 2, !dbg !10
  %7 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0, !dbg !11
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %7, ptr %1, 1, !dbg !12
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, i64 0, 2, !dbg !13
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %2, 0, !dbg !14
  %11 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, ptr %2, 1, !dbg !15
  %12 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %11, i64 0, 2, !dbg !16
  br label %13, !dbg !17

13:                                               ; preds = %16, %3
  %14 = phi i64 [ %23, %16 ], [ 0, %3 ]
  %15 = icmp ult i64 %14, 20, !dbg !18
  br i1 %15, label %16, label %24, !dbg !19

16:                                               ; preds = %13
  %17 = getelementptr i32, ptr %0, i64 %14, !dbg !20
  %18 = load i32, ptr %17, align 4, !dbg !21
  %19 = getelementptr i32, ptr %1, i64 %14, !dbg !22
  %20 = load i32, ptr %19, align 4, !dbg !23
  %21 = add i32 %18, %20, !dbg !24
  %22 = getelementptr i32, ptr %2, i64 %14, !dbg !25
  store i32 %21, ptr %22, align 4, !dbg !26
  %23 = add nuw nsw i64 %14, 1, !dbg !27
  br label %13, !dbg !28

24:                                               ; preds = %13
  %25 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, i64 20, 3, 0, !dbg !29
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 20, 3, 0, !dbg !30
  %27 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, i64 20, 3, 0, !dbg !31
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, i64 1, 4, 0, !dbg !32
  %29 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, i64 1, 4, 0, !dbg !33
  %30 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %27, i64 1, 4, 0, !dbg !34
  ret void, !dbg !35
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "generic_0", linkageName: "generic_0", scope: null, file: !4, line: 2, type: !5, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "accel-bare.mlir", directory: "/home/huiying/mlir-cgra/experiments/demo/add")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 4, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 5, column: 10, scope: !8)
!10 = !DILocation(line: 7, column: 10, scope: !8)
!11 = !DILocation(line: 13, column: 11, scope: !8)
!12 = !DILocation(line: 14, column: 11, scope: !8)
!13 = !DILocation(line: 16, column: 11, scope: !8)
!14 = !DILocation(line: 22, column: 11, scope: !8)
!15 = !DILocation(line: 23, column: 11, scope: !8)
!16 = !DILocation(line: 25, column: 11, scope: !8)
!17 = !DILocation(line: 33, column: 5, scope: !8)
!18 = !DILocation(line: 35, column: 11, scope: !8)
!19 = !DILocation(line: 36, column: 5, scope: !8)
!20 = !DILocation(line: 39, column: 11, scope: !8)
!21 = !DILocation(line: 40, column: 11, scope: !8)
!22 = !DILocation(line: 42, column: 11, scope: !8)
!23 = !DILocation(line: 43, column: 11, scope: !8)
!24 = !DILocation(line: 44, column: 11, scope: !8)
!25 = !DILocation(line: 46, column: 11, scope: !8)
!26 = !DILocation(line: 47, column: 5, scope: !8)
!27 = !DILocation(line: 48, column: 11, scope: !8)
!28 = !DILocation(line: 49, column: 5, scope: !8)
!29 = !DILocation(line: 9, column: 10, scope: !8)
!30 = !DILocation(line: 18, column: 11, scope: !8)
!31 = !DILocation(line: 27, column: 11, scope: !8)
!32 = !DILocation(line: 11, column: 10, scope: !8)
!33 = !DILocation(line: 20, column: 11, scope: !8)
!34 = !DILocation(line: 29, column: 11, scope: !8)
!35 = !DILocation(line: 51, column: 5, scope: !8)
