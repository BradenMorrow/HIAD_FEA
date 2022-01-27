/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sqrt.c
 *
 * Code generation for function 'sqrt'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "sqrt.h"

/* Function Definitions */
void b_sqrt(real_T *x)
{
  *x = muDoubleScalarSqrt(*x);
}

/* End of code generation (sqrt.c) */
