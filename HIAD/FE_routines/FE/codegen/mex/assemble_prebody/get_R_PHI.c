/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_R_PHI.c
 *
 * Code generation for function 'get_R_PHI'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_R_PHI.h"

/* Function Definitions */
void get_R_PHI(const real_T PHI[3], real_T R[9])
{
  real_T phi;
  real_T scale;
  int32_T k;
  real_T absxk;
  real_T t;
  real_T S_PHI[9];
  real_T y;
  real_T xi[9];
  real_T b_PHI[9];
  int32_T iy;
  static const int8_T b[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  real_T t0_f1[9];
  int32_T ix;
  boolean_T bv0[9];
  int32_T i;
  boolean_T b0;
  int32_T ak;
  int32_T tmp_data[9];
  real_T len[3];
  int8_T ii_data[3];
  int32_T ii_size[2];
  static const int8_T iv0[2] = { 1, 3 };

  boolean_T exitg1;
  boolean_T guard1 = false;
  int8_T zeroColumns_data[3];
  int8_T b_tmp_data[3];
  boolean_T b_guard1 = false;

  /* GET_R_PHI */
  /*    Get rotation matrix from rotation vector */
  phi = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(PHI[k]);
    if (absxk > scale) {
      t = scale / absxk;
      phi = 1.0 + phi * t * t;
      scale = absxk;
    } else {
      t = absxk / scale;
      phi += t * t;
    }
  }

  phi = scale * muDoubleScalarSqrt(phi);

  /* GET_S */
  /*    Get the S matrix */
  memset(&S_PHI[0], 0, 9U * sizeof(real_T));

  /* replace zeros(3) with explicit definition to improve performance */
  S_PHI[1] = PHI[2];
  S_PHI[2] = -PHI[1];
  S_PHI[3] = -PHI[2];
  S_PHI[5] = PHI[0];
  S_PHI[6] = PHI[1];
  S_PHI[7] = -PHI[0];

  /*  S = [0 -w(3) w(2) */
  /*      w(3) 0 -w(1) */
  /*      -w(2) w(1) 0]; */
  y = 0.0;
  for (k = 0; k < 3; k++) {
    y += PHI[k] * PHI[k];
  }

  /*  % % w = 2*tan(phi/2)/phi*PHI; %[S_PHI(3,2) S_PHI(1,3) S_PHI(2,1)]'; */
  /*  % % S_w = get_S(w); */
  /*  % % S_w2 = w*w' - norm(w)*eye(3); */
  /*  % %  */
  /*  % % R = eye(3) + 1/(1 + (w'*w)/4)*(S_w + S_w2/2); % (3.36) */
  memset(&xi[0], 0, 9U * sizeof(real_T));
  absxk = muDoubleScalarSin(phi) / phi;
  scale = (1.0 - muDoubleScalarCos(phi)) / (phi * phi);

  /*  (3.21) */
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
  for (k = 0; k < 3; k++) {
    xi[k + 3 * k] = 1.0;
    for (iy = 0; iy < 3; iy++) {
      b_PHI[k + 3 * iy] = PHI[k] * PHI[iy] - y * (real_T)b[k + 3 * iy];
    }
  }

  for (iy = 0; iy < 3; iy++) {
    for (ix = 0; ix < 3; ix++) {
      t0_f1[ix + 3 * iy] = (xi[ix + 3 * iy] + absxk * S_PHI[ix + 3 * iy]) +
        scale * b_PHI[ix + 3 * iy];
    }
  }

  /* x = nntype.data('format',x,'Data'); */
  ix = 0;
  for (i = 0; i < 9; i++) {
    xi[i] = t0_f1[i];
    b0 = !((!muDoubleScalarIsInf(t0_f1[i])) && (!muDoubleScalarIsNaN(t0_f1[i])));
    if (b0) {
      ix++;
    }

    bv0[i] = b0;
  }

  ak = 0;
  for (i = 0; i < 9; i++) {
    if (bv0[i]) {
      tmp_data[ak] = i + 1;
      ak++;
    }
  }

  for (iy = 0; iy < ix; iy++) {
    xi[tmp_data[iy] - 1] = 0.0;
  }

  for (k = 0; k < 9; k++) {
    S_PHI[k] = xi[k] * xi[k];
  }

  ix = -1;
  iy = -1;
  for (i = 0; i < 3; i++) {
    ak = ix + 1;
    ix++;
    scale = S_PHI[ak];
    for (k = 0; k < 2; k++) {
      ix++;
      scale += S_PHI[ix];
    }

    iy++;
    len[iy] = scale;
  }

  for (k = 0; k < 3; k++) {
    len[k] = muDoubleScalarSqrt(len[k]);
  }

  ak = 0;
  ix = 0;
  for (iy = 0; iy <= 7; iy += 3) {
    for (k = 0; k < 3; k++) {
      R[iy + k] = xi[ak + k] / len[ix];
    }

    ak += 3;
    ix++;
  }

  ix = 0;
  for (iy = 0; iy < 2; iy++) {
    ii_size[iy] = iv0[iy];
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
        R[ix + 3 * b_tmp_data[iy]] = 0.57735026918962584;
      }
    }
  }

  /* improved performanc time ... does not do unecissary operations */
  y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(PHI[k]);
    if (absxk > scale) {
      t = scale / absxk;
      y = 1.0 + y * t * t;
      scale = absxk;
    } else {
      t = absxk / scale;
      y += t * t;
    }
  }

  y = scale * muDoubleScalarSqrt(y);
  b_guard1 = false;
  if (y == 0.0) {
    b_guard1 = true;
  } else {
    y = 0.0;
    scale = 2.2250738585072014E-308;
    for (k = 0; k < 3; k++) {
      absxk = muDoubleScalarAbs(PHI[k]);
      if (absxk > scale) {
        t = scale / absxk;
        y = 1.0 + y * t * t;
        scale = absxk;
      } else {
        t = absxk / scale;
        y += t * t;
      }
    }

    y = scale * muDoubleScalarSqrt(y);
    if (muDoubleScalarIsNaN(y)) {
      b_guard1 = true;
    }
  }

  if (b_guard1) {
    memset(&R[0], 0, 9U * sizeof(real_T));
    for (k = 0; k < 3; k++) {
      R[k + 3 * k] = 1.0;
    }
  }
}

/* End of code generation (get_R_PHI.c) */
