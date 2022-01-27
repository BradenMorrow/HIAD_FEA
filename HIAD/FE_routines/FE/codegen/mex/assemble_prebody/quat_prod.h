/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * quat_prod.h
 *
 * Code generation for function 'quat_prod'
 *
 */

#ifndef __QUAT_PROD_H__
#define __QUAT_PROD_H__

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
extern void quat_prod(const real_T q2[4], const real_T q1[4], real_T q12[4]);

#endif

/* End of code generation (quat_prod.h) */
