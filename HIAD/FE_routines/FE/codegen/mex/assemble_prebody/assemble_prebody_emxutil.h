/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_prebody_emxutil.h
 *
 * Code generation for function 'assemble_prebody_emxutil'
 *
 */

#ifndef __ASSEMBLE_PREBODY_EMXUTIL_H__
#define __ASSEMBLE_PREBODY_EMXUTIL_H__

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
extern void emxCopyStruct_struct_T(b_struct_T *dst, const b_struct_T *src);
extern void emxCopyStruct_struct_T1(struct_T *dst, const struct_T *src);
extern void emxEnsureCapacity(emxArray__common *emxArray, int32_T oldNumel,
  int32_T elementSize);
extern void emxEnsureCapacity_struct0_T(emxArray_struct0_T *emxArray, int32_T
  oldNumel);
extern void emxEnsureCapacity_struct5_T(emxArray_struct5_T *emxArray, int32_T
  oldNumel);
extern void emxFreeStruct_struct_T(b_struct_T *pStruct);
extern void emxFreeStruct_struct_T1(struct_T *pStruct);
extern void emxFree_real_T(emxArray_real_T **pEmxArray);
extern void emxFree_struct0_T(emxArray_struct0_T **pEmxArray);
extern void emxFree_struct5_T(emxArray_struct5_T **pEmxArray);
extern void emxInitStruct_struct_T(emlrtCTX aTLS, b_struct_T *pStruct, boolean_T
  doPush);
extern void emxInitStruct_struct_T1(emlrtCTX aTLS, struct_T *pStruct, boolean_T
  doPush);
extern void emxInit_real_T(emlrtCTX aTLS, emxArray_real_T **pEmxArray, int32_T
  numDimensions, boolean_T doPush);
extern void emxInit_real_T1(emlrtCTX aTLS, emxArray_real_T **pEmxArray, int32_T
  numDimensions, boolean_T doPush);
extern void emxInit_real_T2(emlrtCTX aTLS, emxArray_real_T **pEmxArray, int32_T
  numDimensions, boolean_T doPush);
extern void emxInit_struct0_T(emxArray_struct0_T **pEmxArray, int32_T
  numDimensions, boolean_T doPush);
extern void emxInit_struct5_T(emlrtCTX aTLS, emxArray_struct5_T **pEmxArray,
  int32_T numDimensions, boolean_T doPush);

#endif

/* End of code generation (assemble_prebody_emxutil.h) */
