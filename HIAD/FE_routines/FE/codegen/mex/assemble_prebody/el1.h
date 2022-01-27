/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * el1.h
 *
 * Code generation for function 'el1'
 *
 */

#ifndef __EL1_H__
#define __EL1_H__

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
extern void el1(const real_T U_in_U0[12], const real_T U_in_U[12], const real_T
                U_in_delta_U[12], const real_T el_in_nodes_ij[6], const real_T
                el_in_orient_ij[3], b_struct_T *el_in0, real_T Kel[144], real_T
                fint_i[12], real_T Fint_i[12], real_T ROT_rot[6], real_T
                ROT_DELTA_rot[6]);

#endif

/* End of code generation (el1.h) */
