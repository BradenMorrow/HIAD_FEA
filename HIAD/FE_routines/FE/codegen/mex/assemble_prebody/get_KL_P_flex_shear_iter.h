/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_KL_P_flex_shear_iter.h
 *
 * Code generation for function 'get_KL_P_flex_shear_iter'
 *
 */

#ifndef __GET_KL_P_FLEX_SHEAR_ITER_H__
#define __GET_KL_P_FLEX_SHEAR_ITER_H__

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
extern void get_KL_P_flex_shear_iter(emlrtCTX aTLS, real_T el_in_p, real_T
  el_in_r, const real_T el_in_alpha_data[], const int32_T el_in_alpha_size[2],
  real_T el_in_beta, const emxArray_struct5_T *el_in_nodes, const real_T
  el_in_propsLH[5], real_T el_in_n, const real_T el_in_flex_K[25], const
  emxArray_real_T *el_in_flex_D, const real_T el_in_flex_Q[5], const real_T
  el_in_flex_f_data[], const int32_T el_in_flex_f_size[3], const real_T
  el_in_flex_d_data[], const int32_T el_in_flex_d_size[2], const real_T
  el_in_flex_e_data[], const int32_T el_in_flex_e_size[2], boolean_T
  el_in_state_it, const real_T el_in_D[6], const real_T el_in_dD[6], real_T
  el_in_L, real_T KL[36], real_T P[6], struct_T *el_out);

#endif

/* End of code generation (get_KL_P_flex_shear_iter.h) */
