/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * k1.h
 *
 * Code generation for function 'k1'
 *
 */

#ifndef __K1_H__
#define __K1_H__

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
extern void k1(const real_T material[2], const real_T geom[5], real_T L, real_T
               k[144]);

#endif

/* End of code generation (k1.h) */
