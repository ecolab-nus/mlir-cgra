; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target triple = "i386-unknown-linux-gnu"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @array_add(ptr %0, ptr %1, ptr %2) !dbg !3 {
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
  call void @please_map_me(), !dbg !26
  %23 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, 1, !dbg !27
  %24 = getelementptr i32, ptr %23, i64 %20, !dbg !28
  %25 = load i32, ptr %24, align 4, !dbg !29
  %26 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %13, 1, !dbg !30
  %27 = getelementptr i32, ptr %26, i64 %20, !dbg !31
  %28 = load i32, ptr %27, align 4, !dbg !32
  %29 = add i32 %25, %28, !dbg !33
  %30 = extractvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %18, 1, !dbg !34
  %31 = getelementptr i32, ptr %30, i64 %20, !dbg !35
  store i32 %29, ptr %31, align 4, !dbg !36
  %32 = add i64 %20, 1, !dbg !37
  br label %19, !dbg !38

33:                                               ; preds = %19
  ret void, !dbg !39
}

define void @main() !dbg !40 {
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !41
  %2 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %1, 0, !dbg !43
  %3 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %2, ptr %1, 1, !dbg !44
  %4 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %3, i64 0, 2, !dbg !45
  %5 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %4, i64 20, 3, 0, !dbg !46
  %6 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %5, i64 1, 4, 0, !dbg !47
  %7 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !48
  %8 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %7, 0, !dbg !49
  %9 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %8, ptr %7, 1, !dbg !50
  %10 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %9, i64 0, 2, !dbg !51
  %11 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %10, i64 20, 3, 0, !dbg !52
  %12 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %11, i64 1, 4, 0, !dbg !53
  %13 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i32, ptr null, i32 20) to i64)), !dbg !54
  %14 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } undef, ptr %13, 0, !dbg !55
  %15 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %14, ptr %13, 1, !dbg !56
  %16 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %15, i64 0, 2, !dbg !57
  %17 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %16, i64 20, 3, 0, !dbg !58
  %18 = insertvalue { ptr, ptr, i64, [1 x i64], [1 x i64] } %17, i64 1, 4, 0, !dbg !59
  br label %19, !dbg !60

19:                                               ; preds = %22, %0
  %20 = phi i64 [ %24, %22 ], [ 0, %0 ]
  %21 = icmp slt i64 %20, 20, !dbg !61
  br i1 %21, label %22, label %25, !dbg !62

22:                                               ; preds = %19
  %23 = getelementptr i32, ptr %1, i64 %20, !dbg !63
  store i32 1, ptr %23, align 4, !dbg !64
  %24 = add i64 %20, 1, !dbg !65
  br label %19, !dbg !66

25:                                               ; preds = %28, %19
  %26 = phi i64 [ %30, %28 ], [ 0, %19 ]
  %27 = icmp slt i64 %26, 20, !dbg !67
  br i1 %27, label %28, label %31, !dbg !68

28:                                               ; preds = %25
  %29 = getelementptr i32, ptr %7, i64 %26, !dbg !69
  store i32 1, ptr %29, align 4, !dbg !70
  %30 = add i64 %26, 1, !dbg !71
  br label %25, !dbg !72

31:                                               ; preds = %34, %25
  %32 = phi i64 [ %36, %34 ], [ 0, %25 ]
  %33 = icmp slt i64 %32, 20, !dbg !73
  br i1 %33, label %34, label %37, !dbg !74

34:                                               ; preds = %31
  %35 = getelementptr i32, ptr %13, i64 %32, !dbg !75
  store i32 0, ptr %35, align 4, !dbg !76
  %36 = add i64 %32, 1, !dbg !77
  br label %31, !dbg !78

37:                                               ; preds = %31
  call void @array_add(ptr %1, ptr %7, ptr %13), !dbg !79
  call void @free(ptr %1), !dbg !80
  call void @free(ptr %7), !dbg !81
  call void @free(ptr %13), !dbg !82
  ret void, !dbg !83
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
!7 = !DILocation(line: 6, column: 10, scope: !8)
!8 = !DILexicalBlockFile(scope: !3, file: !4, discriminator: 0)
!9 = !DILocation(line: 7, column: 10, scope: !8)
!10 = !DILocation(line: 9, column: 10, scope: !8)
!11 = !DILocation(line: 11, column: 10, scope: !8)
!12 = !DILocation(line: 13, column: 10, scope: !8)
!13 = !DILocation(line: 15, column: 11, scope: !8)
!14 = !DILocation(line: 16, column: 11, scope: !8)
!15 = !DILocation(line: 18, column: 11, scope: !8)
!16 = !DILocation(line: 20, column: 11, scope: !8)
!17 = !DILocation(line: 22, column: 11, scope: !8)
!18 = !DILocation(line: 24, column: 11, scope: !8)
!19 = !DILocation(line: 25, column: 11, scope: !8)
!20 = !DILocation(line: 27, column: 11, scope: !8)
!21 = !DILocation(line: 29, column: 11, scope: !8)
!22 = !DILocation(line: 31, column: 11, scope: !8)
!23 = !DILocation(line: 35, column: 5, scope: !8)
!24 = !DILocation(line: 37, column: 11, scope: !8)
!25 = !DILocation(line: 38, column: 5, scope: !8)
!26 = !DILocation(line: 40, column: 5, scope: !8)
!27 = !DILocation(line: 41, column: 11, scope: !8)
!28 = !DILocation(line: 42, column: 11, scope: !8)
!29 = !DILocation(line: 43, column: 11, scope: !8)
!30 = !DILocation(line: 44, column: 11, scope: !8)
!31 = !DILocation(line: 45, column: 11, scope: !8)
!32 = !DILocation(line: 46, column: 11, scope: !8)
!33 = !DILocation(line: 47, column: 11, scope: !8)
!34 = !DILocation(line: 48, column: 11, scope: !8)
!35 = !DILocation(line: 49, column: 11, scope: !8)
!36 = !DILocation(line: 50, column: 5, scope: !8)
!37 = !DILocation(line: 51, column: 11, scope: !8)
!38 = !DILocation(line: 52, column: 5, scope: !8)
!39 = !DILocation(line: 54, column: 5, scope: !8)
!40 = distinct !DISubprogram(name: "main", linkageName: "main", scope: null, file: !4, line: 56, type: !5, scopeLine: 56, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !6)
!41 = !DILocation(line: 67, column: 11, scope: !42)
!42 = !DILexicalBlockFile(scope: !40, file: !4, discriminator: 0)
!43 = !DILocation(line: 70, column: 11, scope: !42)
!44 = !DILocation(line: 71, column: 11, scope: !42)
!45 = !DILocation(line: 73, column: 11, scope: !42)
!46 = !DILocation(line: 74, column: 11, scope: !42)
!47 = !DILocation(line: 75, column: 11, scope: !42)
!48 = !DILocation(line: 81, column: 11, scope: !42)
!49 = !DILocation(line: 84, column: 11, scope: !42)
!50 = !DILocation(line: 85, column: 11, scope: !42)
!51 = !DILocation(line: 87, column: 11, scope: !42)
!52 = !DILocation(line: 88, column: 11, scope: !42)
!53 = !DILocation(line: 89, column: 11, scope: !42)
!54 = !DILocation(line: 95, column: 11, scope: !42)
!55 = !DILocation(line: 98, column: 11, scope: !42)
!56 = !DILocation(line: 99, column: 11, scope: !42)
!57 = !DILocation(line: 101, column: 11, scope: !42)
!58 = !DILocation(line: 102, column: 11, scope: !42)
!59 = !DILocation(line: 103, column: 11, scope: !42)
!60 = !DILocation(line: 104, column: 5, scope: !42)
!61 = !DILocation(line: 106, column: 11, scope: !42)
!62 = !DILocation(line: 107, column: 5, scope: !42)
!63 = !DILocation(line: 109, column: 11, scope: !42)
!64 = !DILocation(line: 110, column: 5, scope: !42)
!65 = !DILocation(line: 111, column: 11, scope: !42)
!66 = !DILocation(line: 112, column: 5, scope: !42)
!67 = !DILocation(line: 114, column: 11, scope: !42)
!68 = !DILocation(line: 115, column: 5, scope: !42)
!69 = !DILocation(line: 117, column: 11, scope: !42)
!70 = !DILocation(line: 118, column: 5, scope: !42)
!71 = !DILocation(line: 119, column: 11, scope: !42)
!72 = !DILocation(line: 120, column: 5, scope: !42)
!73 = !DILocation(line: 122, column: 11, scope: !42)
!74 = !DILocation(line: 123, column: 5, scope: !42)
!75 = !DILocation(line: 125, column: 11, scope: !42)
!76 = !DILocation(line: 126, column: 5, scope: !42)
!77 = !DILocation(line: 127, column: 11, scope: !42)
!78 = !DILocation(line: 128, column: 5, scope: !42)
!79 = !DILocation(line: 130, column: 5, scope: !42)
!80 = !DILocation(line: 132, column: 5, scope: !42)
!81 = !DILocation(line: 134, column: 5, scope: !42)
!82 = !DILocation(line: 136, column: 5, scope: !42)
!83 = !DILocation(line: 137, column: 5, scope: !42)
