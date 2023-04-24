; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @generic_0(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14) !dbg !3 {
  %16 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %0, 0, !dbg !7
  %17 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %16, ptr %1, 1, !dbg !9
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %17, i64 %2, 2, !dbg !10
  %19 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, i64 %3, 3, 0, !dbg !11
  %20 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %19, i64 %4, 4, 0, !dbg !12
  %21 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %5, 0, !dbg !13
  %22 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %21, ptr %6, 1, !dbg !14
  %23 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %22, i64 %7, 2, !dbg !15
  %24 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %23, i64 %8, 3, 0, !dbg !16
  %25 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %24, i64 %9, 4, 0, !dbg !17
  %26 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %10, 0, !dbg !18
  %27 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %26, ptr %11, 1, !dbg !19
  %28 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %27, i64 %12, 2, !dbg !20
  %29 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %28, i64 %13, 3, 0, !dbg !21
  %30 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %29, i64 %14, 4, 0, !dbg !22
  br label %31, !dbg !23

31:                                               ; preds = %34, %15
  %32 = phi i64 [ %50, %34 ], [ 0, %15 ]
  %33 = icmp slt i64 %32, 20, !dbg !24
  br i1 %33, label %34, label %51, !dbg !25

34:                                               ; preds = %31
  %35 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 1, !dbg !26
  %36 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 2, !dbg !27
  %37 = add i64 %36, %32, !dbg !28
  %38 = getelementptr i32, ptr %35, i64 %37, !dbg !29
  %39 = load i32, ptr %38, align 4, !dbg !30
  %40 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, 1, !dbg !31
  %41 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, 2, !dbg !32
  %42 = add i64 %41, %32, !dbg !33
  %43 = getelementptr i32, ptr %40, i64 %42, !dbg !34
  %44 = load i32, ptr %43, align 4, !dbg !35
  %45 = add i32 %39, %44, !dbg !36
  %46 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 1, !dbg !37
  %47 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 2, !dbg !38
  %48 = add i64 %47, %32, !dbg !39
  %49 = getelementptr i32, ptr %46, i64 %48, !dbg !40
  store i32 %45, ptr %49, align 4, !dbg !41
  %50 = add i64 %32, 1, !dbg !42
  br label %31, !dbg !43

51:                                               ; preds = %31
  ret void, !dbg !44
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "generic_0", linkageName: "generic_0", scope: null, file: !4, line: 2, type: !5, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "10-accel-llvm.mlir", directory: "/home/huiying/mlir-cgra/experiments/demo/add")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 4, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 5, column: 10, scope: !8)
!10 = !DILocation(line: 6, column: 10, scope: !8)
!11 = !DILocation(line: 7, column: 10, scope: !8)
!12 = !DILocation(line: 8, column: 10, scope: !8)
!13 = !DILocation(line: 10, column: 10, scope: !8)
!14 = !DILocation(line: 11, column: 10, scope: !8)
!15 = !DILocation(line: 12, column: 10, scope: !8)
!16 = !DILocation(line: 13, column: 11, scope: !8)
!17 = !DILocation(line: 14, column: 11, scope: !8)
!18 = !DILocation(line: 16, column: 11, scope: !8)
!19 = !DILocation(line: 17, column: 11, scope: !8)
!20 = !DILocation(line: 18, column: 11, scope: !8)
!21 = !DILocation(line: 19, column: 11, scope: !8)
!22 = !DILocation(line: 20, column: 11, scope: !8)
!23 = !DILocation(line: 24, column: 5, scope: !8)
!24 = !DILocation(line: 26, column: 11, scope: !8)
!25 = !DILocation(line: 27, column: 5, scope: !8)
!26 = !DILocation(line: 29, column: 11, scope: !8)
!27 = !DILocation(line: 30, column: 11, scope: !8)
!28 = !DILocation(line: 31, column: 11, scope: !8)
!29 = !DILocation(line: 32, column: 11, scope: !8)
!30 = !DILocation(line: 33, column: 11, scope: !8)
!31 = !DILocation(line: 34, column: 11, scope: !8)
!32 = !DILocation(line: 35, column: 11, scope: !8)
!33 = !DILocation(line: 36, column: 11, scope: !8)
!34 = !DILocation(line: 37, column: 11, scope: !8)
!35 = !DILocation(line: 38, column: 11, scope: !8)
!36 = !DILocation(line: 39, column: 11, scope: !8)
!37 = !DILocation(line: 40, column: 11, scope: !8)
!38 = !DILocation(line: 41, column: 11, scope: !8)
!39 = !DILocation(line: 42, column: 11, scope: !8)
!40 = !DILocation(line: 43, column: 11, scope: !8)
!41 = !DILocation(line: 44, column: 5, scope: !8)
!42 = !DILocation(line: 45, column: 11, scope: !8)
!43 = !DILocation(line: 46, column: 5, scope: !8)
!44 = !DILocation(line: 48, column: 5, scope: !8)
