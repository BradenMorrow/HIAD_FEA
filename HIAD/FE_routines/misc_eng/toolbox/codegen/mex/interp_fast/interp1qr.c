/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1qr.c
 *
 * Code generation for function 'interp1qr'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp_fast.h"
#include "interp1qr.h"
#include "interp_fast_emxutil.h"
#include "rdivide.h"
#include "histc.h"
#include "interp_fast_data.h"

/* Function Definitions */
real_T interp1qr(const emxArray_real_T *x, const emxArray_real_T *y, real_T xi)
{
  real_T yi;
  emxArray_real_T *unusedU0;
  real_T varargin_1;
  real_T xi_pos;
  real_T delta_x;
  real_T delta_y;
  boolean_T extrap_val;
  int32_T trueCount;
  real_T dv0[1];
  int32_T b_trueCount;
  int32_T i;
  real_T b_y;
  real_T delta_y_data[1];
  real_T dv1[1];
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T1(&unusedU0, 2, true);

  /* Quicker 1D linear interpolation with extrapolation in the positive x */
  /* direction */
  /*  Performs 1D linear interpolation of 'xi' points using 'x' and 'y', resulting */
  /*  in 'yi' following the formula yi = y1 + y1 (y2-y1)/(x2-x1)*xi-x1). */
  /*  Returns NaN when 'xi' is Nan. */
  /*  'x'  is column vector [m x 1], monotonically increasing. */
  /*  'y'  is matrix [m x n], corresponding to 'x'. */
  /*  'xi' is column vector [p x 1], in any order. */
  /*  'yi' is matrix [p x n], corresponding to 'xi'. */
  /*  Size of 'x' and 'y' */
  /*  For each 'xi', get the position of the 'x' element bounding it on the left [p x 1] */
  histc(xi, x, unusedU0, &varargin_1);

  /*  To avoid index=0 when xi < x(1) */
  xi_pos = muDoubleScalarMin(muDoubleScalarMax(varargin_1, 1.0), (real_T)x->
    size[0] - 1.0);

  /*  To avoid index=m+1 when xi > x(end). */
  /*  't' matrix [p x 1] */
  /*  Get 'yi' */
  yi = y->data[(int32_T)xi_pos - 1] + rdivide(xi - x->data[(int32_T)xi_pos - 1],
    x->data[(int32_T)xi_pos] - x->data[(int32_T)xi_pos - 1]) * (y->data[(int32_T)
    xi_pos] - y->data[(int32_T)xi_pos - 1]);

  /*  Give extrapolate the values of 'yi' corresponding to 'xi' out of the range of 'x' */
  emxFree_real_T(&unusedU0);
  if (xi > x->data[x->size[0] - 1]) {
    delta_x = x->data[x->size[0] - 1] - x->data[x->size[0] - 2];
    delta_y = y->data[y->size[0] - 1] - y->data[y->size[0] - 2];
    extrap_val = (xi > x->data[x->size[0] - 1]);
    trueCount = 0;
    dv0[0] = yi;
    b_trueCount = 0;
    for (i = 0; i < 1; i++) {
      if (extrap_val) {
        trueCount++;
      }

      if (extrap_val) {
        b_trueCount++;
      }
    }

    varargin_1 = x->data[x->size[0] - 1];
    b_y = y->data[y->size[0] - 1];
    for (i = 0; i < trueCount; i++) {
      delta_y_data[i] = delta_y * (xi - varargin_1) / delta_x + b_y;
    }

    for (i = 0; i < b_trueCount; i++) {
      dv0[0] = delta_y_data[i];
    }

    yi = dv0[0];
  }

  if (xi < x->data[0]) {
    delta_x = x->data[1] - x->data[0];
    delta_y = y->data[1] - y->data[0];
    extrap_val = (xi < x->data[0]);
    trueCount = 0;
    dv1[0] = yi;
    b_trueCount = 0;
    for (i = 0; i < 1; i++) {
      if (extrap_val) {
        trueCount++;
      }

      if (extrap_val) {
        b_trueCount++;
      }
    }

    varargin_1 = x->data[0];
    b_y = y->data[0];
    for (i = 0; i < trueCount; i++) {
      delta_y_data[i] = -delta_y * (varargin_1 - xi) / delta_x + b_y;
    }

    for (i = 0; i < b_trueCount; i++) {
      dv1[0] = delta_y_data[i];
    }

    yi = dv1[0];
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return yi;
}

/* End of code generation (interp1qr.c) */
