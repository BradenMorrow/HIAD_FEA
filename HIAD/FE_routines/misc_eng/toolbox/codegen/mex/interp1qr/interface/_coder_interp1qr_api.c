/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_interp1qr_api.c
 *
 * Code generation for function '_coder_interp1qr_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp1qr.h"
#include "_coder_interp1qr_api.h"
#include "interp1qr_emxutil.h"
#include "interp1qr_data.h"

/* Function Declarations */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void c_emlrt_marshallIn(const mxArray *y, const char_T *identifier,
  emxArray_real_T *b_y);
static const mxArray *c_emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[1]);
static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void e_emlrt_marshallIn(const mxArray *xi, const char_T *identifier,
  real_T **y_data, int32_T y_size[1]);
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T **y_data, int32_T y_size[1]);
static void g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void h_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T **ret_data, int32_T ret_size[1]);

/* Function Definitions */
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  g_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const mxArray *y, const char_T *identifier,
  emxArray_real_T *b_y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(emlrtAlias(y), &thisId, b_y);
  emlrtDestroyArray(&y);
}

static const mxArray *c_emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[1])
{
  const mxArray *y;
  static const int32_T iv0[1] = { 0 };

  const mxArray *m2;
  y = NULL;
  m2 = emlrtCreateNumericArray(1, iv0, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m2, (void *)u_data);
  emlrtSetDimensions((mxArray *)m2, u_size, 1);
  emlrtAssign(&y, m2);
  return y;
}

static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  h_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const mxArray *xi, const char_T *identifier,
  real_T **y_data, int32_T y_size[1])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(emlrtAlias(xi), &thisId, y_data, y_size);
  emlrtDestroyArray(&xi);
}

static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(x), &thisId, y);
  emlrtDestroyArray(&x);
}

static void f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T **y_data, int32_T y_size[1])
{
  i_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void g_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  int32_T iv1[1];
  boolean_T bv0[1] = { true };

  static const int32_T dims[1] = { 20000 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims, &bv0[0], iv1);
  ret->size[0] = iv1[0];
  ret->allocatedSize = ret->size[0];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void h_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  int32_T iv2[1];
  boolean_T bv1[1] = { true };

  static const int32_T dims[1] = { 50000 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims, &bv1[0], iv2);
  ret->size[0] = iv2[0];
  ret->allocatedSize = ret->size[0];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void i_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T **ret_data, int32_T ret_size[1])
{
  int32_T iv3[1];
  boolean_T bv2[1] = { true };

  static const int32_T dims[1] = { 20 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims, &bv2[0], iv3);
  ret_size[0] = iv3[0];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

void interp1qr_api(const mxArray * const prhs[3], const mxArray *plhs[1])
{
  real_T (*yi_data)[20];
  emxArray_real_T *x;
  emxArray_real_T *y;
  int32_T xi_size[1];
  real_T (*xi_data)[20];
  int32_T yi_size[1];
  yi_data = (real_T (*)[20])mxMalloc(sizeof(real_T [20]));
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&x, 1, true);
  emxInit_real_T(&y, 1, true);

  /* Marshall function inputs */
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  c_emlrt_marshallIn(emlrtAlias(prhs[1]), "y", y);
  e_emlrt_marshallIn(emlrtAlias(prhs[2]), "xi", (real_T **)&xi_data, xi_size);

  /* Invoke the target function */
  interp1qr(x, y, *xi_data, xi_size, *yi_data, yi_size);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(*yi_data, yi_size);
  y->canFreeData = false;
  emxFree_real_T(&y);
  x->canFreeData = false;
  emxFree_real_T(&x);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (_coder_interp1qr_api.c) */
