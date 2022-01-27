/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1.h
 *
 * Code generation for function 'interp1'
 *
 */

#ifndef __INTERP1_H__
#define __INTERP1_H__

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
extern void interp1(const real_T varargin_1_data[], const int32_T
                    varargin_1_size[1], const real_T varargin_2_data[], const
                    int32_T varargin_2_size[1], const real_T varargin_3[2],
                    real_T Vq[2]);

#endif

/* End of code generation (interp1.h) */
