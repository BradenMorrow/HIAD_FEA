/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * cross.h
 *
 * Code generation for function 'cross'
 *
 */

#ifndef __CROSS_H__
#define __CROSS_H__

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
extern void cross(const real_T a[3], const real_T b[3], real_T c[3]);

#endif

/* End of code generation (cross.h) */
