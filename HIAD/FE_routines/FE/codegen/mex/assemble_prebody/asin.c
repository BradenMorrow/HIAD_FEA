/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * asin.c
 *
 * Code generation for function 'asin'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "asin.h"

/* Function Definitions */
void b_asin(real_T *x)
{
  *x = muDoubleScalarAsin(*x);
}

/* End of code generation (asin.c) */
