/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp_fast_terminate.c
 *
 * Code generation for function 'interp_fast_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp_fast.h"
#include "interp_fast_terminate.h"
#include "_coder_interp_fast_mex.h"
#include "interp_fast_data.h"

/* Function Definitions */
void interp_fast_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void interp_fast_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (interp_fast_terminate.c) */
