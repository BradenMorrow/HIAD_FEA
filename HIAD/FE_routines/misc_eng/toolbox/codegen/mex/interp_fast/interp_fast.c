/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp_fast.c
 *
 * Code generation for function 'interp_fast'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp_fast.h"
#include "interp_fast_emxutil.h"
#include "interp1qr.h"
#include "interp_fast_data.h"

/* Function Definitions */
void interp_fast(const emxArray_real_T *pt, const emxArray_real_T *V_pt, real_T
                 LAMBDA, emxArray_real_T *F)
{
  real_T a;
  real_T B;
  int32_T loop_ub;
  int32_T i0;
  int32_T i;
  emxArray_real_T *b_pt;
  emxArray_real_T *b_V_pt;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  /*  Linear interpolation with extrapolation faster than interp1 */
  /*  For a 2 colum V_pt */
  if (pt->size[1] == 2) {
    a = LAMBDA - pt->data[0];
    B = pt->data[1] - pt->data[0];
    loop_ub = V_pt->size[0];
    i0 = F->size[0];
    F->size[0] = loop_ub;
    emxEnsureCapacity((emxArray__common *)F, i0, (int32_T)sizeof(real_T));
    for (i0 = 0; i0 < loop_ub; i0++) {
      F->data[i0] = V_pt->data[i0] + a * (V_pt->data[i0 + V_pt->size[0]] -
        V_pt->data[i0]) / B;
    }

    /* linear interpolation of F_pt for a 2 dimensional (two colum) F_pt */
  } else {
    /*  For a greater than 2 colum F_pt */
    i0 = F->size[0];
    F->size[0] = V_pt->size[0];
    emxEnsureCapacity((emxArray__common *)F, i0, (int32_T)sizeof(real_T));
    loop_ub = V_pt->size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      F->data[i0] = 0.0;
    }

    i = 0;
    emxInit_real_T(&b_pt, 1, true);
    emxInit_real_T(&b_V_pt, 1, true);
    while (i <= V_pt->size[0] - 1) {
      i0 = b_pt->size[0];
      b_pt->size[0] = pt->size[1];
      emxEnsureCapacity((emxArray__common *)b_pt, i0, (int32_T)sizeof(real_T));
      loop_ub = pt->size[1];
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_pt->data[i0] = pt->data[pt->size[0] * i0];
      }

      loop_ub = V_pt->size[1];
      i0 = b_V_pt->size[0];
      b_V_pt->size[0] = loop_ub;
      emxEnsureCapacity((emxArray__common *)b_V_pt, i0, (int32_T)sizeof(real_T));
      for (i0 = 0; i0 < loop_ub; i0++) {
        b_V_pt->data[i0] = V_pt->data[i + V_pt->size[0] * i0];
      }

      F->data[i] = interp1qr(b_pt, b_V_pt, LAMBDA);
      i++;
    }

    emxFree_real_T(&b_V_pt);
    emxFree_real_T(&b_pt);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp_fast.c) */
