/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_S.c
 *
 * Code generation for function 'get_S'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_S.h"

/* Function Definitions */
void get_S(const real_T w[3], real_T S[9])
{
  /* GET_S */
  /*    Get the S matrix */
  memset(&S[0], 0, 9U * sizeof(real_T));

  /* replace zeros(3) with explicit definition to improve performance */
  S[1] = w[2];
  S[2] = -w[1];
  S[3] = -w[2];
  S[5] = w[0];
  S[6] = w[1];
  S[7] = -w[0];

  /*  S = [0 -w(3) w(2) */
  /*      w(3) 0 -w(1) */
  /*      -w(2) w(1) 0]; */
}

/* End of code generation (get_S.c) */
