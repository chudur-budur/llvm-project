; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i8 @zext_or_icmp_icmp(i8 %a, i8 %b) {
; CHECK-LABEL: @zext_or_icmp_icmp(
; CHECK-NEXT:    [[MASK:%.*]] = and i8 [[A:%.*]], 1
; CHECK-NEXT:    [[TOBOOL1:%.*]] = icmp eq i8 [[MASK]], 0
; CHECK-NEXT:    [[TOBOOL2:%.*]] = icmp eq i8 [[B:%.*]], 0
; CHECK-NEXT:    [[BOTHCOND:%.*]] = or i1 [[TOBOOL1]], [[TOBOOL2]]
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i1 [[BOTHCOND]] to i8
; CHECK-NEXT:    ret i8 [[ZEXT]]
;
  %mask = and i8 %a, 1
  %toBool1 = icmp eq i8 %mask, 0
  %toBool2 = icmp eq i8 %b, 0
  %bothCond = or i1 %toBool1, %toBool2
  %zext = zext i1 %bothCond to i8
  ret i8 %zext
}

define i8 @zext_or_icmp_icmp_logical(i8 %a, i8 %b) {
; CHECK-LABEL: @zext_or_icmp_icmp_logical(
; CHECK-NEXT:    [[MASK:%.*]] = and i8 [[A:%.*]], 1
; CHECK-NEXT:    [[TOBOOL1:%.*]] = icmp eq i8 [[MASK]], 0
; CHECK-NEXT:    [[TOBOOL2:%.*]] = icmp eq i8 [[B:%.*]], 0
; CHECK-NEXT:    [[BOTHCOND:%.*]] = select i1 [[TOBOOL1]], i1 true, i1 [[TOBOOL2]]
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i1 [[BOTHCOND]] to i8
; CHECK-NEXT:    ret i8 [[ZEXT]]
;
  %mask = and i8 %a, 1
  %toBool1 = icmp eq i8 %mask, 0
  %toBool2 = icmp eq i8 %b, 0
  %bothCond = select i1 %toBool1, i1 true, i1 %toBool2
  %zext = zext i1 %bothCond to i8
  ret i8 %zext
}

; Here, widening the or from i1 to i32 and removing one of the icmps would
; widen an undef value (created by the out-of-range shift), increasing the
; range of valid values for the return, so we can't do it.

define i32 @dont_widen_undef() {
; CHECK-LABEL: @dont_widen_undef(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BLOCK2:%.*]]
; CHECK:       block1:
; CHECK-NEXT:    br label [[BLOCK2]]
; CHECK:       block2:
; CHECK-NEXT:    ret i32 1
;
entry:
  br label %block2

block1:
  br label %block2

block2:
  %m.011 = phi i32 [ 33, %entry ], [ 0, %block1 ]
  %cmp.i = icmp ugt i32 %m.011, 1
  %m.1.op = lshr i32 1, %m.011
  %sext.mask = and i32 %m.1.op, 65535
  %cmp115 = icmp ne i32 %sext.mask, 0
  %cmp1 = or i1 %cmp.i, %cmp115
  %conv2 = zext i1 %cmp1 to i32
  ret i32 %conv2
}

define i32 @dont_widen_undef_logical() {
; CHECK-LABEL: @dont_widen_undef_logical(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BLOCK2:%.*]]
; CHECK:       block1:
; CHECK-NEXT:    br label [[BLOCK2]]
; CHECK:       block2:
; CHECK-NEXT:    ret i32 1
;
entry:
  br label %block2

block1:
  br label %block2

block2:
  %m.011 = phi i32 [ 33, %entry ], [ 0, %block1 ]
  %cmp.i = icmp ugt i32 %m.011, 1
  %m.1.op = lshr i32 1, %m.011
  %sext.mask = and i32 %m.1.op, 65535
  %cmp115 = icmp ne i32 %sext.mask, 0
  %cmp1 = select i1 %cmp.i, i1 true, i1 %cmp115
  %conv2 = zext i1 %cmp1 to i32
  ret i32 %conv2
}

; A limitation of knownbits with overshift prevents reducing to 'false'.

define i1 @knownbits_out_of_range_shift(i32 %x) {
; CHECK-LABEL: @knownbits_out_of_range_shift(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BLOCK2:%.*]]
; CHECK:       block1:
; CHECK-NEXT:    br label [[BLOCK2]]
; CHECK:       block2:
; CHECK-NEXT:    ret i1 false
;
entry:
  br label %block2

block1:
  br label %block2

block2:
  %p = phi i32 [ 63, %entry ], [ 31, %block1 ]
  %l = lshr i32 %x, %p
  %r = icmp eq i32 %l, 2
  ret i1 %r
}

; PR43261

define i32 @zext_or_eq_ult_add(i32 %i) {
; CHECK-LABEL: @zext_or_eq_ult_add(
; CHECK-NEXT:    [[A:%.*]] = add i32 [[I:%.*]], -3
; CHECK-NEXT:    [[C1:%.*]] = icmp ult i32 [[A]], 3
; CHECK-NEXT:    [[R:%.*]] = zext i1 [[C1]] to i32
; CHECK-NEXT:    ret i32 [[R]]
;
  %a = add i32 %i, -3
  %c1 = icmp ult i32 %a, 3
  %c2 = icmp eq i32 %i, 5
  %o = or i1 %c1, %c2
  %r = zext i1 %o to i32
  ret i32 %r
}

define i32 @select_zext_or_eq_ult_add(i32 %i) {
; CHECK-LABEL: @select_zext_or_eq_ult_add(
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[I:%.*]], -3
; CHECK-NEXT:    [[NARROW:%.*]] = icmp ult i32 [[TMP1]], 3
; CHECK-NEXT:    [[R:%.*]] = zext i1 [[NARROW]] to i32
; CHECK-NEXT:    ret i32 [[R]]
;
  %a = add i32 %i, -3
  %c1 = icmp ult i32 %a, 2
  %c2 = icmp eq i32 %i, 5
  %z = zext i1 %c2 to i32
  %r = select i1 %c1, i32 1, i32 %z
  ret i32 %r
}

; This should not end with more instructions than it started from.

define i32 @PR49475(i32 %x, i16 %y) {
; CHECK-LABEL: @PR49475(
; CHECK-NEXT:    [[M:%.*]] = and i16 [[Y:%.*]], 1
; CHECK-NEXT:    [[B1:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK-NEXT:    [[B2:%.*]] = icmp eq i16 [[M]], 0
; CHECK-NEXT:    [[T1:%.*]] = or i1 [[B1]], [[B2]]
; CHECK-NEXT:    [[Z:%.*]] = zext i1 [[T1]] to i32
; CHECK-NEXT:    ret i32 [[Z]]
;
  %m = and i16 %y, 1
  %b1 = icmp eq i32 %x, 0
  %b2 = icmp eq i16 %m, 0
  %t1 = or i1 %b1, %b2
  %z = zext i1 %t1 to i32
  ret i32 %z
}

; This would infinite-loop.

define i8 @PR49475_infloop(i32 %t0, i16 %insert, i64 %e, i8 %i162) "instcombine-no-verify-fixpoint" {
; CHECK-LABEL: @PR49475_infloop(
; CHECK-NEXT:    [[B2:%.*]] = icmp eq i16 [[INSERT:%.*]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = and i32 [[T0:%.*]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = or disjoint i32 [[TMP1]], 140
; CHECK-NEXT:    [[TMP3:%.*]] = zext nneg i32 [[TMP2]] to i64
; CHECK-NEXT:    [[XOR:%.*]] = select i1 [[B2]], i64 [[TMP3]], i64 140
; CHECK-NEXT:    [[CONV16:%.*]] = sext i8 [[I162:%.*]] to i64
; CHECK-NEXT:    [[SUB17:%.*]] = sub i64 [[CONV16]], [[E:%.*]]
; CHECK-NEXT:    [[SEXT:%.*]] = shl i64 [[SUB17]], 32
; CHECK-NEXT:    [[CONV18:%.*]] = ashr exact i64 [[SEXT]], 32
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i64 [[XOR]], [[CONV18]]
; CHECK-NEXT:    [[TRUNC44:%.*]] = zext i1 [[CMP]] to i8
; CHECK-NEXT:    [[INC:%.*]] = add i8 [[I162]], [[TRUNC44]]
; CHECK-NEXT:    [[TOBOOL23_NOT:%.*]] = xor i1 [[CMP]], true
; CHECK-NEXT:    call void @llvm.assume(i1 [[TOBOOL23_NOT]])
; CHECK-NEXT:    ret i8 [[INC]]
;
  %b = icmp eq i32 %t0, 0
  %b2 = icmp eq i16 %insert, 0
  %t1 = or i1 %b, %b2
  %ext = zext i1 %t1 to i32
  %and = and i32 %t0, %ext
  %conv13 = zext i32 %and to i64
  %xor = xor i64 %conv13, 140
  %conv16 = sext i8 %i162 to i64
  %sub17 = sub i64 %conv16, %e
  %sext = shl i64 %sub17, 32
  %conv18 = ashr exact i64 %sext, 32
  %cmp = icmp sge i64 %xor, %conv18
  %conv19 = zext i1 %cmp to i16
  %or21 = or i16 %insert, %conv19
  %trunc44 = trunc i16 %or21 to i8
  %inc = add i8 %i162, %trunc44
  %tobool23.not = icmp eq i16 %or21, 0
  call void @llvm.assume(i1 %tobool23.not)
  ret i8 %inc
}

; This would infinite loop because knownbits changed between checking
; if a transform was profitable and actually doing the transform.

define i1 @PR51762(ptr %i, i32 %t0, i16 %t1, ptr %p, ptr %d, ptr %f, i32 %p2, i1 %c1) {
; CHECK-LABEL: @PR51762(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_COND:%.*]]
; CHECK:       for.cond:
; CHECK-NEXT:    [[I_SROA_8_0:%.*]] = phi i32 [ poison, [[ENTRY:%.*]] ], [ [[I_SROA_8_0_EXTRACT_TRUNC:%.*]], [[COND_TRUE:%.*]] ]
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[COND_TRUE]], label [[FOR_END11:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[I_SROA_8_0_EXTRACT_TRUNC]] = ashr i32 [[T0:%.*]], 31
; CHECK-NEXT:    br label [[FOR_COND]]
; CHECK:       for.end11:
; CHECK-NEXT:    [[S1:%.*]] = sext i16 [[T1:%.*]] to i64
; CHECK-NEXT:    [[SROA38:%.*]] = load i32, ptr [[I:%.*]], align 8
; CHECK-NEXT:    [[INSERT_EXT51:%.*]] = zext i32 [[I_SROA_8_0]] to i64
; CHECK-NEXT:    [[INSERT_SHIFT52:%.*]] = shl nuw i64 [[INSERT_EXT51]], 32
; CHECK-NEXT:    [[INSERT_EXT39:%.*]] = zext i32 [[SROA38]] to i64
; CHECK-NEXT:    [[INSERT_INSERT41:%.*]] = or disjoint i64 [[INSERT_SHIFT52]], [[INSERT_EXT39]]
; CHECK-NEXT:    [[REM:%.*]] = urem i64 [[S1]], [[INSERT_INSERT41]]
; CHECK-NEXT:    [[NE:%.*]] = icmp ne i64 [[REM]], 0
; CHECK-NEXT:    [[LOR_EXT:%.*]] = zext i1 [[NE]] to i32
; CHECK-NEXT:    [[T2:%.*]] = load i32, ptr [[D:%.*]], align 4
; CHECK-NEXT:    [[CONV15:%.*]] = sext i16 [[T1]] to i32
; CHECK-NEXT:    [[CMP16:%.*]] = icmp sge i32 [[T2]], [[CONV15]]
; CHECK-NEXT:    [[CONV17:%.*]] = zext i1 [[CMP16]] to i32
; CHECK-NEXT:    [[T3:%.*]] = load i32, ptr [[F:%.*]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[T3]], [[CONV17]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[F]], align 4
; CHECK-NEXT:    [[REM18:%.*]] = srem i32 [[LOR_EXT]], [[ADD]]
; CHECK-NEXT:    [[CONV19:%.*]] = zext nneg i32 [[REM18]] to i64
; CHECK-NEXT:    store i32 [[SROA38]], ptr [[D]], align 8
; CHECK-NEXT:    [[R:%.*]] = icmp ult i64 [[INSERT_INSERT41]], [[CONV19]]
; CHECK-NEXT:    call void @llvm.assume(i1 [[R]])
; CHECK-NEXT:    ret i1 [[R]]
;
entry:
  br label %for.cond

for.cond:
  %i.sroa.8.0 = phi i32 [ poison, %entry ], [ %i.sroa.8.0.extract.trunc, %cond.true ]
  br i1 %c1, label %cond.true, label %for.end11

cond.true:
  %i.sroa.8.0.extract.trunc = ashr i32 %t0, 31
  br label %for.cond

for.end11:
  %s1 = sext i16 %t1 to i64
  %sroa38 = load i32, ptr %i, align 8
  %insert.ext51 = zext i32 %i.sroa.8.0 to i64
  %insert.shift52 = shl nuw i64 %insert.ext51, 32
  %insert.ext39 = zext i32 %sroa38 to i64
  %insert.insert41 = or i64 %insert.shift52, %insert.ext39
  %rem = urem i64 %s1, %insert.insert41
  %ne = icmp ne i64 %rem, 0
  %cmp = icmp eq i64 %insert.insert41, 0
  %spec.select57 = or i1 %ne, %cmp

  %lor.ext = zext i1 %spec.select57 to i32
  %t2 = load i32, ptr %d, align 4
  %conv15 = sext i16 %t1 to i32
  %cmp16 = icmp sge i32 %t2, %conv15
  %conv17 = zext i1 %cmp16 to i32
  %t3 = load i32, ptr %f, align 4
  %add = add nsw i32 %t3, %conv17
  store i32 %add, ptr %f, align 4
  %rem18 = srem i32 %lor.ext, %add
  %conv19 = zext i32 %rem18 to i64
  %div = udiv i64 %insert.insert41, %conv19
  %trunc33 = trunc i64 %div to i32
  store i32 %trunc33, ptr %d, align 8
  %r = icmp ult i64 %insert.insert41, %conv19
  call void @llvm.assume(i1 %r)
  ret i1 %r
}

declare void @llvm.assume(i1 noundef)
