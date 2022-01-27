/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * ppval_fast.c
 *
 * Code generation for function 'ppval_fast'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "ppval_fast.h"
#include "assemble_prebody_emxutil.h"
#include "histc.h"

/* Function Definitions */
real_T b_ppval_fast(emlrtCTX aTLS, const emxArray_real_T *pp_breaks, const
                    emxArray_real_T *pp_coefs, real_T pp_pieces, real_T pp_order,
                    real_T xx)
{
  real_T v;
  real_T xs;
  int32_T ii_size_idx_0;
  int32_T ii_size_idx_1;
  emxArray_real_T *r1;
  int32_T i9;
  int32_T loop_ub;
  emxArray_real_T *unusedU1;
  real_T b_index;
  real_T dv21[1];
  real_T dv22[1];
  real_T dv23[1];
  int32_T i;
  emlrtHeapReferenceStackEnterFcnR2012b(aTLS);

  /* PPVAL  Evaluate piecewise polynomial. */
  /*    V = PPVAL(PP,XX) returns the value, at the entries of XX, of the  */
  /*    piecewise polynomial f contained in PP, as constructed by PCHIP, SPLINE, */
  /*    INTERP1, or the spline utility MKPP. */
  /*  */
  /*    V is obtained by replacing each entry of XX by the value of f there. */
  /*    If f is scalar-valued, then V is of the same size as XX. XX may be ND. */
  /*  */
  /*    If PP was constructed by PCHIP, SPLINE or MKPP using the orientation of */
  /*    non-scalar function values specified for those functions, then: */
  /*  */
  /*    If f is [D1,..,Dr]-valued, and XX is a vector of length N, then V has */
  /*    size [D1,...,Dr, N], with V(:,...,:,J) the value of f at XX(J). */
  /*    If f is [D1,..,Dr]-valued, and XX has size [N1,...,Ns], then V has size */
  /*    [D1,...,Dr, N1,...,Ns], with V(:,...,:, J1,...,Js) the value of f at */
  /*    XX(J1,...,Js). */
  /*  */
  /*    If PP was constructed by INTERP1 using the orientation of non-scalar */
  /*    function values specified for that function, then: */
  /*  */
  /*    If f is [D1,..,Dr]-valued, and XX is a scalar, then V has size */
  /*    [D1,...,Dr], with V the value of f at XX. */
  /*    If f is [D1,..,Dr]-valued, and XX is a vector of length N, then V has */
  /*    size [N,D1,...,Dr], with V(J,:,...,:) the value of f at XX(J). */
  /*    If f is [D1,..,Dr]-valued, and XX has size [N1,...,Ns], then V has size */
  /*    [N1,...,Ns,D1,...,Dr], with V(J1,...,Js,:,...,:) the value of f at */
  /*    XX(J1,...,Js). */
  /*  */
  /*    Example: */
  /*    Compare the results of integrating the function cos and its spline */
  /*    interpolant: */
  /*  */
  /*      a = 0; b = 10; */
  /*      int1 = integral(@cos,a,b); */
  /*      x = a:b; y = cos(x); pp = spline(x,y);  */
  /*      int2 = integral(@(x)ppval(pp,x),a,b); */
  /*  */
  /*    int1 provides the integral of the cosine function over the interval [a,b] */
  /*    while int2 provides the integral, over the same interval, of the piecewise */
  /*    polynomial pp that approximates the cosine function by interpolating the */
  /*    computed x,y values. */
  /*  */
  /*    Class support for input X and the fields of PP: */
  /*       float: double, single */
  /*  */
  /*    See also SPLINE, PCHIP, INTERP1, MKPP, UNMKPP. */
  /*    Carl de Boor */
  /*    Copyright 1984-2015 The MathWorks, Inc. */
  /*   obtain the row vector xs equivalent to XX */
  xs = xx;

  /*   if XX is row vector, suppress its first dimension */
  /*      sizexx(1) = []; */
  /*  take apart PP */
  /*  for each evaluation site, compute its breakpoint interval */
  /*  (mindful of the possibility that xx might be empty) */
  if (2.0 > pp_pieces) {
    ii_size_idx_0 = -2;
    ii_size_idx_1 = 0;
  } else {
    ii_size_idx_0 = -1;
    ii_size_idx_1 = (int32_T)pp_pieces;
  }

  emxInit_real_T(aTLS, &r1, 2, true);
  i9 = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  r1->size[1] = ii_size_idx_1 - ii_size_idx_0;
  emxEnsureCapacity((emxArray__common *)r1, i9, (int32_T)sizeof(real_T));
  r1->data[0] = rtMinusInf;
  loop_ub = ii_size_idx_1 - ii_size_idx_0;
  for (i9 = 0; i9 <= loop_ub - 3; i9++) {
    r1->data[r1->size[0] * (i9 + 1)] = pp_breaks->data[(ii_size_idx_0 + i9) + 2];
  }

  emxInit_real_T(aTLS, &unusedU1, 2, true);
  r1->data[r1->size[0] * ((ii_size_idx_1 - ii_size_idx_0) - 1)] = rtInf;
  histc(xx, r1, unusedU1, &b_index);

  /*  adjust for troubles, like evaluation sites that are NaN or +-inf */
  emxFree_real_T(&r1);
  emxFree_real_T(&unusedU1);
  if (xx == rtInf) {
    ii_size_idx_0 = 1;
    ii_size_idx_1 = 1;
  } else {
    ii_size_idx_0 = 0;
    ii_size_idx_1 = 0;
  }

  if (!((ii_size_idx_0 == 0) || (ii_size_idx_1 == 0))) {
    dv21[0] = b_index;
    for (ii_size_idx_0 = 0; ii_size_idx_0 < 1; ii_size_idx_0++) {
      dv21[0] = pp_pieces;
    }

    b_index = dv21[0];
  }

  if (b_index == 0.0) {
    ii_size_idx_0 = 1;
    ii_size_idx_1 = 1;
  } else {
    ii_size_idx_0 = 0;
    ii_size_idx_1 = 0;
  }

  if (!((ii_size_idx_0 == 0) || (ii_size_idx_1 == 0))) {
    dv22[0] = xx;
    for (ii_size_idx_0 = 0; ii_size_idx_0 < 1; ii_size_idx_0++) {
      dv22[0] = rtNaN;
    }

    xs = dv22[0];
    dv23[0] = b_index;
    for (ii_size_idx_0 = 0; ii_size_idx_0 < 1; ii_size_idx_0++) {
      dv23[0] = 1.0;
    }

    b_index = dv23[0];
  }

  /*  now go to local coordinates ... */
  xs -= pp_breaks->data[(int32_T)b_index - 1];

  /*  ... and apply nested multiplication: */
  v = pp_coefs->data[(int32_T)b_index - 1];
  for (i = 1; i - 1 < (int32_T)(pp_order + -1.0); i++) {
    v = xs * v + pp_coefs->data[((int32_T)b_index + pp_coefs->size[0] * i) - 1];
  }

  /*  If evaluating a piecewise constant with more than one piece at NaN, return */
  /*  NaN.  With one piece return the constant. */
  emlrtHeapReferenceStackLeaveFcnR2012b(aTLS);
  return v;
}

real_T ppval_fast(emlrtCTX aTLS, const real_T pp_breaks_data[], const
                  emxArray_real_T *pp_coefs, real_T pp_pieces, real_T pp_order,
                  real_T xx)
{
  real_T v;
  real_T xs;
  int32_T ii_size_idx_0;
  int32_T ii_size_idx_1;
  real_T tmp_data[502];
  int32_T tmp_size[2];
  int32_T loop_ub;
  int32_T i8;
  emxArray_real_T *unusedU1;
  emxArray_real_T b_tmp_data;
  real_T b_index;
  real_T dv18[1];
  real_T dv19[1];
  real_T dv20[1];
  int32_T i;
  emlrtHeapReferenceStackEnterFcnR2012b(aTLS);

  /* PPVAL  Evaluate piecewise polynomial. */
  /*    V = PPVAL(PP,XX) returns the value, at the entries of XX, of the  */
  /*    piecewise polynomial f contained in PP, as constructed by PCHIP, SPLINE, */
  /*    INTERP1, or the spline utility MKPP. */
  /*  */
  /*    V is obtained by replacing each entry of XX by the value of f there. */
  /*    If f is scalar-valued, then V is of the same size as XX. XX may be ND. */
  /*  */
  /*    If PP was constructed by PCHIP, SPLINE or MKPP using the orientation of */
  /*    non-scalar function values specified for those functions, then: */
  /*  */
  /*    If f is [D1,..,Dr]-valued, and XX is a vector of length N, then V has */
  /*    size [D1,...,Dr, N], with V(:,...,:,J) the value of f at XX(J). */
  /*    If f is [D1,..,Dr]-valued, and XX has size [N1,...,Ns], then V has size */
  /*    [D1,...,Dr, N1,...,Ns], with V(:,...,:, J1,...,Js) the value of f at */
  /*    XX(J1,...,Js). */
  /*  */
  /*    If PP was constructed by INTERP1 using the orientation of non-scalar */
  /*    function values specified for that function, then: */
  /*  */
  /*    If f is [D1,..,Dr]-valued, and XX is a scalar, then V has size */
  /*    [D1,...,Dr], with V the value of f at XX. */
  /*    If f is [D1,..,Dr]-valued, and XX is a vector of length N, then V has */
  /*    size [N,D1,...,Dr], with V(J,:,...,:) the value of f at XX(J). */
  /*    If f is [D1,..,Dr]-valued, and XX has size [N1,...,Ns], then V has size */
  /*    [N1,...,Ns,D1,...,Dr], with V(J1,...,Js,:,...,:) the value of f at */
  /*    XX(J1,...,Js). */
  /*  */
  /*    Example: */
  /*    Compare the results of integrating the function cos and its spline */
  /*    interpolant: */
  /*  */
  /*      a = 0; b = 10; */
  /*      int1 = integral(@cos,a,b); */
  /*      x = a:b; y = cos(x); pp = spline(x,y);  */
  /*      int2 = integral(@(x)ppval(pp,x),a,b); */
  /*  */
  /*    int1 provides the integral of the cosine function over the interval [a,b] */
  /*    while int2 provides the integral, over the same interval, of the piecewise */
  /*    polynomial pp that approximates the cosine function by interpolating the */
  /*    computed x,y values. */
  /*  */
  /*    Class support for input X and the fields of PP: */
  /*       float: double, single */
  /*  */
  /*    See also SPLINE, PCHIP, INTERP1, MKPP, UNMKPP. */
  /*    Carl de Boor */
  /*    Copyright 1984-2015 The MathWorks, Inc. */
  /*   obtain the row vector xs equivalent to XX */
  xs = xx;

  /*   if XX is row vector, suppress its first dimension */
  /*      sizexx(1) = []; */
  /*  take apart PP */
  /*  for each evaluation site, compute its breakpoint interval */
  /*  (mindful of the possibility that xx might be empty) */
  if (2.0 > pp_pieces) {
    ii_size_idx_0 = -2;
    ii_size_idx_1 = 0;
  } else {
    ii_size_idx_0 = -1;
    ii_size_idx_1 = (int32_T)pp_pieces;
  }

  tmp_size[0] = 1;
  tmp_size[1] = ii_size_idx_1 - ii_size_idx_0;
  tmp_data[0] = rtMinusInf;
  loop_ub = ii_size_idx_1 - ii_size_idx_0;
  for (i8 = 0; i8 <= loop_ub - 3; i8++) {
    tmp_data[tmp_size[0] * (i8 + 1)] = pp_breaks_data[(ii_size_idx_0 + i8) + 2];
  }

  emxInit_real_T(aTLS, &unusedU1, 2, true);
  tmp_data[tmp_size[0] * ((ii_size_idx_1 - ii_size_idx_0) - 1)] = rtInf;
  b_tmp_data.data = (real_T *)&tmp_data;
  b_tmp_data.size = (int32_T *)&tmp_size;
  b_tmp_data.allocatedSize = 502;
  b_tmp_data.numDimensions = 2;
  b_tmp_data.canFreeData = false;
  histc(xx, &b_tmp_data, unusedU1, &b_index);

  /*  adjust for troubles, like evaluation sites that are NaN or +-inf */
  emxFree_real_T(&unusedU1);
  if (xx == rtInf) {
    ii_size_idx_0 = 1;
    ii_size_idx_1 = 1;
  } else {
    ii_size_idx_0 = 0;
    ii_size_idx_1 = 0;
  }

  if (!((ii_size_idx_0 == 0) || (ii_size_idx_1 == 0))) {
    dv18[0] = b_index;
    for (ii_size_idx_0 = 0; ii_size_idx_0 < 1; ii_size_idx_0++) {
      dv18[0] = pp_pieces;
    }

    b_index = dv18[0];
  }

  if (b_index == 0.0) {
    ii_size_idx_0 = 1;
    ii_size_idx_1 = 1;
  } else {
    ii_size_idx_0 = 0;
    ii_size_idx_1 = 0;
  }

  if (!((ii_size_idx_0 == 0) || (ii_size_idx_1 == 0))) {
    dv19[0] = xx;
    for (ii_size_idx_0 = 0; ii_size_idx_0 < 1; ii_size_idx_0++) {
      dv19[0] = rtNaN;
    }

    xs = dv19[0];
    dv20[0] = b_index;
    for (ii_size_idx_0 = 0; ii_size_idx_0 < 1; ii_size_idx_0++) {
      dv20[0] = 1.0;
    }

    b_index = dv20[0];
  }

  /*  now go to local coordinates ... */
  xs -= pp_breaks_data[(int32_T)b_index - 1];

  /*  ... and apply nested multiplication: */
  v = pp_coefs->data[(int32_T)b_index - 1];
  for (i = 1; i - 1 < (int32_T)(pp_order + -1.0); i++) {
    v = xs * v + pp_coefs->data[((int32_T)b_index + pp_coefs->size[0] * i) - 1];
  }

  /*  If evaluating a piecewise constant with more than one piece at NaN, return */
  /*  NaN.  With one piece return the constant. */
  emlrtHeapReferenceStackLeaveFcnR2012b(aTLS);
  return v;
}

/* End of code generation (ppval_fast.c) */
