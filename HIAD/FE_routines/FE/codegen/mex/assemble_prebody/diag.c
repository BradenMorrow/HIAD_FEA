/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * diag.c
 *
 * Code generation for function 'diag'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "diag.h"

/* Function Definitions */
void diag(const real_T v_data[], const int32_T v_size[1], real_T d_data[],
          int32_T d_size[2])
{
  int32_T j;
  int32_T i2;
  d_size[0] = (int8_T)v_size[0];
  d_size[1] = (int8_T)v_size[0];
  j = (int8_T)v_size[0] * (int8_T)v_size[0];
  for (i2 = 0; i2 < j; i2++) {
    d_data[i2] = 0.0;
  }

  for (j = 0; j + 1 <= v_size[0]; j++) {
    d_data[j + d_size[0] * j] = v_data[j];
  }
}

/* End of code generation (diag.c) */
