/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_body.h
 *
 * Code generation for function 'assemble_body'
 *
 */

#ifndef __ASSEMBLE_BODY_H__
#define __ASSEMBLE_BODY_H__

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
extern void assemble_body(emlrtCTX aTLS, const real_T con[2], const char_T
  EL_el_data[], const int32_T EL_el_size[2], const real_T EL_el_in_nodes_ij[6],
  const real_T EL_el_in_orient_ij[3], const b_struct_T *EL_el_in0, const real_T
  U_input[48], b_struct_T *el_out, real_T fint_ii[12], real_T Fint_ii[12],
  emxArray_real_T *el_dof, real_T Kel_out[144], emxArray_real_T *dof_i,
  emxArray_real_T *dof_j, real_T ROT_out[12], real_T *break_iter);

#endif

/* End of code generation (assemble_body.h) */
