; ModuleID = 'add-test-opt.ll'
source_filename = "LLVMDialectModule"
target triple = "i386-unknown-linux-gnu"

@0 = private unnamed_addr constant [10 x i8] c"array_add\00", align 1
@1 = private unnamed_addr constant [3 x i8] c"%0\00", align 1
@2 = private unnamed_addr constant [3 x i8] c"%1\00", align 1
@3 = private unnamed_addr constant [3 x i8] c"%2\00", align 1
@4 = private unnamed_addr constant [10 x i8] c"array_add\00", align 1

declare ptr @malloc(i64)

declare void @free(ptr)

define void @array_add(ptr %0, ptr %1, ptr %2) !dbg !3 {
  call void @loopStart(ptr @0), !dbg !7
  call void @LiveInReport(ptr @1, ptr %0, i32 4), !dbg !7
  call void @LiveInReport(ptr @2, ptr %1, i32 4), !dbg !7
  call void @LiveInReport(ptr @3, ptr %2, i32 4), !dbg !7
  br label %4, !dbg !7

4:                                                ; preds = %5, %3
  %temp0 = phi i64 [ %temp8, %5 ], [ 0, %3 ]
  %temp1 = icmp ult i64 %temp0, 20, !dbg !9
  br i1 %temp1, label %5, label %6, !dbg !10

5:                                                ; preds = %4
  %temp2 = getelementptr i32, ptr %0, i64 %temp0, !dbg !11
  %temp3 = load i32, ptr %temp2, align 4, !dbg !12
  %temp4 = getelementptr i32, ptr %1, i64 %temp0, !dbg !13
  %temp5 = load i32, ptr %temp4, align 4, !dbg !14
  %temp6 = add i32 %temp3, %temp5, !dbg !15
  %temp7 = getelementptr i32, ptr %2, i64 %temp0, !dbg !16
  store i32 %temp6, ptr %temp7, align 4, !dbg !17
  %temp8 = add nuw nsw i64 %temp0, 1, !dbg !18
  br label %4, !dbg !19

6:                                                ; preds = %4
  call void @LiveOutReport(ptr @1, ptr %0, i32 4), !dbg !20
  call void @LiveOutReport(ptr @2, ptr %1, i32 4), !dbg !20
  call void @LiveOutReport(ptr @3, ptr %2, i32 4), !dbg !20
  call void @loopEnd(ptr @4), !dbg !20
  ret void, !dbg !20
}

define void @main() !dbg !21 {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !22
  %2 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !24
  %3 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !25
  br label %4, !dbg !26

4:                                                ; preds = %7, %0
  %5 = phi i64 [ %9, %7 ], [ 0, %0 ]
  %6 = icmp ult i64 %5, 20, !dbg !27
  br i1 %6, label %7, label %.preheader1, !dbg !28

.preheader1:                                      ; preds = %4
  br label %10, !dbg !29

7:                                                ; preds = %4
  %8 = getelementptr i32, ptr %1, i64 %5, !dbg !30
  store i32 1, ptr %8, align 4, !dbg !31
  %9 = add nuw nsw i64 %5, 1, !dbg !32
  br label %4, !dbg !33

10:                                               ; preds = %13, %.preheader1
  %11 = phi i64 [ %15, %13 ], [ 0, %.preheader1 ]
  %12 = icmp ult i64 %11, 20, !dbg !34
  br i1 %12, label %13, label %.preheader, !dbg !29

.preheader:                                       ; preds = %10
  br label %16, !dbg !35

13:                                               ; preds = %10
  %14 = getelementptr i32, ptr %2, i64 %11, !dbg !36
  store i32 1, ptr %14, align 4, !dbg !37
  %15 = add nuw nsw i64 %11, 1, !dbg !38
  br label %10, !dbg !39

16:                                               ; preds = %19, %.preheader
  %17 = phi i64 [ %21, %19 ], [ 0, %.preheader ]
  %18 = icmp ult i64 %17, 20, !dbg !40
  br i1 %18, label %19, label %22, !dbg !35

19:                                               ; preds = %16
  %20 = getelementptr i32, ptr %3, i64 %17, !dbg !41
  store i32 0, ptr %20, align 4, !dbg !42
  %21 = add nuw nsw i64 %17, 1, !dbg !43
  br label %16, !dbg !44

22:                                               ; preds = %16
  call void @array_add(ptr %1, ptr %2, ptr %3), !dbg !45
  call void @free(ptr %1), !dbg !46
  call void @free(ptr %2), !dbg !47
  call void @free(ptr %3), !dbg !48
  ret void, !dbg !49
}

declare void @please_map_me()

declare void @loopStart(ptr)

declare void @clearPrintedArrs()

declare void @printArr(ptr, ptr, i32, i8, i32)

declare void @reportDynArrSize(ptr, ptr, i32, i32)

declare void @printDynArrSize()

declare void @loopEnd(ptr)

declare void @LiveInReport(ptr, ptr, i32)

declare void @LiveInReport2(ptr, ptr, i32)

declare void @LiveInReportPtrTypeUsage(ptr, ptr, i32, i32)

declare void @LiveOutReport(ptr, ptr, i32)

declare void @LiveInReportIntermediateVar(ptr, i32)

declare void @LiveOutReportIntermediateVar(ptr, i32)

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
!11 = !DILocation(line: 42, column: 11, scope: !8)
!12 = !DILocation(line: 43, column: 11, scope: !8)
!13 = !DILocation(line: 45, column: 11, scope: !8)
!14 = !DILocation(line: 46, column: 11, scope: !8)
!15 = !DILocation(line: 47, column: 11, scope: !8)
!16 = !DILocation(line: 49, column: 11, scope: !8)
!17 = !DILocation(line: 50, column: 5, scope: !8)
!18 = !DILocation(line: 51, column: 11, scope: !8)
!19 = !DILocation(line: 52, column: 5, scope: !8)
!20 = !DILocation(line: 54, column: 5, scope: !8)
!21 = distinct !DISubprogram(name: "main", linkageName: "main", scope: null, file: !4, line: 56, type: !5, scopeLine: 56, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!22 = !DILocation(line: 67, column: 11, scope: !23)
!23 = !DILexicalBlockFile(scope: !21, file: !4, discriminator: 0)
!24 = !DILocation(line: 81, column: 11, scope: !23)
!25 = !DILocation(line: 95, column: 11, scope: !23)
!26 = !DILocation(line: 104, column: 5, scope: !23)
!27 = !DILocation(line: 106, column: 11, scope: !23)
!28 = !DILocation(line: 107, column: 5, scope: !23)
!29 = !DILocation(line: 115, column: 5, scope: !23)
!30 = !DILocation(line: 109, column: 11, scope: !23)
!31 = !DILocation(line: 110, column: 5, scope: !23)
!32 = !DILocation(line: 111, column: 11, scope: !23)
!33 = !DILocation(line: 112, column: 5, scope: !23)
!34 = !DILocation(line: 114, column: 11, scope: !23)
!35 = !DILocation(line: 123, column: 5, scope: !23)
!36 = !DILocation(line: 117, column: 11, scope: !23)
!37 = !DILocation(line: 118, column: 5, scope: !23)
!38 = !DILocation(line: 119, column: 11, scope: !23)
!39 = !DILocation(line: 120, column: 5, scope: !23)
!40 = !DILocation(line: 122, column: 11, scope: !23)
!41 = !DILocation(line: 125, column: 11, scope: !23)
!42 = !DILocation(line: 126, column: 5, scope: !23)
!43 = !DILocation(line: 127, column: 11, scope: !23)
!44 = !DILocation(line: 128, column: 5, scope: !23)
!45 = !DILocation(line: 130, column: 5, scope: !23)
!46 = !DILocation(line: 132, column: 5, scope: !23)
!47 = !DILocation(line: 134, column: 5, scope: !23)
!48 = !DILocation(line: 136, column: 5, scope: !23)
!49 = !DILocation(line: 137, column: 5, scope: !23)
