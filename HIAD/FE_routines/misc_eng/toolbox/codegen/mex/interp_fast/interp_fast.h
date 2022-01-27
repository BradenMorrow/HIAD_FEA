/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp_fast.h
 *
 * Code generation for function 'interp_fast'
 *
 */

#ifndef __INTERP_FAST_H__
#define __INTERP_FAST_H__

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
#include "interp_fast_types.h"

/* Function Declarations */
extern void interp_fast(const emxArray_real_T *pt, const emxArray_real_T *V_pt,
  real_T LAMBDA, emxArray_real_T *F);

#endif

/* End of code generation (interp_fast.h) */
