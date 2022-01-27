/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mldivide.c
 *
 * Code generation for function 'mldivide'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "mldivide.h"

/* Function Definitions */
void mldivide(const real_T A[25], real_T B[25])
{
  real_T b_A[25];
  int8_T ipiv[5];
  int32_T i31;
  int32_T j;
  int32_T c;
  int32_T jBcol;
  int32_T ix;
  real_T smax;
  int32_T k;
  real_T s;
  int32_T i;
  int32_T kAcol;
  memcpy(&b_A[0], &A[0], 25U * sizeof(real_T));
  for (i31 = 0; i31 < 5; i31++) {
    ipiv[i31] = (int8_T)(1 + i31);
  }

  for (j = 0; j < 4; j++) {
    c = j * 6;
    jBcol = 0;
    ix = c;
    smax = muDoubleScalarAbs(b_A[c]);
    for (k = 1; k + 1 <= 5 - j; k++) {
      ix++;
      s = muDoubleScalarAbs(b_A[ix]);
      if (s > smax) {
        jBcol = k;
        smax = s;
      }
    }

    if (b_A[c + jBcol] != 0.0) {
      if (jBcol != 0) {
        ipiv[j] = (int8_T)((j + jBcol) + 1);
        ix = j;
        jBcol += j;
        for (k = 0; k < 5; k++) {
          smax = b_A[ix];
          b_A[ix] = b_A[jBcol];
          b_A[jBcol] = smax;
          ix += 5;
          jBcol += 5;
        }
      }

      i31 = (c - j) + 5;
      for (i = c + 1; i + 1 <= i31; i++) {
        b_A[i] /= b_A[c];
      }
    }

    jBcol = c;
    kAcol = c + 5;
    for (i = 1; i <= 4 - j; i++) {
      smax = b_A[kAcol];
      if (b_A[kAcol] != 0.0) {
        ix = c + 1;
        i31 = (jBcol - j) + 10;
        for (k = 6 + jBcol; k + 1 <= i31; k++) {
          b_A[k] += b_A[ix] * -smax;
          ix++;
        }
      }

      kAcol += 5;
      jBcol += 5;
    }

    if (ipiv[j] != j + 1) {
      jBcol = ipiv[j] - 1;
      for (kAcol = 0; kAcol < 5; kAcol++) {
        smax = B[j + 5 * kAcol];
        B[j + 5 * kAcol] = B[jBcol + 5 * kAcol];
        B[jBcol + 5 * kAcol] = smax;
      }
    }
  }

  for (j = 0; j < 5; j++) {
    jBcol = 5 * j;
    for (k = 0; k < 5; k++) {
      kAcol = 5 * k;
      if (B[k + jBcol] != 0.0) {
        for (i = k + 1; i + 1 < 6; i++) {
          B[i + jBcol] -= B[k + jBcol] * b_A[i + kAcol];
        }
      }
    }
  }

  for (j = 0; j < 5; j++) {
    jBcol = 5 * j;
    for (k = 4; k >= 0; k += -1) {
      kAcol = 5 * k;
      if (B[k + jBcol] != 0.0) {
        B[k + jBcol] /= b_A[k + kAcol];
        for (i = 0; i + 1 <= k; i++) {
          B[i + jBcol] -= B[k + jBcol] * b_A[i + kAcol];
        }
      }
    }
  }
}

/* End of code generation (mldivide.c) */
