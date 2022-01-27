/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1qr_initialize.c
 *
 * Code generation for function 'interp1qr_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1qr.h"
#include "interp1qr_initialize.h"
#include "_coder_interp1qr_mex.h"
#include "interp1qr_data.h"

/* Function Definitions */
void interp1qr_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (interp1qr_initialize.c) */
