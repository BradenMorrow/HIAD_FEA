/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * quat_prod.c
 *
 * Code generation for function 'quat_prod'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "quat_prod.h"

/* Function Definitions */
void quat_prod(const real_T q2[4], const real_T q1[4], real_T q12[4])
{
  real_T y;
  int32_T k;

  /* QUAT_PROD */
  /*  Quaternion product, q12 = q2*q1 (column vectors) */
  /*  de Souza 2000, equation 3.54 */
  /*  Take the cross product of q1 and q2 */
  y = 0.0;
  for (k = 0; k < 3; k++) {
    y += q1[k + 1] * q2[k + 1];
  }

  q12[0] = q1[0] * q2[0] - y;
  q12[1] = (q1[0] * q2[1] + q2[0] * q1[1]) - (q1[2] * q2[3] - q1[3] * q2[2]);
  q12[2] = (q1[0] * q2[2] + q2[0] * q1[2]) - (q1[3] * q2[1] - q1[1] * q2[3]);
  q12[3] = (q1[0] * q2[3] + q2[0] * q1[3]) - (q1[1] * q2[2] - q1[2] * q2[1]);
}

/* End of code generation (quat_prod.c) */
