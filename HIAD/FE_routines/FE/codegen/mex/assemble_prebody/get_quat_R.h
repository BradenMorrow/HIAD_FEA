/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_quat_R.h
 *
 * Code generation for function 'get_quat_R'
 *
 */

#ifndef __GET_QUAT_R_H__
#define __GET_QUAT_R_H__

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
extern void get_quat_R(const real_T R[9], real_T qi[4]);

#endif

/* End of code generation (get_quat_R.h) */
