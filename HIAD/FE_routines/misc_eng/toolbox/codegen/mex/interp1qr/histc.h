/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * histc.h
 *
 * Code generation for function 'histc'
 *
 */

#ifndef __HISTC_H__
#define __HISTC_H__

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
#include "interp1qr_types.h"

/* Function Declarations */
extern void histc(const real_T X_data[], const int32_T X_size[1], const
                  emxArray_real_T *edges, emxArray_real_T *N, real_T BIN_data[],
                  int32_T BIN_size[1]);

#endif

/* End of code generation (histc.h) */
