// We check that the Finalizer is run using FileCheck, and that the expected
// files are generated by deleting them (leaving things tidy)
// RUN: %cmc -Qxcm_jit_target=skl /Qxcm_asm_output=asm_output_slash %w 2>&1 | FileCheck %w
// RUN: rm %W.isa asm_output_slash_0.visaasm asm_output_slash_0.asm asm_output_slash_0.dat

#include <cm/cm.h>

_GENX_MAIN_
void test() {
}

#ifdef CM_GENX
#warning CM_GENX defined
#endif

#ifdef CM_GEN7_5
#warning CM_GEN7_5 defined
#endif

#ifdef CM_GEN8
#warning CM_GEN8 defined
#endif

#ifdef CM_GEN8_5
#warning CM_GEN8_5 defined
#endif

#ifdef CM_GEN9
#warning CM_GEN9 defined
#endif

#ifdef CM_GEN9_5
#warning CM_GEN9_5 defined
#endif

#ifdef CM_GEN10
#warning CM_GEN10 defined
#endif

// CHECK: cm_asm_output_slash.cpp(13,2):  warning: CM_GENX defined [-W#warnings]
// CHECK: cm_asm_output_slash.cpp(29,2):  warning: CM_GEN9 defined [-W#warnings]
// CHECK: 2 warnings generated.
// CHECK: -platform SKL
