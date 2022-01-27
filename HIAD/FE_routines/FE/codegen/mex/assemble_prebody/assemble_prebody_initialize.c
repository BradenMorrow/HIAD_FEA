/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_prebody_initialize.c
 *
 * Code generation for function 'assemble_prebody_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "assemble_prebody_initialize.h"
#include "_coder_assemble_prebody_mex.h"
#include "assemble_prebody_data.h"

/* Function Definitions */
void assemble_prebody_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (assemble_prebody_initialize.c) */
