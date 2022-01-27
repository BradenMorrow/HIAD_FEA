/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_quat_R.c
 *
 * Code generation for function 'get_quat_R'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_quat_R.h"

/* Function Definitions */
void get_quat_R(const real_T R[9], real_T qi[4])
{
  real_T mtmp;
  int32_T ixstart;
  real_T varargin_1[4];
  int32_T itmp;
  int32_T ix;
  boolean_T exitg1;
  real_T t;
  real_T q0;
  real_T q1;
  real_T q2;
  real_T q3;

  /* GET_QUAT_R */
  /*    Get unit quaternions from a rotation matrix */
  mtmp = 0.0;
  for (ixstart = 0; ixstart < 3; ixstart++) {
    mtmp += R[ixstart + 3 * ixstart];
  }

  varargin_1[0] = mtmp;
  varargin_1[1] = R[0];
  varargin_1[2] = R[4];
  varargin_1[3] = R[8];
  ixstart = 1;
  itmp = 0;
  if (muDoubleScalarIsNaN(mtmp)) {
    ix = 1;
    exitg1 = false;
    while ((!exitg1) && (ix + 1 < 5)) {
      ixstart = ix + 1;
      if (!muDoubleScalarIsNaN(varargin_1[ix])) {
        mtmp = varargin_1[ix];
        itmp = ix;
        exitg1 = true;
      } else {
        ix++;
      }
    }
  }

  if (ixstart < 4) {
    while (ixstart + 1 < 5) {
      if (varargin_1[ixstart] > mtmp) {
        mtmp = varargin_1[ixstart];
        itmp = ixstart;
      }

      ixstart++;
    }
  }

  t = 0.0;
  for (ixstart = 0; ixstart < 3; ixstart++) {
    t += R[ixstart + 3 * ixstart];
  }

  if (mtmp == t) {
    q0 = 0.5 * muDoubleScalarSqrt(mtmp + 1.0);
    q1 = 1.0 / (4.0 * q0) * (R[5] - R[7]);
    q2 = 1.0 / (4.0 * q0) * (R[6] - R[2]);
    q3 = 1.0 / (4.0 * q0) * (R[1] - R[3]);
  } else if (itmp == 1) {
    t = 0.0;
    for (ixstart = 0; ixstart < 3; ixstart++) {
      t += R[ixstart + 3 * ixstart];
    }

    q1 = muDoubleScalarSqrt(mtmp / 2.0 + (1.0 - t) / 4.0);
    q0 = (R[5] - R[7]) / (4.0 * q1);
    q2 = (R[1] + R[3]) / (4.0 * q1);
    q3 = (R[2] + R[6]) / (4.0 * q1);
  } else if (itmp == 2) {
    t = 0.0;
    for (ixstart = 0; ixstart < 3; ixstart++) {
      t += R[ixstart + 3 * ixstart];
    }

    q2 = muDoubleScalarSqrt(mtmp / 2.0 + (1.0 - t) / 4.0);
    q0 = (R[6] - R[2]) / (4.0 * q2);
    q1 = (R[3] + R[1]) / (4.0 * q2);
    q3 = (R[5] + R[7]) / (4.0 * q2);
  } else {
    t = 0.0;
    for (ixstart = 0; ixstart < 3; ixstart++) {
      t += R[ixstart + 3 * ixstart];
    }

    q3 = muDoubleScalarSqrt(mtmp / 2.0 + (1.0 - t) / 4.0);
    q0 = (R[6] - R[2]) / (4.0 * q3);
    q1 = (R[6] + R[2]) / (4.0 * q3);
    q2 = (R[7] + R[5]) / (4.0 * q3);
  }

  qi[0] = q0;
  qi[1] = q1;
  qi[2] = q2;
  qi[3] = q3;
}

/* End of code generation (get_quat_R.c) */
