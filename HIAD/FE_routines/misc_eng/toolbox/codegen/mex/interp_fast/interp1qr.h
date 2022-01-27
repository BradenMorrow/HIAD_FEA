/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1qr.h
 *
 * Code generation for function 'interp1qr'
 *
 */

#ifndef __INTERP1QR_H__
#define __INTERP1QR_H__

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
extern real_T interp1qr(const emxArray_real_T *x, const emxArray_real_T *y,
  real_T xi);

#ifdef __WATCOMC__

#pragma aux interp1qr value [8087];

#endif
#endif

/* End of code generation (interp1qr.h) */
