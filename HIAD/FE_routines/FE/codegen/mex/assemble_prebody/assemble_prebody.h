/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_prebody.h
 *
 * Code generation for function 'assemble_prebody'
 *
 */

#ifndef __ASSEMBLE_PREBODY_H__
#define __ASSEMBLE_PREBODY_H__

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
extern void assemble_prebody(emlrtCTX aTLS, const real_T con_data[], const
  int32_T con_size[2], emxArray_struct0_T *EL, const emxArray_real_T *U_input,
  boolean_T par, emxArray_real_T *fint_i, emxArray_real_T *Fint_i,
  emxArray_real_T *dof_Fint, emxArray_real_T *Kel, emxArray_real_T *dof_i,
  emxArray_real_T *dof_j, emxArray_real_T *ROT, real_T break_iter_data[],
  int32_T break_iter_size[1]);

#endif

/* End of code generation (assemble_prebody.h) */
