; ModuleID = 'accel-bare-opt.ll'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

@0 = private unnamed_addr constant [10 x i8] c"generic_0\00", align 1
@1 = private unnamed_addr constant [3 x i8] c"%0\00", align 1
@2 = private unnamed_addr constant [3 x i8] c"%1\00", align 1
@3 = private unnamed_addr constant [3 x i8] c"%2\00", align 1
@4 = private unnamed_addr constant [10 x i8] c"generic_0\00", align 1

declare ptr @malloc(i64)

declare void @free(ptr)

define void @generic_0(ptr %0, ptr %1, ptr %2) !dbg !3 {
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
!3 = distinct !DISubprogram(name: "generic_0", linkageName: "generic_0", scope: null, file: !4, line: 2, type: !5, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "accel-bare.mlir", directory: "/home/huiying/mlir-cgra/experiments/morpher/add")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 33, column: 5, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 35, column: 11, scope: !8)
!10 = !DILocation(line: 36, column: 5, scope: !8)
!11 = !DILocation(line: 40, column: 11, scope: !8)
!12 = !DILocation(line: 41, column: 11, scope: !8)
!13 = !DILocation(line: 43, column: 11, scope: !8)
!14 = !DILocation(line: 44, column: 11, scope: !8)
!15 = !DILocation(line: 45, column: 11, scope: !8)
!16 = !DILocation(line: 47, column: 11, scope: !8)
!17 = !DILocation(line: 48, column: 5, scope: !8)
!18 = !DILocation(line: 49, column: 11, scope: !8)
!19 = !DILocation(line: 50, column: 5, scope: !8)
!20 = !DILocation(line: 52, column: 5, scope: !8)
