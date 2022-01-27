/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * ppval_fast.h
 *
 * Code generation for function 'ppval_fast'
 *
 */

#ifndef __PPVAL_FAST_H__
#define __PPVAL_FAST_H__

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "blas.h"
#include "rtwtypes.h"
#include "omp.h"
#include "assemble_prebody_types.h"

/* Function Declarations */
extern real_T b_ppval_fast(emlrtCTX aTLS, const emxArray_real_T *pp_breaks,
  const emxArray_real_T *pp_coefs, real_T pp_pieces, real_T pp_order, real_T xx);

#ifdef __WATCOMC__

#pragma aux b_ppval_fast value [8087];

#endif

extern real_T ppval_fast(emlrtCTX aTLS, const real_T pp_breaks_data[], const
  emxArray_real_T *pp_coefs, real_T pp_pieces, real_T pp_order, real_T xx);

#ifdef __WATCOMC__

#pragma aux ppval_fast value [8087];

#endif
#endif

/* End of code generation (ppval_fast.h) */
