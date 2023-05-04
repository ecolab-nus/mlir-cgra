; ModuleID = '12-accel.ll'
source_filename = "LLVMDialectModule"
target triple = "i386-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @generic_0(ptr %0, ptr %1, ptr %2) !dbg !3 {
  br label %4, !dbg !7

4:                                                ; preds = %7, %3
  %5 = phi i64 [ %14, %7 ], [ 0, %3 ]
  %6 = icmp ult i64 %5, 256, !dbg !9
  br i1 %6, label %7, label %15, !dbg !10

7:                                                ; preds = %4
  call void @please_map_me(), !dbg !11
  %8 = getelementptr float, ptr %0, i64 %5, !dbg !12
  %9 = load float, ptr %8, align 4, !dbg !13
  %10 = getelementptr float, ptr %1, i64 %5, !dbg !14
  %11 = load float, ptr %10, align 4, !dbg !15
  %12 = fadd float %9, %11, !dbg !16
  %13 = getelementptr float, ptr %2, i64 %5, !dbg !17
  store float %12, ptr %13, align 4, !dbg !18
  %14 = add nuw nsw i64 %5, 1, !dbg !19
  br label %4, !dbg !20

15:                                               ; preds = %4
  ret void, !dbg !21
}

declare void @please_map_me()

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "generic_0", linkageName: "generic_0", scope: null, file: !4, line: 2, type: !5, scopeLine: 2, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "10-accel-llvm.mlir", directory: "/home/huiying/mlir-cgra/experiments/morpher/add-e2e")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 33, column: 5, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 35, column: 11, scope: !8)
!10 = !DILocation(line: 36, column: 5, scope: !8)
!11 = !DILocation(line: 38, column: 5, scope: !8)
!12 = !DILocation(line: 40, column: 11, scope: !8)
!13 = !DILocation(line: 41, column: 11, scope: !8)
!14 = !DILocation(line: 43, column: 11, scope: !8)
!15 = !DILocation(line: 44, column: 11, scope: !8)
!16 = !DILocation(line: 45, column: 11, scope: !8)
!17 = !DILocation(line: 47, column: 11, scope: !8)
!18 = !DILocation(line: 48, column: 5, scope: !8)
!19 = !DILocation(line: 49, column: 11, scope: !8)
!20 = !DILocation(line: 50, column: 5, scope: !8)
!21 = !DILocation(line: 52, column: 5, scope: !8)
