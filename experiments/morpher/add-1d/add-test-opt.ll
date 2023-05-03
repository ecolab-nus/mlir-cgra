; ModuleID = 'add-test.ll'
source_filename = "LLVMDialectModule"
target triple = "i386-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @array_add(ptr %0, ptr %1, ptr %2) !dbg !3 {
  br label %4, !dbg !7

4:                                                ; preds = %7, %3
  %5 = phi i64 [ %14, %7 ], [ 0, %3 ]
  %6 = icmp ult i64 %5, 20, !dbg !9
  br i1 %6, label %7, label %15, !dbg !10

7:                                                ; preds = %4
  call void @please_map_me(), !dbg !11
  %8 = getelementptr i32, ptr %0, i64 %5, !dbg !12
  %9 = load i32, ptr %8, align 4, !dbg !13
  %10 = getelementptr i32, ptr %1, i64 %5, !dbg !14
  %11 = load i32, ptr %10, align 4, !dbg !15
  %12 = add i32 %9, %11, !dbg !16
  %13 = getelementptr i32, ptr %2, i64 %5, !dbg !17
  store i32 %12, ptr %13, align 4, !dbg !18
  %14 = add nuw nsw i64 %5, 1, !dbg !19
  br label %4, !dbg !20

15:                                               ; preds = %4
  ret void, !dbg !21
}

define void @main() !dbg !22 {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !23
  %2 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !25
  %3 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !26
  br label %4, !dbg !27

4:                                                ; preds = %7, %0
  %5 = phi i64 [ %9, %7 ], [ 0, %0 ]
  %6 = icmp ult i64 %5, 20, !dbg !28
  br i1 %6, label %7, label %.preheader1, !dbg !29

.preheader1:                                      ; preds = %4
  br label %10, !dbg !30

7:                                                ; preds = %4
  %8 = getelementptr i32, ptr %1, i64 %5, !dbg !31
  store i32 1, ptr %8, align 4, !dbg !32
  %9 = add nuw nsw i64 %5, 1, !dbg !33
  br label %4, !dbg !34

10:                                               ; preds = %.preheader1, %13
  %11 = phi i64 [ %15, %13 ], [ 0, %.preheader1 ]
  %12 = icmp ult i64 %11, 20, !dbg !35
  br i1 %12, label %13, label %.preheader, !dbg !30

.preheader:                                       ; preds = %10
  br label %16, !dbg !36

13:                                               ; preds = %10
  %14 = getelementptr i32, ptr %2, i64 %11, !dbg !37
  store i32 1, ptr %14, align 4, !dbg !38
  %15 = add nuw nsw i64 %11, 1, !dbg !39
  br label %10, !dbg !40

16:                                               ; preds = %.preheader, %19
  %17 = phi i64 [ %21, %19 ], [ 0, %.preheader ]
  %18 = icmp ult i64 %17, 20, !dbg !41
  br i1 %18, label %19, label %22, !dbg !36

19:                                               ; preds = %16
  %20 = getelementptr i32, ptr %3, i64 %17, !dbg !42
  store i32 0, ptr %20, align 4, !dbg !43
  %21 = add nuw nsw i64 %17, 1, !dbg !44
  br label %16, !dbg !45

22:                                               ; preds = %16
  call void @array_add(ptr %1, ptr %2, ptr %3), !dbg !46
  call void @free(ptr %1), !dbg !47
  call void @free(ptr %2), !dbg !48
  call void @free(ptr %3), !dbg !49
  ret void, !dbg !50
}

declare void @please_map_me()

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "array_add", linkageName: "array_add", scope: null, file: !4, line: 4, type: !5, scopeLine: 4, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "add-test-llvm.mlir", directory: "/home/huiying/mlir-cgra/experiments/morpher/add")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 35, column: 5, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 37, column: 11, scope: !8)
!10 = !DILocation(line: 38, column: 5, scope: !8)
!11 = !DILocation(line: 40, column: 5, scope: !8)
!12 = !DILocation(line: 42, column: 11, scope: !8)
!13 = !DILocation(line: 43, column: 11, scope: !8)
!14 = !DILocation(line: 45, column: 11, scope: !8)
!15 = !DILocation(line: 46, column: 11, scope: !8)
!16 = !DILocation(line: 47, column: 11, scope: !8)
!17 = !DILocation(line: 49, column: 11, scope: !8)
!18 = !DILocation(line: 50, column: 5, scope: !8)
!19 = !DILocation(line: 51, column: 11, scope: !8)
!20 = !DILocation(line: 52, column: 5, scope: !8)
!21 = !DILocation(line: 54, column: 5, scope: !8)
!22 = distinct !DISubprogram(name: "main", linkageName: "main", scope: null, file: !4, line: 56, type: !5, scopeLine: 56, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!23 = !DILocation(line: 67, column: 11, scope: !24)
!24 = !DILexicalBlockFile(scope: !22, file: !4, discriminator: 0)
!25 = !DILocation(line: 81, column: 11, scope: !24)
!26 = !DILocation(line: 95, column: 11, scope: !24)
!27 = !DILocation(line: 104, column: 5, scope: !24)
!28 = !DILocation(line: 106, column: 11, scope: !24)
!29 = !DILocation(line: 107, column: 5, scope: !24)
!30 = !DILocation(line: 115, column: 5, scope: !24)
!31 = !DILocation(line: 109, column: 11, scope: !24)
!32 = !DILocation(line: 110, column: 5, scope: !24)
!33 = !DILocation(line: 111, column: 11, scope: !24)
!34 = !DILocation(line: 112, column: 5, scope: !24)
!35 = !DILocation(line: 114, column: 11, scope: !24)
!36 = !DILocation(line: 123, column: 5, scope: !24)
!37 = !DILocation(line: 117, column: 11, scope: !24)
!38 = !DILocation(line: 118, column: 5, scope: !24)
!39 = !DILocation(line: 119, column: 11, scope: !24)
!40 = !DILocation(line: 120, column: 5, scope: !24)
!41 = !DILocation(line: 122, column: 11, scope: !24)
!42 = !DILocation(line: 125, column: 11, scope: !24)
!43 = !DILocation(line: 126, column: 5, scope: !24)
!44 = !DILocation(line: 127, column: 11, scope: !24)
!45 = !DILocation(line: 128, column: 5, scope: !24)
!46 = !DILocation(line: 130, column: 5, scope: !24)
!47 = !DILocation(line: 132, column: 5, scope: !24)
!48 = !DILocation(line: 134, column: 5, scope: !24)
!49 = !DILocation(line: 136, column: 5, scope: !24)
!50 = !DILocation(line: 137, column: 5, scope: !24)
