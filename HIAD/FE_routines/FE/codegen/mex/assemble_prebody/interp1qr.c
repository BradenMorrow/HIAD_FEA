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
#include "assemble_prebody.h"
#include "interp1qr.h"
#include "interp1.h"
#include "assemble_prebody_mexutil.h"

/* Function Definitions */
void interp1qr(const real_T x_data[], const int32_T x_size[1], const real_T
               y_data[], const int32_T y_size[1], const real_T xi[2], real_T yi
               [2])
{
  int32_T dx[2];
  int32_T xind;
  int32_T k;
  int32_T low_i;
  int32_T low_ip1;
  int32_T high_i;
  int32_T mid_i;
  boolean_T extrap_val[2];
  int32_T xi_pos;
  boolean_T y;
  boolean_T exitg2;
  real_T delta_x;
  real_T delta_y;
  int32_T tmp_data[2];
  boolean_T b_extrap_val;
  int32_T b_tmp_data[2];
  boolean_T exitg1;
  real_T a;

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
  for (xind = 0; xind < 2; xind++) {
    dx[xind] = 0;
  }

  xind = 0;
  for (k = 0; k < 2; k++) {
    low_i = 0;
    if ((!(x_size[0] == 0)) && (!muDoubleScalarIsNaN(xi[xind]))) {
      if ((xi[xind] >= x_data[0]) && (xi[xind] < x_data[x_size[0] - 1])) {
        low_i = 1;
        low_ip1 = 2;
        high_i = x_size[0];
        while (high_i > low_ip1) {
          mid_i = asr_s32(low_i, 1U) + asr_s32(high_i, 1U);
          if (((low_i & 1) == 1) && ((high_i & 1) == 1)) {
            mid_i++;
          }

          if (xi[xind] >= x_data[mid_i - 1]) {
            low_i = mid_i;
            low_ip1 = mid_i + 1;
          } else {
            high_i = mid_i;
          }
        }
      }

      if (xi[xind] == x_data[x_size[0] - 1]) {
        low_i = x_size[0];
      }
    }

    dx[xind] = low_i;
    xind++;
  }

  /*  To avoid index=0 when xi < x(1) */
  for (k = 0; k < 2; k++) {
    dx[k] = (int32_T)muDoubleScalarMax(dx[k], 1.0);
  }

  /*  To avoid index=m+1 when xi > x(end). */
  /*  't' matrix [p x 1] */
  /*  Get 'yi' */
  /*  Give extrapolate the values of 'yi' corresponding to 'xi' out of the range of 'x' */
  for (k = 0; k < 2; k++) {
    xi_pos = (int32_T)muDoubleScalarMin(dx[k], (real_T)x_size[0] - 1.0);
    yi[k] = y_data[xi_pos - 1] + (xi[k] - x_data[xi_pos - 1]) / (x_data[xi_pos]
      - x_data[xi_pos - 1]) * (y_data[xi_pos] - y_data[xi_pos - 1]);
    extrap_val[k] = (xi[k] > x_data[x_size[0] - 1]);
  }

  y = true;
  k = 0;
  exitg2 = false;
  while ((!exitg2) && (k < 2)) {
    if (!extrap_val[k]) {
      y = false;
      exitg2 = true;
    } else {
      k++;
    }
  }

  if (y) {
    delta_x = x_data[x_size[0] - 1] - x_data[x_size[0] - 2];
    delta_y = y_data[y_size[0] - 1] - y_data[y_size[0] - 2];
    high_i = 0;
    for (xind = 0; xind < 2; xind++) {
      b_extrap_val = (xi[xind] > x_data[x_size[0] - 1]);
      if (b_extrap_val) {
        high_i++;
      }

      extrap_val[xind] = b_extrap_val;
    }

    low_i = 0;
    low_ip1 = 0;
    for (xind = 0; xind < 2; xind++) {
      if (extrap_val[xind]) {
        tmp_data[low_i] = xind + 1;
        low_i++;
      }

      if (extrap_val[xind]) {
        b_tmp_data[low_ip1] = xind + 1;
        low_ip1++;
      }
    }

    for (xind = 0; xind < high_i; xind++) {
      yi[b_tmp_data[xind] - 1] = delta_y * (xi[tmp_data[xind] - 1] -
        x_data[x_size[0] - 1]) / delta_x + y_data[y_size[0] - 1];
    }
  }

  for (xind = 0; xind < 2; xind++) {
    extrap_val[xind] = (xi[xind] < x_data[0]);
  }

  y = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 2)) {
    if (!extrap_val[k]) {
      y = false;
      exitg1 = true;
    } else {
      k++;
    }
  }

  if (y) {
    delta_x = x_data[1] - x_data[0];
    high_i = 0;
    for (xind = 0; xind < 2; xind++) {
      b_extrap_val = (xi[xind] < x_data[0]);
      if (b_extrap_val) {
        high_i++;
      }

      extrap_val[xind] = b_extrap_val;
    }

    low_i = 0;
    a = -(y_data[1] - y_data[0]);
    low_ip1 = 0;
    for (xind = 0; xind < 2; xind++) {
      if (extrap_val[xind]) {
        tmp_data[low_i] = xind + 1;
        low_i++;
      }

      if (extrap_val[xind]) {
        b_tmp_data[low_ip1] = xind + 1;
        low_ip1++;
      }
    }

    for (xind = 0; xind < high_i; xind++) {
      yi[b_tmp_data[xind] - 1] = a * (x_data[0] - xi[tmp_data[xind] - 1]) /
        delta_x + y_data[0];
    }
  }
}

/* End of code generation (interp1qr.c) */
