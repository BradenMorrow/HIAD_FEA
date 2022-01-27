/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * abs.c
 *
 * Code generation for function 'abs'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "abs.h"
#include "assemble_prebody_emxutil.h"

/* Function Definitions */
void b_abs(const emxArray_real_T *x, emxArray_real_T *y)
{
  int32_T n;
  int32_T k;
  n = y->size[0] * y->size[1];
  y->size[0] = 5;
  y->size[1] = x->size[1];
  emxEnsureCapacity((emxArray__common *)y, n, (int32_T)sizeof(real_T));
  n = 5 * x->size[1];
  for (k = 0; k + 1 <= n; k++) {
    y->data[k] = muDoubleScalarAbs(x->data[k]);
  }
}

/* End of code generation (abs.c) */
