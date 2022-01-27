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
#include "interp1qr.h"
#include "all.h"
#include "rdivide.h"
#include "interp1qr_emxutil.h"
#include "histc.h"
#include "interp1qr_data.h"

/* Function Definitions */
void interp1qr(const emxArray_real_T *x, const emxArray_real_T *y, const real_T
               xi_data[], const int32_T xi_size[1], real_T yi_data[], int32_T
               yi_size[1])
{
  emxArray_real_T *unusedU0;
  int32_T varargin_1_size[1];
  real_T varargin_1_data[20];
  real_T xi_pos_data[20];
  int32_T k;
  int32_T i;
  real_T b_xi_data[20];
  int32_T b_xi_size[1];
  real_T b_varargin_1_data[20];
  int32_T t_size[1];
  real_T t_data[20];
  real_T tmp_data[20];
  boolean_T c_xi_data[20];
  real_T b_x;
  int32_T c_xi_size[1];
  real_T delta_x;
  real_T delta_y;
  boolean_T extrap_val_data[20];
  int32_T b_tmp_data[20];
  int32_T trueCount;
  int32_T partialTrueCount;
  int32_T c_tmp_data[20];
  real_T b_y;
  int32_T d_xi_size[1];
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&unusedU0, 1, true);

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
  histc(xi_data, xi_size, x, unusedU0, varargin_1_data, varargin_1_size);
  k = 0;
  emxFree_real_T(&unusedU0);
  while (k + 1 <= (int8_T)varargin_1_size[0]) {
    xi_pos_data[k] = muDoubleScalarMax(varargin_1_data[k], 1.0);
    k++;
  }

  /*  To avoid index=0 when xi < x(1) */
  k = (int8_T)varargin_1_size[0];
  for (i = 0; i < k; i++) {
    varargin_1_data[i] = xi_pos_data[i];
  }

  for (k = 0; k + 1 <= (int8_T)varargin_1_size[0]; k++) {
    xi_pos_data[k] = muDoubleScalarMin(varargin_1_data[k], (real_T)x->size[0] -
      1.0);
  }

  /*  To avoid index=m+1 when xi > x(end). */
  /*  't' matrix [p x 1] */
  k = (int8_T)varargin_1_size[0];
  for (i = 0; i < k; i++) {
    varargin_1_data[i] = x->data[(int32_T)(xi_pos_data[i] + 1.0) - 1];
  }

  b_xi_size[0] = xi_size[0];
  k = xi_size[0];
  for (i = 0; i < k; i++) {
    b_xi_data[i] = xi_data[i] - x->data[(int32_T)xi_pos_data[i] - 1];
  }

  k = (int8_T)varargin_1_size[0];
  for (i = 0; i < k; i++) {
    b_varargin_1_data[i] = varargin_1_data[i] - x->data[(int32_T)xi_pos_data[i]
      - 1];
  }

  rdivide(b_xi_data, b_xi_size, b_varargin_1_data, t_data, t_size);

  /*  Get 'yi' */
  k = (int8_T)varargin_1_size[0];
  for (i = 0; i < k; i++) {
    varargin_1_data[i] = y->data[(int32_T)(xi_pos_data[i] + 1.0) - 1];
  }

  k = t_size[0];
  for (i = 0; i < k; i++) {
    tmp_data[i] = t_data[i] * (varargin_1_data[i] - y->data[(int32_T)
      xi_pos_data[i] - 1]);
  }

  yi_size[0] = (int8_T)varargin_1_size[0];
  k = (int8_T)varargin_1_size[0];
  for (i = 0; i < k; i++) {
    yi_data[i] = y->data[(int32_T)xi_pos_data[i] - 1] + tmp_data[i];
  }

  /*  Give extrapolate the values of 'yi' corresponding to 'xi' out of the range of 'x' */
  b_x = x->data[x->size[0] - 1];
  c_xi_size[0] = xi_size[0];
  k = xi_size[0];
  for (i = 0; i < k; i++) {
    c_xi_data[i] = (xi_data[i] > b_x);
  }

  if (all(c_xi_data, c_xi_size)) {
    delta_x = x->data[x->size[0] - 1] - x->data[x->size[0] - 2];
    delta_y = y->data[y->size[0] - 1] - y->data[y->size[0] - 2];
    b_x = x->data[x->size[0] - 1];
    k = xi_size[0];
    for (i = 0; i < k; i++) {
      extrap_val_data[i] = (xi_data[i] > b_x);
    }

    k = xi_size[0] - 1;
    trueCount = 0;
    for (i = 0; i <= k; i++) {
      if (extrap_val_data[i]) {
        trueCount++;
      }
    }

    partialTrueCount = 0;
    for (i = 0; i <= k; i++) {
      if (extrap_val_data[i]) {
        b_tmp_data[partialTrueCount] = i + 1;
        partialTrueCount++;
      }
    }

    k = xi_size[0] - 1;
    partialTrueCount = 0;
    for (i = 0; i <= k; i++) {
      if (extrap_val_data[i]) {
        c_tmp_data[partialTrueCount] = i + 1;
        partialTrueCount++;
      }
    }

    b_x = x->data[x->size[0] - 1];
    b_y = y->data[y->size[0] - 1];
    for (i = 0; i < trueCount; i++) {
      yi_data[c_tmp_data[i] - 1] = delta_y * (xi_data[b_tmp_data[i] - 1] - b_x) /
        delta_x + b_y;
    }
  }

  b_x = x->data[0];
  d_xi_size[0] = xi_size[0];
  k = xi_size[0];
  for (i = 0; i < k; i++) {
    c_xi_data[i] = (xi_data[i] < b_x);
  }

  if (all(c_xi_data, d_xi_size)) {
    delta_x = x->data[1] - x->data[0];
    delta_y = y->data[1] - y->data[0];
    b_x = x->data[0];
    k = xi_size[0];
    for (i = 0; i < k; i++) {
      extrap_val_data[i] = (xi_data[i] < b_x);
    }

    k = xi_size[0] - 1;
    trueCount = 0;
    for (i = 0; i <= k; i++) {
      if (extrap_val_data[i]) {
        trueCount++;
      }
    }

    partialTrueCount = 0;
    for (i = 0; i <= k; i++) {
      if (extrap_val_data[i]) {
        b_tmp_data[partialTrueCount] = i + 1;
        partialTrueCount++;
      }
    }

    k = xi_size[0] - 1;
    partialTrueCount = 0;
    for (i = 0; i <= k; i++) {
      if (extrap_val_data[i]) {
        c_tmp_data[partialTrueCount] = i + 1;
        partialTrueCount++;
      }
    }

    b_x = x->data[0];
    b_y = y->data[0];
    for (i = 0; i < trueCount; i++) {
      yi_data[c_tmp_data[i] - 1] = -delta_y * (b_x - xi_data[b_tmp_data[i] - 1])
        / delta_x + b_y;
    }
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp1qr.c) */
