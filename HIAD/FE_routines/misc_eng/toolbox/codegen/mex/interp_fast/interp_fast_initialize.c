/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp_fast_initialize.c
 *
 * Code generation for function 'interp_fast_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp_fast.h"
#include "interp_fast_initialize.h"
#include "_coder_interp_fast_mex.h"
#include "interp_fast_data.h"

/* Function Definitions */
void interp_fast_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp_fast_initialize.c) */
