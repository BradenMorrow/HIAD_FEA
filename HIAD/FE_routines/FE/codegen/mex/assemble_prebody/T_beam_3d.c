/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * T_beam_3d.c
 *
 * Code generation for function 'T_beam_3d'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "T_beam_3d.h"

/* Function Definitions */
void T_beam_3d(const real_T nodes[6], const real_T orient[3], real_T T[144])
{
  real_T b_nodes[3];
  real_T y;
  real_T scale;
  int32_T k;
  real_T absxk;
  real_T t;
  real_T xp[3];
  real_T b_orient[3];
  real_T yp[3];
  real_T zp[3];
  real_T b_y;
  real_T c_y;
  real_T d_y;
  real_T e_y;
  real_T f_y;
  real_T g_y;
  real_T b_yp;
  static const int8_T iv10[3] = { 1, 0, 0 };

  static const int8_T iv11[3] = { 0, 1, 0 };

  static const int8_T iv12[3] = { 0, 0, 1 };

  real_T lambda[9];
  int32_T i7;

  /* T_BEAM_3D */
  /*    Generate the transformation matrix for a 3D beam element; */
  /*  Length of element */
  /*  Vector to orientation node */
  /*  Unit vectors */
  /*  Global */
  /*  Local */
  b_nodes[0] = nodes[1] - nodes[0];
  b_nodes[1] = nodes[3] - nodes[2];
  b_nodes[2] = nodes[5] - nodes[4];
  y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(b_nodes[k]);
    if (absxk > scale) {
      t = scale / absxk;
      y = 1.0 + y * t * t;
      scale = absxk;
    } else {
      t = absxk / scale;
      y += t * t;
    }

    xp[k] = b_nodes[k];
  }

  y = scale * muDoubleScalarSqrt(y);
  b_orient[0] = orient[0] - nodes[0];
  b_orient[1] = orient[1] - nodes[2];
  b_orient[2] = orient[2] - nodes[4];
  for (k = 0; k < 3; k++) {
    yp[k] = b_orient[k];
    xp[k] /= y;
  }

  zp[0] = xp[1] * yp[2] - xp[2] * yp[1];
  zp[1] = xp[2] * yp[0] - xp[0] * yp[2];
  zp[2] = xp[0] * yp[1] - xp[1] * yp[0];
  y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(zp[k]);
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
  for (k = 0; k < 3; k++) {
    zp[k] /= y;
  }

  yp[0] = zp[1] * xp[2] - zp[2] * xp[1];
  yp[1] = zp[2] * xp[0] - zp[0] * xp[2];
  yp[2] = zp[0] * xp[1] - zp[1] * xp[0];
  y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(yp[k]);
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

  /*  Direction cosines matrix */
  scale = 0.0;
  absxk = 0.0;
  t = 0.0;
  b_y = 0.0;
  c_y = 0.0;
  d_y = 0.0;
  e_y = 0.0;
  f_y = 0.0;
  g_y = 0.0;
  for (k = 0; k < 3; k++) {
    b_yp = yp[k] / y;
    scale += (real_T)iv10[k] * xp[k];
    absxk += (real_T)iv11[k] * xp[k];
    t += (real_T)iv12[k] * xp[k];
    b_y += (real_T)iv10[k] * b_yp;
    c_y += (real_T)iv11[k] * b_yp;
    d_y += (real_T)iv12[k] * b_yp;
    e_y += (real_T)iv10[k] * zp[k];
    f_y += (real_T)iv11[k] * zp[k];
    g_y += (real_T)iv12[k] * zp[k];
  }

  lambda[0] = scale;
  lambda[3] = absxk;
  lambda[6] = t;
  lambda[1] = b_y;
  lambda[4] = c_y;
  lambda[7] = d_y;
  lambda[2] = e_y;
  lambda[5] = f_y;
  lambda[8] = g_y;

  /*  Assemble transformation matrix */
  for (k = 0; k < 3; k++) {
    for (i7 = 0; i7 < 3; i7++) {
      T[i7 + 12 * k] = lambda[i7 + 3 * k];
      T[i7 + 12 * (k + 3)] = 0.0;
      T[i7 + 12 * (k + 6)] = 0.0;
      T[i7 + 12 * (k + 9)] = 0.0;
      T[(i7 + 12 * k) + 3] = 0.0;
      T[(i7 + 12 * (k + 3)) + 3] = lambda[i7 + 3 * k];
      T[(i7 + 12 * (k + 6)) + 3] = 0.0;
      T[(i7 + 12 * (k + 9)) + 3] = 0.0;
      T[(i7 + 12 * k) + 6] = 0.0;
      T[(i7 + 12 * (k + 3)) + 6] = 0.0;
      T[(i7 + 12 * (k + 6)) + 6] = lambda[i7 + 3 * k];
      T[(i7 + 12 * (k + 9)) + 6] = 0.0;
      T[(i7 + 12 * k) + 9] = 0.0;
      T[(i7 + 12 * (k + 3)) + 9] = 0.0;
      T[(i7 + 12 * (k + 6)) + 9] = 0.0;
      T[(i7 + 12 * (k + 9)) + 9] = lambda[i7 + 3 * k];
    }
  }
}

/* End of code generation (T_beam_3d.c) */
