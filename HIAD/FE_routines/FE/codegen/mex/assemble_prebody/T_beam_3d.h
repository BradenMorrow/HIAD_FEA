/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * T_beam_3d.h
 *
 * Code generation for function 'T_beam_3d'
 *
 */

#ifndef __T_BEAM_3D_H__
#define __T_BEAM_3D_H__

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
extern void T_beam_3d(const real_T nodes[6], const real_T orient[3], real_T T
                      [144]);

#endif

/* End of code generation (T_beam_3d.h) */
