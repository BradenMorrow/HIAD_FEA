/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_quat_PHI.c
 *
 * Code generation for function 'get_quat_PHI'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_quat_PHI.h"

/* Function Definitions */
void get_quat_PHI(const real_T PHI[3], real_T qi[4])
{
  real_T phi;
  real_T scale;
  int32_T k;
  real_T absxk;
  real_T t;

  /* GET_QUAT */
  /*    Get unit quaternions from a rotational vector */
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
  qi[0] = muDoubleScalarCos(phi / 2.0);
  scale = muDoubleScalarSin(phi / 2.0);
  for (k = 0; k < 3; k++) {
    qi[k + 1] = scale * PHI[k];
  }

  /*  /phi; % To normalize, divide by norm of PHI */
  /*  qi = qi/norm(qi); */
  if (phi != 0.0) {
    for (k = 0; k < 3; k++) {
      qi[1 + k] /= phi;
    }
  }
}

/* End of code generation (get_quat_PHI.c) */
