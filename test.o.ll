; ModuleID = 'test.o'
source_filename = "test.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32-unknown-unknown-wasm"

; Function Attrs: nounwind
define hidden void @padding(i8* nocapture %dst, i8* nocapture readnone %p, i32 %p_stride, [4 x i8]* nocapture readonly %left, i8* nocapture readonly %lpf, i32 %lpf_stride, i32 %unit_w, i32 %stripe_h, i32 %edges) local_unnamed_addr #0 !dbg !14 {
entry:
  call void @llvm.dbg.value(metadata i8* %dst, metadata !35, metadata !DIExpression()), !dbg !46
  call void @llvm.dbg.value(metadata i8* undef, metadata !36, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.value(metadata i32 undef, metadata !37, metadata !DIExpression()), !dbg !48
  call void @llvm.dbg.value(metadata [4 x i8]* %left, metadata !38, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.value(metadata i8* %lpf, metadata !39, metadata !DIExpression()), !dbg !50
  call void @llvm.dbg.value(metadata i32 undef, metadata !40, metadata !DIExpression()), !dbg !51
  call void @llvm.dbg.value(metadata i32 %unit_w, metadata !41, metadata !DIExpression()), !dbg !52
  call void @llvm.dbg.value(metadata i32 undef, metadata !42, metadata !DIExpression()), !dbg !53
  call void @llvm.dbg.value(metadata i32 %edges, metadata !43, metadata !DIExpression()), !dbg !54
  %and = and i32 %edges, 1, !dbg !55
  %tobool = icmp ne i32 %and, 0, !dbg !56
  %mul = select i1 %tobool, i32 0, i32 3, !dbg !57
  %add.ptr = getelementptr inbounds i8, i8* %dst, i32 %mul, !dbg !58
  call void @llvm.dbg.value(metadata i8* %add.ptr, metadata !45, metadata !DIExpression()), !dbg !59
  %and5 = and i32 %edges, 4, !dbg !60
  %tobool6 = icmp eq i32 %and5, 0, !dbg !60
  br i1 %tobool6, label %if.else, label %if.then, !dbg !62

if.then:                                          ; preds = %entry
  tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* align 1 %add.ptr, i8* align 1 %lpf, i32 %unit_w, i1 false), !dbg !63
  br label %if.end10, !dbg !65

if.else:                                          ; preds = %entry
  br i1 %tobool, label %if.then8, label %if.end10, !dbg !66

if.then8:                                         ; preds = %if.else
  %arrayidx9 = getelementptr inbounds [4 x i8], [4 x i8]* %left, i32 0, i32 1, !dbg !68
  tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* align 1 %add.ptr, i8* nonnull align 1 %arrayidx9, i32 3, i1 false), !dbg !71
  br label %if.end10, !dbg !72

if.end10:                                         ; preds = %if.else, %if.then8, %if.then
  ret void, !dbg !73
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture writeonly, i8* nocapture readonly, i32, i1) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind
define hidden i32 @main(i32 %argc, i8** nocapture readnone %argv) local_unnamed_addr #0 !dbg !74 {
entry:
  %left = alloca [4 x i8], align 1
  call void @llvm.dbg.value(metadata i32 %argc, metadata !81, metadata !DIExpression()), !dbg !90
  call void @llvm.dbg.value(metadata i8** %argv, metadata !82, metadata !DIExpression()), !dbg !91
  %call1 = tail call i8* @malloc(i32 1024), !dbg !92
  call void @llvm.dbg.value(metadata i8* %call1, metadata !85, metadata !DIExpression()), !dbg !93
  %call2 = tail call i8* @malloc(i32 1024), !dbg !94
  call void @llvm.dbg.value(metadata i8* %call2, metadata !86, metadata !DIExpression()), !dbg !95
  %0 = getelementptr inbounds [4 x i8], [4 x i8]* %left, i32 0, i32 0, !dbg !96
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %0) #4, !dbg !96
  call void @llvm.dbg.declare(metadata [4 x i8]* %left, metadata !87, metadata !DIExpression()), !dbg !97
  call void @llvm.dbg.value(metadata i32 1, metadata !89, metadata !DIExpression()), !dbg !98
  call void @padding(i8* %call1, i8* undef, i32 undef, [4 x i8]* nonnull %left, i8* %call2, i32 undef, i32 64, i32 undef, i32 1), !dbg !99
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %0) #4, !dbg !100
  ret i32 0, !dbg !100
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i32) local_unnamed_addr #3

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 9.0.0 (https://github.com/llvm/llvm-project.git 9aefd7f55411e9f9d03891a199b42e2801705f43)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test.c", directory: "/home/brion/src/embind-tests/kerboom")
!2 = !{!3}
!3 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "LrEdgeFlags", file: !1, line: 12, baseType: !4, size: 32, elements: !5)
!4 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!5 = !{!6, !7, !8, !9}
!6 = !DIEnumerator(name: "LR_HAVE_LEFT", value: 1, isUnsigned: true)
!7 = !DIEnumerator(name: "LR_HAVE_RIGHT", value: 2, isUnsigned: true)
!8 = !DIEnumerator(name: "LR_HAVE_TOP", value: 4, isUnsigned: true)
!9 = !DIEnumerator(name: "LR_HAVE_BOTTOM", value: 8, isUnsigned: true)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git 9aefd7f55411e9f9d03891a199b42e2801705f43)"}
!14 = distinct !DISubprogram(name: "padding", scope: !1, file: !1, line: 25, type: !15, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !34)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17, !22, !24, !27, !22, !24, !31, !32, !33}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 32)
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "pixel", file: !1, line: 10, baseType: !19)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !20, line: 181, baseType: !21)
!20 = !DIFile(filename: "emsdk/upstream/3441/emscripten/system/include/libc/bits/alltypes.h", directory: "/home/brion/src")
!21 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 32)
!23 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !18)
!24 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !25)
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !20, line: 130, baseType: !26)
!26 = !DIBasicType(name: "long int", size: 32, encoding: DW_ATE_signed)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 32)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 32, elements: !29)
!29 = !{!30}
!30 = !DISubrange(count: 4)
!31 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!32 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !31)
!33 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !3)
!34 = !{!35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45}
!35 = !DILocalVariable(name: "dst", arg: 1, scope: !14, file: !1, line: 25, type: !17)
!36 = !DILocalVariable(name: "p", arg: 2, scope: !14, file: !1, line: 25, type: !22)
!37 = !DILocalVariable(name: "p_stride", arg: 3, scope: !14, file: !1, line: 25, type: !24)
!38 = !DILocalVariable(name: "left", arg: 4, scope: !14, file: !1, line: 26, type: !27)
!39 = !DILocalVariable(name: "lpf", arg: 5, scope: !14, file: !1, line: 27, type: !22)
!40 = !DILocalVariable(name: "lpf_stride", arg: 6, scope: !14, file: !1, line: 27, type: !24)
!41 = !DILocalVariable(name: "unit_w", arg: 7, scope: !14, file: !1, line: 28, type: !31)
!42 = !DILocalVariable(name: "stripe_h", arg: 8, scope: !14, file: !1, line: 28, type: !32)
!43 = !DILocalVariable(name: "edges", arg: 9, scope: !14, file: !1, line: 28, type: !33)
!44 = !DILocalVariable(name: "have_left", scope: !14, file: !1, line: 30, type: !32)
!45 = !DILocalVariable(name: "dst_l", scope: !14, file: !1, line: 33, type: !17)
!46 = !DILocation(line: 25, column: 21, scope: !14)
!47 = !DILocation(line: 25, column: 39, scope: !14)
!48 = !DILocation(line: 25, column: 58, scope: !14)
!49 = !DILocation(line: 26, column: 35, scope: !14)
!50 = !DILocation(line: 27, column: 34, scope: !14)
!51 = !DILocation(line: 27, column: 55, scope: !14)
!52 = !DILocation(line: 28, column: 25, scope: !14)
!53 = !DILocation(line: 28, column: 43, scope: !14)
!54 = !DILocation(line: 28, column: 76, scope: !14)
!55 = !DILocation(line: 30, column: 36, scope: !14)
!56 = !DILocation(line: 30, column: 28, scope: !14)
!57 = !DILocation(line: 33, column: 28, scope: !14)
!58 = !DILocation(line: 33, column: 24, scope: !14)
!59 = !DILocation(line: 33, column: 12, scope: !14)
!60 = !DILocation(line: 35, column: 15, scope: !61)
!61 = distinct !DILexicalBlock(scope: !14, file: !1, line: 35, column: 9)
!62 = !DILocation(line: 35, column: 9, scope: !14)
!63 = !DILocation(line: 36, column: 9, scope: !64)
!64 = distinct !DILexicalBlock(scope: !61, file: !1, line: 35, column: 30)
!65 = !DILocation(line: 37, column: 5, scope: !64)
!66 = !DILocation(line: 38, column: 13, scope: !67)
!67 = distinct !DILexicalBlock(scope: !61, file: !1, line: 37, column: 12)
!68 = !DILocation(line: 39, column: 32, scope: !69)
!69 = distinct !DILexicalBlock(scope: !70, file: !1, line: 38, column: 24)
!70 = distinct !DILexicalBlock(scope: !67, file: !1, line: 38, column: 13)
!71 = !DILocation(line: 39, column: 13, scope: !69)
!72 = !DILocation(line: 40, column: 9, scope: !69)
!73 = !DILocation(line: 42, column: 1, scope: !14)
!74 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 44, type: !75, scopeLine: 44, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !80)
!75 = !DISubroutineType(types: !76)
!76 = !{!31, !31, !77}
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 32)
!78 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !79, size: 32)
!79 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!80 = !{!81, !82, !83, !85, !86, !87, !89}
!81 = !DILocalVariable(name: "argc", arg: 1, scope: !74, file: !1, line: 44, type: !31)
!82 = !DILocalVariable(name: "argv", arg: 2, scope: !74, file: !1, line: 44, type: !77)
!83 = !DILocalVariable(name: "src", scope: !74, file: !1, line: 45, type: !84)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 32)
!85 = !DILocalVariable(name: "dst", scope: !74, file: !1, line: 46, type: !84)
!86 = !DILocalVariable(name: "lpf", scope: !74, file: !1, line: 47, type: !84)
!87 = !DILocalVariable(name: "left", scope: !74, file: !1, line: 48, type: !88)
!88 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 32, elements: !29)
!89 = !DILocalVariable(name: "edges", scope: !74, file: !1, line: 49, type: !3)
!90 = !DILocation(line: 44, column: 14, scope: !74)
!91 = !DILocation(line: 44, column: 27, scope: !74)
!92 = !DILocation(line: 46, column: 26, scope: !74)
!93 = !DILocation(line: 46, column: 20, scope: !74)
!94 = !DILocation(line: 47, column: 26, scope: !74)
!95 = !DILocation(line: 47, column: 20, scope: !74)
!96 = !DILocation(line: 48, column: 5, scope: !74)
!97 = !DILocation(line: 48, column: 11, scope: !74)
!98 = !DILocation(line: 49, column: 22, scope: !74)
!99 = !DILocation(line: 51, column: 5, scope: !74)
!100 = !DILocation(line: 55, column: 1, scope: !74)
