/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_R_PHI.h
 *
 * Code generation for function 'get_R_PHI'
 *
 */

#ifndef __GET_R_PHI_H__
#define __GET_R_PHI_H__

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
extern void get_R_PHI(const real_T PHI[3], real_T R[9]);

#endif

/* End of code generation (get_R_PHI.h) */
