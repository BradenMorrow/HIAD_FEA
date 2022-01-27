/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_PHI_quat.c
 *
 * Code generation for function 'get_PHI_quat'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_PHI_quat.h"

/* Function Definitions */
void get_PHI_quat(real_T qi[4], real_T PHI[3])
{
  int32_T k;
  real_T y;
  real_T scale;
  real_T absxk;
  real_T t;
  real_T b_y;

  /* GET_PHI_QUAT */
  /*  Get a rotational vector from a quaternion */
  /*  de Souza (2000), figure 3.3 */
  if (qi[0] < 0.0) {
    for (k = 0; k < 4; k++) {
      qi[k] = -qi[k];
    }
  }

  y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(qi[k + 1]);
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
  if (y == 0.0) {
    for (k = 0; k < 3; k++) {
      PHI[k] = 0.0;
    }
  } else {
    y = 0.0;
    scale = 2.2250738585072014E-308;
    for (k = 0; k < 3; k++) {
      absxk = muDoubleScalarAbs(qi[k + 1]);
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
    if (y < qi[0]) {
      y = 0.0;
      scale = 2.2250738585072014E-308;
      for (k = 0; k < 3; k++) {
        absxk = muDoubleScalarAbs(qi[k + 1]);
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
      b_y = 0.0;
      scale = 2.2250738585072014E-308;
      for (k = 0; k < 3; k++) {
        absxk = muDoubleScalarAbs(qi[k + 1]);
        if (absxk > scale) {
          t = scale / absxk;
          b_y = 1.0 + b_y * t * t;
          scale = absxk;
        } else {
          t = absxk / scale;
          b_y += t * t;
        }
      }

      b_y = scale * muDoubleScalarSqrt(b_y);
      scale = muDoubleScalarAsin(b_y);
      for (k = 0; k < 3; k++) {
        PHI[k] = 2.0 * qi[k + 1] / y * scale;
      }
    } else {
      y = 0.0;
      scale = 2.2250738585072014E-308;
      for (k = 0; k < 3; k++) {
        absxk = muDoubleScalarAbs(qi[k + 1]);
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
      scale = muDoubleScalarAcos(qi[0]);
      for (k = 0; k < 3; k++) {
        PHI[k] = 2.0 * qi[k + 1] / y * scale;
      }
    }
  }
}

/* End of code generation (get_PHI_quat.c) */
