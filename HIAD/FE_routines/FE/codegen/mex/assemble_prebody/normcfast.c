/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * normcfast.c
 *
 * Code generation for function 'normcfast'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "normcfast.h"

/* Function Definitions */
void normcfast(const real_T x[9], real_T y_out[9])
{
  int32_T ix;
  real_T xi[9];
  boolean_T bv1[9];
  int32_T i;
  boolean_T b1;
  int32_T ak;
  int32_T tmp_data[9];
  int32_T iy;
  real_T y[9];
  int32_T k;
  real_T len[3];
  real_T s;
  int8_T ii_data[3];
  int32_T ii_size[2];
  static const int8_T iv1[2] = { 1, 3 };

  boolean_T exitg1;
  boolean_T guard1 = false;
  int8_T zeroColumns_data[3];
  int8_T b_tmp_data[3];

  /* NORMC Normalize columns of matrices. */
  /*  */
  /*   <a href="matlab:doc normc">normc</a>(X) takes a single matrix or cell array of matrices and returns */
  /*   the matrices with columns normalized to a length of one. */
  /*  */
  /*   Here the columns of a random matrix are normalized. */
  /*  */
  /*     x = <a href="matlab:doc rands">rands</a>(4,8); */
  /*     y = <a href="matlab:doc normc">normc</a>(x) */
  /*  */
  /*   See also NORMR. */
  /*  Copyright 1992-2015 The MathWorks, Inc. */
  /* make change here */
  /* x = nntype.data('format',x,'Data'); */
  ix = 0;
  for (i = 0; i < 9; i++) {
    xi[i] = x[i];
    b1 = !((!muDoubleScalarIsInf(x[i])) && (!muDoubleScalarIsNaN(x[i])));
    if (b1) {
      ix++;
    }

    bv1[i] = b1;
  }

  ak = 0;
  for (i = 0; i < 9; i++) {
    if (bv1[i]) {
      tmp_data[ak] = i + 1;
      ak++;
    }
  }

  for (iy = 0; iy < ix; iy++) {
    xi[tmp_data[iy] - 1] = 0.0;
  }

  for (k = 0; k < 9; k++) {
    y[k] = xi[k] * xi[k];
  }

  ix = -1;
  iy = -1;
  for (i = 0; i < 3; i++) {
    ak = ix + 1;
    ix++;
    s = y[ak];
    for (k = 0; k < 2; k++) {
      ix++;
      s += y[ix];
    }

    iy++;
    len[iy] = s;
  }

  for (k = 0; k < 3; k++) {
    len[k] = muDoubleScalarSqrt(len[k]);
  }

  ak = 0;
  ix = 0;
  for (iy = 0; iy <= 7; iy += 3) {
    for (k = 0; k < 3; k++) {
      y_out[iy + k] = xi[ak + k] / len[ix];
    }

    ak += 3;
    ix++;
  }

  ix = 0;
  for (iy = 0; iy < 2; iy++) {
    ii_size[iy] = iv1[iy];
  }

  ak = 1;
  exitg1 = false;
  while ((!exitg1) && (ak < 4)) {
    guard1 = false;
    if (len[ak - 1] == 0.0) {
      ix++;
      ii_data[ix - 1] = (int8_T)ak;
      if (ix >= 3) {
        exitg1 = true;
      } else {
        guard1 = true;
      }
    } else {
      guard1 = true;
    }

    if (guard1) {
      ak++;
    }
  }

  if (1 > ix) {
    iy = 0;
  } else {
    iy = ix;
  }

  if (1 > ix) {
    ii_size[1] = 0;
  } else {
    ii_size[1] = ix;
  }

  ak = ii_size[0] * iy;
  for (ix = 0; ix < ak; ix++) {
    zeroColumns_data[ix] = ii_data[ix];
  }

  if (!(ii_size[1] == 0)) {
    ak = ii_size[1];
    for (ix = 0; ix < ak; ix++) {
      b_tmp_data[ix] = (int8_T)(zeroColumns_data[ix] - 1);
    }

    ak = (int8_T)iy;
    for (iy = 0; iy < ak; iy++) {
      for (ix = 0; ix < 3; ix++) {
        y_out[ix + 3 * b_tmp_data[iy]] = 0.57735026918962584;
      }
    }
  }
}

/* End of code generation (normcfast.c) */
