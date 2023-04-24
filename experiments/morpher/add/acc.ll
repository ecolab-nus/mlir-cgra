; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @generic_0(ptr %0, ptr %1, ptr %2) !dbg !3 {
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0, !dbg !7
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, ptr %0, 1, !dbg !9
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 0, 2, !dbg !10
  %7 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %6, i64 20, 3, 0, !dbg !11
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %7, i64 1, 4, 0, !dbg !12
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0, !dbg !13
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, ptr %1, 1, !dbg !14
  %11 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, i64 0, 2, !dbg !15
  %12 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %11, i64 20, 3, 0, !dbg !16
  %13 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %12, i64 1, 4, 0, !dbg !17
  %14 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %2, 0, !dbg !18
  %15 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %14, ptr %2, 1, !dbg !19
  %16 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %15, i64 0, 2, !dbg !20
  %17 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %16, i64 20, 3, 0, !dbg !21
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %17, i64 1, 4, 0, !dbg !22
  br label %19, !dbg !23

19:                                               ; preds = %22, %3
  %20 = phi i64 [ %32, %22 ], [ 0, %3 ]
  %21 = icmp slt i64 %20, 20, !dbg !24
  br i1 %21, label %22, label %33, !dbg !25

22:                                               ; preds = %19
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, 1, !dbg !26
  %24 = getelementptr i32, ptr %23, i64 %20, !dbg !27
  %25 = load i32, ptr %24, align 4, !dbg !28
  %26 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %13, 1, !dbg !29
  %27 = getelementptr i32, ptr %26, i64 %20, !dbg !30
  %28 = load i32, ptr %27, align 4, !dbg !31
  %29 = add i32 %25, %28, !dbg !32
  %30 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, 1, !dbg !33
  %31 = getelementptr i32, ptr %30, i64 %20, !dbg !34
  store i32 %29, ptr %31, align 4, !dbg !35
  %32 = add i64 %20, 1, !dbg !36
  br label %19, !dbg !37

33:                                               ; preds = %19
  ret void, !dbg !38
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "generic_0", linkageName: "generic_0", scope: null, file: !4, line: 2, type: !5, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "acc.mlir", directory: "/home/huiying/mlir-cgra/experiments/demo/add")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 4, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 5, column: 10, scope: !8)
!10 = !DILocation(line: 7, column: 10, scope: !8)
!11 = !DILocation(line: 9, column: 10, scope: !8)
!12 = !DILocation(line: 11, column: 10, scope: !8)
!13 = !DILocation(line: 13, column: 11, scope: !8)
!14 = !DILocation(line: 14, column: 11, scope: !8)
!15 = !DILocation(line: 16, column: 11, scope: !8)
!16 = !DILocation(line: 18, column: 11, scope: !8)
!17 = !DILocation(line: 20, column: 11, scope: !8)
!18 = !DILocation(line: 22, column: 11, scope: !8)
!19 = !DILocation(line: 23, column: 11, scope: !8)
!20 = !DILocation(line: 25, column: 11, scope: !8)
!21 = !DILocation(line: 27, column: 11, scope: !8)
!22 = !DILocation(line: 29, column: 11, scope: !8)
!23 = !DILocation(line: 33, column: 5, scope: !8)
!24 = !DILocation(line: 35, column: 11, scope: !8)
!25 = !DILocation(line: 36, column: 5, scope: !8)
!26 = !DILocation(line: 38, column: 11, scope: !8)
!27 = !DILocation(line: 39, column: 11, scope: !8)
!28 = !DILocation(line: 40, column: 11, scope: !8)
!29 = !DILocation(line: 41, column: 11, scope: !8)
!30 = !DILocation(line: 42, column: 11, scope: !8)
!31 = !DILocation(line: 43, column: 11, scope: !8)
!32 = !DILocation(line: 44, column: 11, scope: !8)
!33 = !DILocation(line: 45, column: 11, scope: !8)
!34 = !DILocation(line: 46, column: 11, scope: !8)
!35 = !DILocation(line: 47, column: 5, scope: !8)
!36 = !DILocation(line: 48, column: 11, scope: !8)
!37 = !DILocation(line: 49, column: 5, scope: !8)
!38 = !DILocation(line: 51, column: 5, scope: !8)
