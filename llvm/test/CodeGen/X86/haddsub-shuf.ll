; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ssse3 | FileCheck %s --check-prefix=SSSE3
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX

; The next 8 tests check for matching the horizontal op and eliminating the shuffle.
; PR34111 - https://bugs.llvm.org/show_bug.cgi?id=34111

define <4 x float> @hadd_v4f32(<4 x float> %a) {
; SSSE3-LABEL: hadd_v4f32:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    haddps %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hadd_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a02 = shufflevector <4 x float> %a, <4 x float> undef, <2 x i32> <i32 0, i32 2>
  %a13 = shufflevector <4 x float> %a, <4 x float> undef, <2 x i32> <i32 1, i32 3>
  %hop = fadd <2 x float> %a02, %a13
  %shuf = shufflevector <2 x float> %hop, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  ret <4 x float> %shuf
}

define <4 x float> @hsub_v4f32(<4 x float> %a) {
; SSSE3-LABEL: hsub_v4f32:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    hsubps %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hsub_v4f32:
; AVX:       # %bb.0:
; AVX-NEXT:    vhsubps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a02 = shufflevector <4 x float> %a, <4 x float> undef, <2 x i32> <i32 0, i32 2>
  %a13 = shufflevector <4 x float> %a, <4 x float> undef, <2 x i32> <i32 1, i32 3>
  %hop = fsub <2 x float> %a02, %a13
  %shuf = shufflevector <2 x float> %hop, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  ret <4 x float> %shuf
}

define <2 x double> @hadd_v2f64(<2 x double> %a) {
; SSSE3-LABEL: hadd_v2f64:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    haddpd %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hadd_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vhaddpd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a0 = shufflevector <2 x double> %a, <2 x double> undef, <2 x i32> <i32 0, i32 undef>
  %a1 = shufflevector <2 x double> %a, <2 x double> undef, <2 x i32> <i32 1, i32 undef>
  %hop = fadd <2 x double> %a0, %a1
  %shuf = shufflevector <2 x double> %hop, <2 x double> undef, <2 x i32> <i32 0, i32 0>
  ret <2 x double> %shuf
}

define <2 x double> @hsub_v2f64(<2 x double> %a) {
; SSSE3-LABEL: hsub_v2f64:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    hsubpd %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hsub_v2f64:
; AVX:       # %bb.0:
; AVX-NEXT:    vhsubpd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a0 = shufflevector <2 x double> %a, <2 x double> undef, <2 x i32> <i32 0, i32 undef>
  %a1 = shufflevector <2 x double> %a, <2 x double> undef, <2 x i32> <i32 1, i32 undef>
  %hop = fsub <2 x double> %a0, %a1
  %shuf = shufflevector <2 x double> %hop, <2 x double> undef, <2 x i32> <i32 undef, i32 0>
  ret <2 x double> %shuf
}

define <4 x i32> @hadd_v4i32(<4 x i32> %a) {
; SSSE3-LABEL: hadd_v4i32:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    phaddd %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hadd_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vphaddd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a02 = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 undef, i32 undef>
  %a13 = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 1, i32 3, i32 undef, i32 undef>
  %hop = add <4 x i32> %a02, %a13
  %shuf = shufflevector <4 x i32> %hop, <4 x i32> undef, <4 x i32> <i32 0, i32 undef, i32 undef, i32 1>
  ret <4 x i32> %shuf
}

define <4 x i32> @hsub_v4i32(<4 x i32> %a) {
; SSSE3-LABEL: hsub_v4i32:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    phsubd %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hsub_v4i32:
; AVX:       # %bb.0:
; AVX-NEXT:    vphsubd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a02 = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 0, i32 2, i32 undef, i32 undef>
  %a13 = shufflevector <4 x i32> %a, <4 x i32> undef, <4 x i32> <i32 1, i32 3, i32 undef, i32 undef>
  %hop = sub <4 x i32> %a02, %a13
  %shuf = shufflevector <4 x i32> %hop, <4 x i32> undef, <4 x i32> <i32 undef, i32 1, i32 0, i32 undef>
  ret <4 x i32> %shuf
}

define <8 x i16> @hadd_v8i16(<8 x i16> %a) {
; SSSE3-LABEL: hadd_v8i16:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    phaddw %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hadd_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vphaddw %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a0246 = shufflevector <8 x i16> %a, <8 x i16> undef, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 undef, i32 undef, i32 undef, i32 undef>
  %a1357 = shufflevector <8 x i16> %a, <8 x i16> undef, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
  %hop = add <8 x i16> %a0246, %a1357
  %shuf = shufflevector <8 x i16> %hop, <8 x i16> undef, <8 x i32> <i32 undef, i32 undef, i32 undef, i32 undef, i32 0, i32 1, i32 2, i32 3>
  ret <8 x i16> %shuf
}

define <8 x i16> @hsub_v8i16(<8 x i16> %a) {
; SSSE3-LABEL: hsub_v8i16:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    phsubw %xmm0, %xmm0
; SSSE3-NEXT:    retq
;
; AVX-LABEL: hsub_v8i16:
; AVX:       # %bb.0:
; AVX-NEXT:    vphsubw %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a0246 = shufflevector <8 x i16> %a, <8 x i16> undef, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 undef, i32 undef, i32 undef, i32 undef>
  %a1357 = shufflevector <8 x i16> %a, <8 x i16> undef, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 undef, i32 undef, i32 undef, i32 undef>
  %hop = sub <8 x i16> %a0246, %a1357
  %shuf = shufflevector <8 x i16> %hop, <8 x i16> undef, <8 x i32> <i32 0, i32 undef, i32 2, i32 undef, i32 undef, i32 1, i32 undef, i32 3>
  ret <8 x i16> %shuf
}
