/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_L.c
 *
 * Code generation for function 'get_L'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_L.h"

/* Function Definitions */
void get_L(const real_T rk[3], const real_T e1[3], real_T l, const real_T r1[3],
           real_T L[36])
{
  real_T y;
  real_T dv17[9];
  int32_T i4;
  int32_T k;
  static const int8_T iv8[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  real_T A[9];
  real_T Srk[9];
  real_T Sr1[9];
  real_T b_A[3];
  real_T b_e1[3];
  real_T b_y;
  real_T b_Srk[3];
  real_T c_e1[3];
  real_T L1[9];

  /* GET_L */
  /*    Get the L matrix */
  y = 1.0 / l;
  for (i4 = 0; i4 < 3; i4++) {
    for (k = 0; k < 3; k++) {
      dv17[i4 + 3 * k] = (real_T)iv8[i4 + 3 * k] - e1[i4] * e1[k];
    }
  }

  for (i4 = 0; i4 < 3; i4++) {
    for (k = 0; k < 3; k++) {
      A[k + 3 * i4] = y * dv17[k + 3 * i4];
    }
  }

  /*  Srk = get_S(rk); */
  /*  Sr1 = get_S(r1); */
  /*  Replace get_S with built in code to improve performance */
  /* replace zeros(3) with explicit definition to improve performance */
  for (i4 = 0; i4 < 9; i4++) {
    Srk[i4] = 0.0;
    Sr1[i4] = 0.0;
  }

  Srk[1] = rk[2];
  Srk[2] = -rk[1];
  Srk[3] = -rk[2];
  Srk[5] = rk[0];
  Srk[6] = rk[1];
  Srk[7] = -rk[0];

  /* replace zeros(3) with explicit definition to improve performance */
  Sr1[1] = r1[2];
  Sr1[2] = -r1[1];
  Sr1[3] = -r1[2];
  Sr1[5] = r1[0];
  Sr1[6] = r1[1];
  Sr1[7] = -r1[0];
  y = 0.0;
  for (k = 0; k < 3; k++) {
    y += rk[k] * e1[k];
    b_A[k] = 0.0;
    for (i4 = 0; i4 < 3; i4++) {
      b_A[k] += A[k + 3 * i4] * rk[i4];
    }

    b_e1[k] = e1[k] + r1[k];
  }

  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    b_y += rk[k] * e1[k];
    b_Srk[k] = 0.0;
    for (i4 = 0; i4 < 3; i4++) {
      L1[k + 3 * i4] = y * A[k + 3 * i4] / 2.0 + b_A[k] * b_e1[i4] / 2.0;
      b_Srk[k] += Srk[k + 3 * i4] * e1[i4];
    }

    c_e1[k] = e1[k] + r1[k];
  }

  for (i4 = 0; i4 < 3; i4++) {
    for (k = 0; k < 3; k++) {
      A[i4 + 3 * k] = (Srk[i4 + 3 * k] / 2.0 - b_y * Sr1[i4 + 3 * k] / 4.0) -
        b_Srk[i4] * c_e1[k] / 4.0;
      L[k + 12 * i4] = L1[k + 3 * i4];
    }
  }

  for (i4 = 0; i4 < 3; i4++) {
    for (k = 0; k < 3; k++) {
      L[(k + 12 * i4) + 3] = A[k + 3 * i4];
      L[(k + 12 * i4) + 6] = -L1[k + 3 * i4];
      L[(k + 12 * i4) + 9] = A[k + 3 * i4];
    }
  }
}

/* End of code generation (get_L.c) */
