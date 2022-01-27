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
#include "omp.h"
#include "assemble_prebody_types.h"

/* Function Declarations */
extern void interp1qr(const real_T x_data[], const int32_T x_size[1], const
                      real_T y_data[], const int32_T y_size[1], const real_T xi
                      [2], real_T yi[2]);

#endif

/* End of code generation (interp1qr.h) */
