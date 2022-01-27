/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_G.h
 *
 * Code generation for function 'get_G'
 *
 */

#ifndef __GET_G_H__
#define __GET_G_H__

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
extern void get_G(const real_T rk[3], const real_T z[3], const real_T e1[3],
                  real_T L, const real_T r1[3], real_T G[144]);

#endif

/* End of code generation (get_G.h) */
