; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "x86_64-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

declare void @cgra_generic_0(ptr, ptr, i64, i64, i64, ptr, ptr, i64, i64, i64, ptr, ptr, i64, i64, i64)

define void @main_graph(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, ptr %5, ptr %6, i64 %7, i64 %8, i64 %9, ptr %10, ptr %11, i64 %12, i64 %13, i64 %14) !dbg !3 {
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
  %31 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64), i64 128)), !dbg !23
  %32 = ptrtoint ptr %31 to i64, !dbg !24
  %33 = add i64 %32, 127, !dbg !25
  %34 = urem i64 %33, 128, !dbg !26
  %35 = sub i64 %33, %34, !dbg !27
  %36 = inttoptr i64 %35 to ptr, !dbg !28
  %37 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %31, 0, !dbg !29
  %38 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %37, ptr %36, 1, !dbg !30
  %39 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %38, i64 0, 2, !dbg !31
  %40 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %39, i64 20, 3, 0, !dbg !32
  %41 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %40, i64 1, 4, 0, !dbg !33
  %42 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 0, !dbg !34
  %43 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 1, !dbg !35
  %44 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 2, !dbg !36
  %45 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 3, 0, !dbg !37
  %46 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %20, 4, 0, !dbg !38
  %47 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, 0, !dbg !39
  %48 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, 1, !dbg !40
  %49 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, 2, !dbg !41
  %50 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, 3, 0, !dbg !42
  %51 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %25, 4, 0, !dbg !43
  call void @cgra_generic_0(ptr %42, ptr %43, i64 %44, i64 %45, i64 %46, ptr %47, ptr %48, i64 %49, i64 %50, i64 %51, ptr %31, ptr %36, i64 0, i64 20, i64 1), !dbg !44
  %52 = getelementptr i32, ptr %36, i64 0, !dbg !45
  %53 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 1, !dbg !46
  %54 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %30, 2, !dbg !47
  %55 = getelementptr i32, ptr %53, i64 %54, !dbg !48
  call void @llvm.memcpy.p0.p0.i64(ptr %55, ptr %52, i64 mul (i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 1) to i64), i64 20), i1 false), !dbg !49
  ret void, !dbg !50
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { argmemonly nocallback nofree nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "mlir", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "LLVMDialectModule", directory: "/")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = distinct !DISubprogram(name: "main_graph", linkageName: "main_graph", scope: null, file: !4, line: 4, type: !5, scopeLine: 4, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!4 = !DIFile(filename: "09-host-llvm.mlir", directory: "/home/huiying/mlir-cgra/experiments/demo/add")
!5 = !DISubroutineType(types: !6)
!6 = !{}
!7 = !DILocation(line: 6, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 7, column: 10, scope: !8)
!10 = !DILocation(line: 8, column: 10, scope: !8)
!11 = !DILocation(line: 9, column: 10, scope: !8)
!12 = !DILocation(line: 10, column: 10, scope: !8)
!13 = !DILocation(line: 12, column: 10, scope: !8)
!14 = !DILocation(line: 13, column: 10, scope: !8)
!15 = !DILocation(line: 14, column: 10, scope: !8)
!16 = !DILocation(line: 15, column: 11, scope: !8)
!17 = !DILocation(line: 16, column: 11, scope: !8)
!18 = !DILocation(line: 18, column: 11, scope: !8)
!19 = !DILocation(line: 19, column: 11, scope: !8)
!20 = !DILocation(line: 20, column: 11, scope: !8)
!21 = !DILocation(line: 21, column: 11, scope: !8)
!22 = !DILocation(line: 22, column: 11, scope: !8)
!23 = !DILocation(line: 30, column: 11, scope: !8)
!24 = !DILocation(line: 32, column: 11, scope: !8)
!25 = !DILocation(line: 35, column: 11, scope: !8)
!26 = !DILocation(line: 36, column: 11, scope: !8)
!27 = !DILocation(line: 37, column: 11, scope: !8)
!28 = !DILocation(line: 38, column: 11, scope: !8)
!29 = !DILocation(line: 40, column: 11, scope: !8)
!30 = !DILocation(line: 41, column: 11, scope: !8)
!31 = !DILocation(line: 43, column: 11, scope: !8)
!32 = !DILocation(line: 44, column: 11, scope: !8)
!33 = !DILocation(line: 45, column: 11, scope: !8)
!34 = !DILocation(line: 46, column: 11, scope: !8)
!35 = !DILocation(line: 47, column: 11, scope: !8)
!36 = !DILocation(line: 48, column: 11, scope: !8)
!37 = !DILocation(line: 49, column: 11, scope: !8)
!38 = !DILocation(line: 50, column: 11, scope: !8)
!39 = !DILocation(line: 51, column: 11, scope: !8)
!40 = !DILocation(line: 52, column: 11, scope: !8)
!41 = !DILocation(line: 53, column: 11, scope: !8)
!42 = !DILocation(line: 54, column: 11, scope: !8)
!43 = !DILocation(line: 55, column: 11, scope: !8)
!44 = !DILocation(line: 56, column: 5, scope: !8)
!45 = !DILocation(line: 63, column: 11, scope: !8)
!46 = !DILocation(line: 64, column: 11, scope: !8)
!47 = !DILocation(line: 65, column: 11, scope: !8)
!48 = !DILocation(line: 66, column: 11, scope: !8)
!49 = !DILocation(line: 68, column: 5, scope: !8)
!50 = !DILocation(line: 69, column: 5, scope: !8)
