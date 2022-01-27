/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mpower.c
 *
 * Code generation for function 'mpower'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "mpower.h"

/* Function Definitions */
real_T b_mpower(real_T a)
{
  return muDoubleScalarPower(a, 3.0);
}

real_T mpower(real_T a)
{
  return a * a;
}

/* End of code generation (mpower.c) */
