/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_assemble_prebody_api.c
 *
 * Code generation for function '_coder_assemble_prebody_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "_coder_assemble_prebody_api.h"
#include "assemble_prebody_emxutil.h"
#include "assemble_prebody_data.h"

/* Function Declarations */
static void ab_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct7_T *y);
static void ac_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[25]);
static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T **y_data, int32_T y_size[2]);
static void bb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[25]);
static void bc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2]);
static void c_emlrt_marshallIn(const mxArray *EL, const char_T *identifier,
  emxArray_struct0_T *y);
static const mxArray *c_emlrt_marshallOut(const emxArray_struct0_T *u);
static void cb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2]);
static void cc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[3]);
static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_struct0_T *y);
static const mxArray *d_emlrt_marshallOut(const emxArray_real_T *u);
static void db_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[3]);
static void dc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2]);
static void e_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y_data[], int32_T y_size[2]);
static const mxArray *e_emlrt_marshallOut(const emxArray_real_T *u);
static void eb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2]);
static boolean_T ec_emlrt_marshallIn(const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void emlrt_marshallIn(const mxArray *con, const char_T *identifier,
  real_T **y_data, int32_T y_size[2]);
static void f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct1_T *y);
static const mxArray *f_emlrt_marshallOut(const emxArray_real_T *u);
static boolean_T fb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *
  parentId);
static void fc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void g_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[6]);
static const mxArray *g_emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[1]);
static void gb_emlrt_marshallIn(const mxArray *U_input, const char_T *identifier,
  emxArray_real_T *y);
static void h_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[3]);
static void hb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void i_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct2_T *y);
static boolean_T ib_emlrt_marshallIn(const mxArray *par, const char_T
  *identifier);
static real_T j_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static void jb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T **ret_data, int32_T ret_size[2]);
static void k_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[2]);
static void kb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret_data[], int32_T ret_size[2]);
static void l_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[5]);
static void lb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[6]);
static void m_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct3_T *y);
static void mb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[3]);
static void n_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[2]);
static real_T nb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static void o_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2]);
static void ob_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[2]);
static void p_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void pb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[5]);
static void q_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct4_T *y);
static void qb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[2]);
static void r_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[36]);
static void rb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2]);
static void s_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2]);
static void sb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static void t_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2]);
static void tb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[36]);
static void u_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_struct5_T *y);
static void ub_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2]);
static void v_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct6_T y_data[], int32_T y_size[2]);
static void vb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2]);
static void w_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2]);
static void wb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2]);
static void x_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[5]);
static void xb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[5]);
static void y_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[6]);
static void yb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[6]);

/* Function Definitions */
static void ab_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct7_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[8] = { "break", "K", "D", "Du", "Q", "f", "d",
    "e" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(emlrtRootTLSGlobal, parentId, u, 8, fieldNames, 0U,
    &dims);
  thisId.fIdentifier = "break";
  y->b_break = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a
    (emlrtRootTLSGlobal, u, 0, "break")), &thisId);
  thisId.fIdentifier = "K";
  bb_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "K")), &thisId, y->K);
  thisId.fIdentifier = "D";
  cb_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "D")), &thisId, y->D.data, y->D.size);
  thisId.fIdentifier = "Du";
  cb_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "Du")), &thisId, y->Du.data, y->Du.size);
  thisId.fIdentifier = "Q";
  x_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "Q")), &thisId, y->Q);
  thisId.fIdentifier = "f";
  db_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "f")), &thisId, y->f.data, y->f.size);
  thisId.fIdentifier = "d";
  cb_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "d")), &thisId, y->d.data, y->d.size);
  thisId.fIdentifier = "e";
  eb_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "e")), &thisId, y->e.data, y->e.size);
  emlrtDestroyArray(&u);
}

static void ac_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[25])
{
  static const int32_T dims[2] = { 5, 5 };

  int32_T i24;
  int32_T i25;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  for (i24 = 0; i24 < 5; i24++) {
    for (i25 = 0; i25 < 5; i25++) {
      ret[i25 + 5 * i24] = (*(real_T (*)[25])mxGetData(src))[i25 + 5 * i24];
    }
  }

  emlrtDestroyArray(&src);
}

static void b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T **y_data, int32_T y_size[2])
{
  jb_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void bb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[25])
{
  ac_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void bc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2])
{
  int32_T iv38[2];
  boolean_T bv12[2] = { false, true };

  static const int32_T dims[2] = { 5, 20 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv12[0], iv38);
  ret_size[0] = iv38[0];
  ret_size[1] = iv38[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void c_emlrt_marshallIn(const mxArray *EL, const char_T *identifier,
  emxArray_struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(emlrtAlias(EL), &thisId, y);
  emlrtDestroyArray(&EL);
}

static const mxArray *c_emlrt_marshallOut(const emxArray_struct0_T *u)
{
  const mxArray *y;
  emxArray_real_T *b_u;
  emxArray_real_T *c_u;
  emxArray_real_T *d_u;
  int32_T iv13[1];
  int32_T i;
  int32_T b_j0;
  int32_T u_size[2];
  int32_T loop_ub;
  int32_T i13;
  char_T u_data[20];
  const mxArray *b_y;
  const mxArray *m2;
  const mxArray *c_y;
  const mxArray *d_y;
  static const int32_T iv14[2] = { 2, 3 };

  real_T *pData;
  int32_T b_i;
  const mxArray *e_y;
  static const int32_T iv15[2] = { 1, 3 };

  const mxArray *f_y;
  const mxArray *g_y;
  const mxArray *h_y;
  static const int32_T iv16[2] = { 1, 2 };

  const mxArray *i_y;
  static const int32_T iv17[2] = { 1, 5 };

  const mxArray *j_y;
  char_T e_u[2];
  const mxArray *k_y;
  static const int32_T iv18[2] = { 1, 2 };

  int32_T b_u_size[2];
  real_T b_u_data[500];
  const mxArray *l_y;
  const mxArray *m_y;
  int32_T c_i;
  const mxArray *n_y;
  const mxArray *o_y;
  const mxArray *p_y;
  const mxArray *q_y;
  char_T f_u[2];
  const mxArray *r_y;
  static const int32_T iv19[2] = { 1, 2 };

  const mxArray *s_y;
  const mxArray *t_y;
  const mxArray *u_y;
  const mxArray *v_y;
  const mxArray *w_y;
  const mxArray *x_y;
  const mxArray *y_y;
  static const int32_T iv20[2] = { 6, 6 };

  const mxArray *ab_y;
  const mxArray *bb_y;
  int32_T c_u_size[2];
  real_T c_u_data[100];
  const mxArray *cb_y;
  const mxArray *db_y;
  int32_T d_u_size[2];
  real_T d_u_data[10];
  const mxArray *eb_y;
  int32_T e_u_size[2];
  real_T e_u_data[10];
  const mxArray *fb_y;
  const mxArray *gb_y;
  int32_T iv21[2];
  int32_T b_j1;
  const mxArray *hb_y;
  int32_T c_j1;
  int32_T f_u_size[2];
  real_T f_u_data[2000];
  const mxArray *ib_y;
  int32_T d_i;
  const mxArray *jb_y;
  static const int32_T iv22[1] = { 5 };

  const mxArray *kb_y;
  static const int32_T iv23[1] = { 6 };

  const mxArray *lb_y;
  static const int32_T iv24[1] = { 6 };

  const mxArray *mb_y;
  const mxArray *nb_y;
  const mxArray *ob_y;
  const mxArray *pb_y;
  static const int32_T iv25[2] = { 5, 5 };

  int32_T g_u_size[2];
  real_T g_u_data[100];
  const mxArray *qb_y;
  int32_T h_u_size[2];
  real_T h_u_data[100];
  const mxArray *rb_y;
  const mxArray *sb_y;
  static const int32_T iv26[1] = { 5 };

  int32_T i_u_size[3];
  real_T i_u_data[500];
  const mxArray *tb_y;
  int32_T j_u_size[2];
  real_T j_u_data[100];
  const mxArray *ub_y;
  int32_T k_u_size[2];
  real_T k_u_data[400];
  const mxArray *vb_y;
  const mxArray *wb_y;
  const mxArray *xb_y;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(emlrtRootTLSGlobal, &b_u, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &c_u, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &d_u, 2, true);
  y = NULL;
  iv13[0] = u->size[0];
  emlrtAssign(&y, emlrtCreateStructArray(1, iv13, 0, NULL));
  emlrtCreateField(y, "el");
  emlrtCreateField(y, "el_in");
  emlrtCreateField(y, "el_in0");
  i = 0;
  for (b_j0 = 0; b_j0 < u->size[0U]; b_j0++) {
    u_size[0] = 1;
    u_size[1] = u->data[b_j0].el.size[1];
    loop_ub = u->data[b_j0].el.size[0] * u->data[b_j0].el.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      u_data[i13] = u->data[b_j0].el.data[i13];
    }

    b_y = NULL;
    m2 = emlrtCreateCharArray(2, u_size);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, u_size[1], m2, &u_data[0]);
    emlrtAssign(&b_y, m2);
    emlrtAddField(y, b_y, "el", i);
    c_y = NULL;
    emlrtAssign(&c_y, emlrtCreateStructMatrix(1, 1, 0, NULL));
    d_y = NULL;
    m2 = emlrtCreateNumericArray(2, iv14, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 6; b_i++) {
      pData[b_i] = u->data[b_j0].el_in.nodes_ij[b_i];
    }

    emlrtAssign(&d_y, m2);
    emlrtAddField(c_y, d_y, "nodes_ij", 0);
    e_y = NULL;
    m2 = emlrtCreateNumericArray(2, iv15, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 3; b_i++) {
      pData[b_i] = u->data[b_j0].el_in.orient_ij[b_i];
    }

    emlrtAssign(&e_y, m2);
    emlrtAddField(c_y, e_y, "orient_ij", 0);
    emlrtAddField(y, c_y, "el_in", i);
    f_y = NULL;
    emlrtAssign(&f_y, emlrtCreateStructMatrix(1, 1, 0, NULL));
    g_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.b_break);
    emlrtAssign(&g_y, m2);
    emlrtAddField(f_y, g_y, "break", 0);
    h_y = NULL;
    m2 = emlrtCreateNumericArray(2, iv16, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 2; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.mat[b_i];
    }

    emlrtAssign(&h_y, m2);
    emlrtAddField(f_y, h_y, "mat", 0);
    i_y = NULL;
    m2 = emlrtCreateNumericArray(2, iv17, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 5; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.geom[b_i];
    }

    emlrtAssign(&i_y, m2);
    emlrtAddField(f_y, i_y, "geom", 0);
    j_y = NULL;
    emlrtAssign(&j_y, emlrtCreateStructMatrix(1, 1, 0, NULL));
    for (i13 = 0; i13 < 2; i13++) {
      e_u[i13] = u->data[b_j0].el_in0.axial.form[i13];
    }

    k_y = NULL;
    m2 = emlrtCreateCharArray(2, iv18);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m2, &e_u[0]);
    emlrtAssign(&k_y, m2);
    emlrtAddField(j_y, k_y, "form", 0);
    b_u_size[0] = 1;
    b_u_size[1] = u->data[b_j0].el_in0.axial.breaks.size[1];
    loop_ub = u->data[b_j0].el_in0.axial.breaks.size[0] * u->data[b_j0].
      el_in0.axial.breaks.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      b_u_data[i13] = u->data[b_j0].el_in0.axial.breaks.data[i13];
    }

    l_y = NULL;
    m2 = emlrtCreateNumericArray(2, b_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < b_u_size[1]; b_i++) {
      pData[i13] = b_u_data[b_u_size[0] * b_i];
      i13++;
    }

    emlrtAssign(&l_y, m2);
    emlrtAddField(j_y, l_y, "breaks", 0);
    i13 = b_u->size[0] * b_u->size[1];
    b_u->size[0] = u->data[b_j0].el_in0.axial.coefs->size[0];
    b_u->size[1] = u->data[b_j0].el_in0.axial.coefs->size[1];
    emxEnsureCapacity((emxArray__common *)b_u, i13, (int32_T)sizeof(real_T));
    loop_ub = u->data[b_j0].el_in0.axial.coefs->size[0] * u->data[b_j0].
      el_in0.axial.coefs->size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      b_u->data[i13] = u->data[b_j0].el_in0.axial.coefs->data[i13];
    }

    m_y = NULL;
    m2 = emlrtCreateNumericArray(2, *(int32_T (*)[2])b_u->size, mxDOUBLE_CLASS,
      mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < b_u->size[1]; b_i++) {
      for (c_i = 0; c_i < b_u->size[0]; c_i++) {
        pData[i13] = b_u->data[c_i + b_u->size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&m_y, m2);
    emlrtAddField(j_y, m_y, "coefs", 0);
    n_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.axial.pieces);
    emlrtAssign(&n_y, m2);
    emlrtAddField(j_y, n_y, "pieces", 0);
    o_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.axial.order);
    emlrtAssign(&o_y, m2);
    emlrtAddField(j_y, o_y, "order", 0);
    p_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.axial.dim);
    emlrtAssign(&p_y, m2);
    emlrtAddField(j_y, p_y, "dim", 0);
    emlrtAddField(f_y, j_y, "axial", 0);
    q_y = NULL;
    emlrtAssign(&q_y, emlrtCreateStructMatrix(1, 1, 0, NULL));
    for (i13 = 0; i13 < 2; i13++) {
      f_u[i13] = u->data[b_j0].el_in0.axial_k.form[i13];
    }

    r_y = NULL;
    m2 = emlrtCreateCharArray(2, iv19);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m2, &f_u[0]);
    emlrtAssign(&r_y, m2);
    emlrtAddField(q_y, r_y, "form", 0);
    i13 = c_u->size[0] * c_u->size[1];
    c_u->size[0] = u->data[b_j0].el_in0.axial_k.breaks->size[0];
    c_u->size[1] = u->data[b_j0].el_in0.axial_k.breaks->size[1];
    emxEnsureCapacity((emxArray__common *)c_u, i13, (int32_T)sizeof(real_T));
    loop_ub = u->data[b_j0].el_in0.axial_k.breaks->size[0] * u->data[b_j0].
      el_in0.axial_k.breaks->size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      c_u->data[i13] = u->data[b_j0].el_in0.axial_k.breaks->data[i13];
    }

    s_y = NULL;
    m2 = emlrtCreateNumericArray(2, *(int32_T (*)[2])c_u->size, mxDOUBLE_CLASS,
      mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < c_u->size[1]; b_i++) {
      for (c_i = 0; c_i < c_u->size[0]; c_i++) {
        pData[i13] = c_u->data[c_i + c_u->size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&s_y, m2);
    emlrtAddField(q_y, s_y, "breaks", 0);
    i13 = d_u->size[0] * d_u->size[1];
    d_u->size[0] = u->data[b_j0].el_in0.axial_k.coefs->size[0];
    d_u->size[1] = u->data[b_j0].el_in0.axial_k.coefs->size[1];
    emxEnsureCapacity((emxArray__common *)d_u, i13, (int32_T)sizeof(real_T));
    loop_ub = u->data[b_j0].el_in0.axial_k.coefs->size[0] * u->data[b_j0].
      el_in0.axial_k.coefs->size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      d_u->data[i13] = u->data[b_j0].el_in0.axial_k.coefs->data[i13];
    }

    t_y = NULL;
    m2 = emlrtCreateNumericArray(2, *(int32_T (*)[2])d_u->size, mxDOUBLE_CLASS,
      mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < d_u->size[1]; b_i++) {
      for (c_i = 0; c_i < d_u->size[0]; c_i++) {
        pData[i13] = d_u->data[c_i + d_u->size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&t_y, m2);
    emlrtAddField(q_y, t_y, "coefs", 0);
    u_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.axial_k.pieces);
    emlrtAssign(&u_y, m2);
    emlrtAddField(q_y, u_y, "pieces", 0);
    v_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.axial_k.order);
    emlrtAssign(&v_y, m2);
    emlrtAddField(q_y, v_y, "order", 0);
    w_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.axial_k.dim);
    emlrtAssign(&w_y, m2);
    emlrtAddField(q_y, w_y, "dim", 0);
    emlrtAddField(f_y, q_y, "axial_k", 0);
    x_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.eps0);
    emlrtAssign(&x_y, m2);
    emlrtAddField(f_y, x_y, "eps0", 0);
    y_y = NULL;
    m2 = emlrtCreateNumericArray(2, iv20, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 36; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.K0[b_i];
    }

    emlrtAssign(&y_y, m2);
    emlrtAddField(f_y, y_y, "K0", 0);
    ab_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.p);
    emlrtAssign(&ab_y, m2);
    emlrtAddField(f_y, ab_y, "p", 0);
    bb_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.r);
    emlrtAssign(&bb_y, m2);
    emlrtAddField(f_y, bb_y, "r", 0);
    c_u_size[0] = u->data[b_j0].el_in0.alpha.size[0];
    c_u_size[1] = u->data[b_j0].el_in0.alpha.size[1];
    loop_ub = u->data[b_j0].el_in0.alpha.size[0] * u->data[b_j0].
      el_in0.alpha.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      c_u_data[i13] = u->data[b_j0].el_in0.alpha.data[i13];
    }

    cb_y = NULL;
    m2 = emlrtCreateNumericArray(2, c_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < c_u_size[1]; b_i++) {
      for (c_i = 0; c_i < c_u_size[0]; c_i++) {
        pData[i13] = c_u_data[c_i + c_u_size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&cb_y, m2);
    emlrtAddField(f_y, cb_y, "alpha", 0);
    db_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.beta);
    emlrtAssign(&db_y, m2);
    emlrtAddField(f_y, db_y, "beta", 0);
    d_u_size[0] = u->data[b_j0].el_in0.eps.size[0];
    d_u_size[1] = 2;
    loop_ub = u->data[b_j0].el_in0.eps.size[0] * u->data[b_j0].el_in0.eps.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      d_u_data[i13] = u->data[b_j0].el_in0.eps.data[i13];
    }

    eb_y = NULL;
    m2 = emlrtCreateNumericArray(2, d_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < 2; b_i++) {
      for (c_i = 0; c_i < d_u_size[0]; c_i++) {
        pData[i13] = d_u_data[c_i + d_u_size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&eb_y, m2);
    emlrtAddField(f_y, eb_y, "eps", 0);
    e_u_size[0] = u->data[b_j0].el_in0.f.size[0];
    e_u_size[1] = 2;
    loop_ub = u->data[b_j0].el_in0.f.size[0] * u->data[b_j0].el_in0.f.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      e_u_data[i13] = u->data[b_j0].el_in0.f.data[i13];
    }

    fb_y = NULL;
    m2 = emlrtCreateNumericArray(2, e_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < 2; b_i++) {
      for (c_i = 0; c_i < e_u_size[0]; c_i++) {
        pData[i13] = e_u_data[c_i + e_u_size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&fb_y, m2);
    emlrtAddField(f_y, fb_y, "f", 0);
    gb_y = NULL;
    for (i13 = 0; i13 < 2; i13++) {
      iv21[i13] = u->data[b_j0].el_in0.nodes->size[i13];
    }

    emlrtAssign(&gb_y, emlrtCreateStructArray(2, iv21, 0, NULL));
    emlrtCreateField(gb_y, "cords");
    b_i = 0;
    for (b_j1 = 0; b_j1 < u->data[b_j0].el_in0.nodes->size[1U]; b_j1++) {
      hb_y = NULL;
      for (i13 = 0; i13 < 2; i13++) {
        iv21[i13] = u->data[b_j0].el_in0.nodes->data[u->data[b_j0].
          el_in0.nodes->size[0] * b_j1].cords.size[i13];
      }

      emlrtAssign(&hb_y, emlrtCreateStructArray(2, iv21, 0, NULL));
      emlrtCreateField(hb_y, "axial");
      c_i = 0;
      for (c_j1 = 0; c_j1 < u->data[b_j0].el_in0.nodes->data[u->data[b_j0].
           el_in0.nodes->size[0] * b_j1].cords.size[1U]; c_j1++) {
        f_u_size[0] = u->data[b_j0].el_in0.nodes->data[u->data[b_j0].
          el_in0.nodes->size[0] * b_j1].cords.data[u->data[b_j0]
          .el_in0.nodes->data[u->data[b_j0].el_in0.nodes->size[0] * b_j1].
          cords.size[0] * c_j1].axial.size[0];
        f_u_size[1] = 2;
        loop_ub = u->data[b_j0].el_in0.nodes->data[u->data[b_j0]
          .el_in0.nodes->size[0] * b_j1].cords.data[u->data[b_j0]
          .el_in0.nodes->data[u->data[b_j0].el_in0.nodes->size[0] * b_j1].
          cords.size[0] * c_j1].axial.size[0] * u->data[b_j0].el_in0.nodes->
          data[u->data[b_j0].el_in0.nodes->size[0] * b_j1].cords.data[u->
          data[b_j0].el_in0.nodes->data[u->data[b_j0].el_in0.nodes->size[0] *
          b_j1].cords.size[0] * c_j1].axial.size[1];
        for (i13 = 0; i13 < loop_ub; i13++) {
          f_u_data[i13] = u->data[b_j0].el_in0.nodes->data[u->data[b_j0].
            el_in0.nodes->size[0] * b_j1].cords.data[u->data[b_j0].
            el_in0.nodes->data[u->data[b_j0].el_in0.nodes->size[0] * b_j1].
            cords.size[0] * c_j1].axial.data[i13];
        }

        ib_y = NULL;
        m2 = emlrtCreateNumericArray(2, f_u_size, mxDOUBLE_CLASS, mxREAL);
        pData = (real_T *)mxGetPr(m2);
        i13 = 0;
        for (loop_ub = 0; loop_ub < 2; loop_ub++) {
          for (d_i = 0; d_i < f_u_size[0]; d_i++) {
            pData[i13] = f_u_data[d_i + f_u_size[0] * loop_ub];
            i13++;
          }
        }

        emlrtAssign(&ib_y, m2);
        emlrtAddField(hb_y, ib_y, "axial", c_i);
        c_i++;
      }

      emlrtAddField(gb_y, hb_y, "cords", b_i);
      b_i++;
    }

    emlrtAddField(f_y, gb_y, "nodes", 0);
    jb_y = NULL;
    m2 = emlrtCreateNumericArray(1, iv22, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 5; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.propsLH[b_i];
    }

    emlrtAssign(&jb_y, m2);
    emlrtAddField(f_y, jb_y, "propsLH", 0);
    kb_y = NULL;
    m2 = emlrtCreateNumericArray(1, iv23, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 6; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.D0[b_i];
    }

    emlrtAssign(&kb_y, m2);
    emlrtAddField(f_y, kb_y, "D0", 0);
    lb_y = NULL;
    m2 = emlrtCreateNumericArray(1, iv24, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 6; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.P0[b_i];
    }

    emlrtAssign(&lb_y, m2);
    emlrtAddField(f_y, lb_y, "P0", 0);
    mb_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.n);
    emlrtAssign(&mb_y, m2);
    emlrtAddField(f_y, mb_y, "n", 0);
    nb_y = NULL;
    emlrtAssign(&nb_y, emlrtCreateStructMatrix(1, 1, 0, NULL));
    ob_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.flex.b_break);
    emlrtAssign(&ob_y, m2);
    emlrtAddField(nb_y, ob_y, "break", 0);
    pb_y = NULL;
    m2 = emlrtCreateNumericArray(2, iv25, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 25; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.flex.K[b_i];
    }

    emlrtAssign(&pb_y, m2);
    emlrtAddField(nb_y, pb_y, "K", 0);
    g_u_size[0] = 5;
    g_u_size[1] = u->data[b_j0].el_in0.flex.D.size[1];
    loop_ub = u->data[b_j0].el_in0.flex.D.size[0] * u->data[b_j0].
      el_in0.flex.D.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      g_u_data[i13] = u->data[b_j0].el_in0.flex.D.data[i13];
    }

    qb_y = NULL;
    m2 = emlrtCreateNumericArray(2, g_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < g_u_size[1]; b_i++) {
      for (c_i = 0; c_i < 5; c_i++) {
        pData[i13] = g_u_data[c_i + g_u_size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&qb_y, m2);
    emlrtAddField(nb_y, qb_y, "D", 0);
    h_u_size[0] = 5;
    h_u_size[1] = u->data[b_j0].el_in0.flex.Du.size[1];
    loop_ub = u->data[b_j0].el_in0.flex.Du.size[0] * u->data[b_j0].
      el_in0.flex.Du.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      h_u_data[i13] = u->data[b_j0].el_in0.flex.Du.data[i13];
    }

    rb_y = NULL;
    m2 = emlrtCreateNumericArray(2, h_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < h_u_size[1]; b_i++) {
      for (c_i = 0; c_i < 5; c_i++) {
        pData[i13] = h_u_data[c_i + h_u_size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&rb_y, m2);
    emlrtAddField(nb_y, rb_y, "Du", 0);
    sb_y = NULL;
    m2 = emlrtCreateNumericArray(1, iv26, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    for (b_i = 0; b_i < 5; b_i++) {
      pData[b_i] = u->data[b_j0].el_in0.flex.Q[b_i];
    }

    emlrtAssign(&sb_y, m2);
    emlrtAddField(nb_y, sb_y, "Q", 0);
    i_u_size[0] = 5;
    i_u_size[1] = 5;
    i_u_size[2] = u->data[b_j0].el_in0.flex.f.size[2];
    loop_ub = u->data[b_j0].el_in0.flex.f.size[0] * u->data[b_j0].
      el_in0.flex.f.size[1] * u->data[b_j0].el_in0.flex.f.size[2];
    for (i13 = 0; i13 < loop_ub; i13++) {
      i_u_data[i13] = u->data[b_j0].el_in0.flex.f.data[i13];
    }

    tb_y = NULL;
    m2 = emlrtCreateNumericArray(3, i_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < i_u_size[2]; b_i++) {
      for (c_i = 0; c_i < 5; c_i++) {
        for (loop_ub = 0; loop_ub < 5; loop_ub++) {
          pData[i13] = i_u_data[(loop_ub + i_u_size[0] * c_i) + i_u_size[0] *
            i_u_size[1] * b_i];
          i13++;
        }
      }
    }

    emlrtAssign(&tb_y, m2);
    emlrtAddField(nb_y, tb_y, "f", 0);
    j_u_size[0] = 5;
    j_u_size[1] = u->data[b_j0].el_in0.flex.d.size[1];
    loop_ub = u->data[b_j0].el_in0.flex.d.size[0] * u->data[b_j0].
      el_in0.flex.d.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      j_u_data[i13] = u->data[b_j0].el_in0.flex.d.data[i13];
    }

    ub_y = NULL;
    m2 = emlrtCreateNumericArray(2, j_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < j_u_size[1]; b_i++) {
      for (c_i = 0; c_i < 5; c_i++) {
        pData[i13] = j_u_data[c_i + j_u_size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&ub_y, m2);
    emlrtAddField(nb_y, ub_y, "d", 0);
    k_u_size[0] = u->data[b_j0].el_in0.flex.e.size[0];
    k_u_size[1] = u->data[b_j0].el_in0.flex.e.size[1];
    loop_ub = u->data[b_j0].el_in0.flex.e.size[0] * u->data[b_j0].
      el_in0.flex.e.size[1];
    for (i13 = 0; i13 < loop_ub; i13++) {
      k_u_data[i13] = u->data[b_j0].el_in0.flex.e.data[i13];
    }

    vb_y = NULL;
    m2 = emlrtCreateNumericArray(2, k_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = (real_T *)mxGetPr(m2);
    i13 = 0;
    for (b_i = 0; b_i < k_u_size[1]; b_i++) {
      for (c_i = 0; c_i < k_u_size[0]; c_i++) {
        pData[i13] = k_u_data[c_i + k_u_size[0] * b_i];
        i13++;
      }
    }

    emlrtAssign(&vb_y, m2);
    emlrtAddField(nb_y, vb_y, "e", 0);
    emlrtAddField(f_y, nb_y, "flex", 0);
    wb_y = NULL;
    m2 = emlrtCreateLogicalScalar(u->data[b_j0].el_in0.state_it);
    emlrtAssign(&wb_y, m2);
    emlrtAddField(f_y, wb_y, "state_it", 0);
    xb_y = NULL;
    m2 = emlrtCreateDoubleScalar(u->data[b_j0].el_in0.el);
    emlrtAssign(&xb_y, m2);
    emlrtAddField(f_y, xb_y, "el", 0);
    emlrtAddField(y, f_y, "el_in0", i);
    i++;
  }

  emxFree_real_T(&d_u);
  emxFree_real_T(&c_u);
  emxFree_real_T(&b_u);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return y;
}

static void cb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2])
{
  bc_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void cc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[3])
{
  int32_T iv39[3];
  boolean_T bv13[3] = { false, false, true };

  static const int32_T dims[3] = { 5, 5, 20 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 3U,
    dims, &bv13[0], iv39);
  ret_size[0] = iv39[0];
  ret_size[1] = iv39[1];
  ret_size[2] = iv39[2];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  int32_T sizes[1];
  boolean_T bv2[1] = { true };

  static const int32_T dims[1] = { 20000 };

  static const char * fieldNames[3] = { "el", "el_in", "el_in0" };

  int32_T i10;
  int32_T n;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckVsStructR2012b(emlrtRootTLSGlobal, parentId, u, 3, fieldNames, 1U,
    dims, &bv2[0], sizes);
  i10 = y->size[0];
  y->size[0] = sizes[0];
  emxEnsureCapacity_struct0_T(y, i10);
  n = y->size[0];
  for (i10 = 0; i10 < n; i10++) {
    thisId.fIdentifier = "el";
    e_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, i10,
      "el")), &thisId, y->data[i10].el.data, y->data[i10].el.size);
    thisId.fIdentifier = "el_in";
    f_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, i10,
      "el_in")), &thisId, &y->data[i10].el_in);
    thisId.fIdentifier = "el_in0";
    i_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, i10,
      "el_in0")), &thisId, &y->data[i10].el_in0);
  }

  emlrtDestroyArray(&u);
}

static const mxArray *d_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv27[2] = { 0, 0 };

  const mxArray *m3;
  y = NULL;
  m3 = emlrtCreateNumericArray(2, iv27, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m3, (void *)u->data);
  emlrtSetDimensions((mxArray *)m3, u->size, 2);
  emlrtAssign(&y, m3);
  return y;
}

static void db_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[3])
{
  cc_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void dc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2])
{
  int32_T iv40[2];
  boolean_T bv14[2] = { true, true };

  static const int32_T dims[2] = { 20, 20 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv14[0], iv40);
  ret_size[0] = iv40[0];
  ret_size[1] = iv40[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void e_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y_data[], int32_T y_size[2])
{
  kb_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static const mxArray *e_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv28[2] = { 0, 0 };

  const mxArray *m4;
  y = NULL;
  m4 = emlrtCreateNumericArray(2, iv28, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m4, (void *)u->data);
  emlrtSetDimensions((mxArray *)m4, u->size, 2);
  emlrtAssign(&y, m4);
  return y;
}

static void eb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2])
{
  dc_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static boolean_T ec_emlrt_marshallIn(const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  boolean_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "logical", false, 0U,
    &dims);
  ret = *mxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void emlrt_marshallIn(const mxArray *con, const char_T *identifier,
  real_T **y_data, int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(emlrtAlias(con), &thisId, y_data, y_size);
  emlrtDestroyArray(&con);
}

static void f_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct1_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[2] = { "nodes_ij", "orient_ij" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(emlrtRootTLSGlobal, parentId, u, 2, fieldNames, 0U,
    &dims);
  thisId.fIdentifier = "nodes_ij";
  g_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "nodes_ij")), &thisId, y->nodes_ij);
  thisId.fIdentifier = "orient_ij";
  h_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "orient_ij")), &thisId, y->orient_ij);
  emlrtDestroyArray(&u);
}

static const mxArray *f_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  static const int32_T iv29[2] = { 0, 0 };

  const mxArray *m5;
  y = NULL;
  m5 = emlrtCreateNumericArray(2, iv29, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m5, (void *)u->data);
  emlrtSetDimensions((mxArray *)m5, u->size, 2);
  emlrtAssign(&y, m5);
  return y;
}

static boolean_T fb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier *
  parentId)
{
  boolean_T y;
  y = ec_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void fc_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  int32_T iv41[3];
  boolean_T bv15[3] = { true, false, false };

  static const int32_T dims[3] = { 20000, 12, 4 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 3U,
    dims, &bv15[0], iv41);
  ret->size[0] = iv41[0];
  ret->size[1] = iv41[1];
  ret->size[2] = iv41[2];
  ret->allocatedSize = ret->size[0] * ret->size[1] * ret->size[2];
  ret->data = (real_T *)mxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void g_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[6])
{
  lb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *g_emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[1])
{
  const mxArray *y;
  static const int32_T iv30[1] = { 0 };

  const mxArray *m6;
  y = NULL;
  m6 = emlrtCreateNumericArray(1, iv30, mxDOUBLE_CLASS, mxREAL);
  mxSetData((mxArray *)m6, (void *)u_data);
  emlrtSetDimensions((mxArray *)m6, u_size, 1);
  emlrtAssign(&y, m6);
  return y;
}

static void gb_emlrt_marshallIn(const mxArray *U_input, const char_T *identifier,
  emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  hb_emlrt_marshallIn(emlrtAlias(U_input), &thisId, y);
  emlrtDestroyArray(&U_input);
}

static void h_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[3])
{
  mb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void hb_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  fc_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void i_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct2_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[21] = { "break", "mat", "geom", "axial",
    "axial_k", "eps0", "K0", "p", "r", "alpha", "beta", "eps", "f", "nodes",
    "propsLH", "D0", "P0", "n", "flex", "state_it", "el" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(emlrtRootTLSGlobal, parentId, u, 21, fieldNames, 0U,
    &dims);
  thisId.fIdentifier = "break";
  y->b_break = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a
    (emlrtRootTLSGlobal, u, 0, "break")), &thisId);
  thisId.fIdentifier = "mat";
  k_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "mat")), &thisId, y->mat);
  thisId.fIdentifier = "geom";
  l_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "geom")), &thisId, y->geom);
  thisId.fIdentifier = "axial";
  m_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "axial")), &thisId, &y->axial);
  thisId.fIdentifier = "axial_k";
  q_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "axial_k")), &thisId, &y->axial_k);
  thisId.fIdentifier = "eps0";
  y->eps0 = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal,
    u, 0, "eps0")), &thisId);
  thisId.fIdentifier = "K0";
  r_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "K0")), &thisId, y->K0);
  thisId.fIdentifier = "p";
  y->p = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u,
    0, "p")), &thisId);
  thisId.fIdentifier = "r";
  y->r = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u,
    0, "r")), &thisId);
  thisId.fIdentifier = "alpha";
  s_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "alpha")), &thisId, y->alpha.data, y->alpha.size);
  thisId.fIdentifier = "beta";
  y->beta = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal,
    u, 0, "beta")), &thisId);
  thisId.fIdentifier = "eps";
  t_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "eps")), &thisId, y->eps.data, y->eps.size);
  thisId.fIdentifier = "f";
  t_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "f")), &thisId, y->f.data, y->f.size);
  thisId.fIdentifier = "nodes";
  u_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "nodes")), &thisId, y->nodes);
  thisId.fIdentifier = "propsLH";
  x_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "propsLH")), &thisId, y->propsLH);
  thisId.fIdentifier = "D0";
  y_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "D0")), &thisId, y->D0);
  thisId.fIdentifier = "P0";
  y_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "P0")), &thisId, y->P0);
  thisId.fIdentifier = "n";
  y->n = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u,
    0, "n")), &thisId);
  thisId.fIdentifier = "flex";
  ab_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "flex")), &thisId, &y->flex);
  thisId.fIdentifier = "state_it";
  y->state_it = fb_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a
    (emlrtRootTLSGlobal, u, 0, "state_it")), &thisId);
  thisId.fIdentifier = "el";
  y->el = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal,
    u, 0, "el")), &thisId);
  emlrtDestroyArray(&u);
}

static boolean_T ib_emlrt_marshallIn(const mxArray *par, const char_T
  *identifier)
{
  boolean_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = fb_emlrt_marshallIn(emlrtAlias(par), &thisId);
  emlrtDestroyArray(&par);
  return y;
}

static real_T j_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = nb_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void jb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T **ret_data, int32_T ret_size[2])
{
  int32_T iv31[2];
  boolean_T bv5[2] = { true, false };

  static const int32_T dims[2] = { 20000, 2 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv5[0], iv31);
  ret_size[0] = iv31[0];
  ret_size[1] = iv31[1];
  *ret_data = (real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
}

static void k_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[2])
{
  ob_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void kb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret_data[], int32_T ret_size[2])
{
  int32_T iv32[2];
  boolean_T bv6[2] = { false, true };

  static const int32_T dims[2] = { 1, 20 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
    dims, &bv6[0], iv32);
  ret_size[0] = iv32[0];
  ret_size[1] = iv32[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 1, false);
  emlrtDestroyArray(&src);
}

static void l_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[5])
{
  pb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void lb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[6])
{
  static const int32_T dims[2] = { 2, 3 };

  int32_T i14;
  int32_T i15;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  for (i14 = 0; i14 < 3; i14++) {
    for (i15 = 0; i15 < 2; i15++) {
      ret[i15 + (i14 << 1)] = (*(real_T (*)[6])mxGetData(src))[i15 + (i14 << 1)];
    }
  }

  emlrtDestroyArray(&src);
}

static void m_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct3_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[6] = { "form", "breaks", "coefs", "pieces",
    "order", "dim" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(emlrtRootTLSGlobal, parentId, u, 6, fieldNames, 0U,
    &dims);
  thisId.fIdentifier = "form";
  n_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "form")), &thisId, y->form);
  thisId.fIdentifier = "breaks";
  o_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "breaks")), &thisId, y->breaks.data, y->breaks.size);
  thisId.fIdentifier = "coefs";
  p_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "coefs")), &thisId, y->coefs);
  thisId.fIdentifier = "pieces";
  y->pieces = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a
    (emlrtRootTLSGlobal, u, 0, "pieces")), &thisId);
  thisId.fIdentifier = "order";
  y->order = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a
    (emlrtRootTLSGlobal, u, 0, "order")), &thisId);
  thisId.fIdentifier = "dim";
  y->dim = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal,
    u, 0, "dim")), &thisId);
  emlrtDestroyArray(&u);
}

static void mb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[3])
{
  static const int32_T dims[2] = { 1, 3 };

  int32_T i16;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  for (i16 = 0; i16 < 3; i16++) {
    ret[i16] = (*(real_T (*)[3])mxGetData(src))[i16];
  }

  emlrtDestroyArray(&src);
}

static void n_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[2])
{
  qb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T nb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U,
    &dims);
  ret = *(real_T *)mxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void o_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2])
{
  rb_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void ob_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[2])
{
  static const int32_T dims[2] = { 1, 2 };

  int32_T i17;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  for (i17 = 0; i17 < 2; i17++) {
    ret[i17] = (*(real_T (*)[2])mxGetData(src))[i17];
  }

  emlrtDestroyArray(&src);
}

static void p_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  sb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void pb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[5])
{
  static const int32_T dims[2] = { 1, 5 };

  int32_T i18;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  for (i18 = 0; i18 < 5; i18++) {
    ret[i18] = (*(real_T (*)[5])mxGetData(src))[i18];
  }

  emlrtDestroyArray(&src);
}

static void q_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct4_T *y)
{
  emlrtMsgIdentifier thisId;
  static const int32_T dims = 0;
  static const char * fieldNames[6] = { "form", "breaks", "coefs", "pieces",
    "order", "dim" };

  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(emlrtRootTLSGlobal, parentId, u, 6, fieldNames, 0U,
    &dims);
  thisId.fIdentifier = "form";
  n_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "form")), &thisId, y->form);
  thisId.fIdentifier = "breaks";
  p_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "breaks")), &thisId, y->breaks);
  thisId.fIdentifier = "coefs";
  p_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, 0,
    "coefs")), &thisId, y->coefs);
  thisId.fIdentifier = "pieces";
  y->pieces = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a
    (emlrtRootTLSGlobal, u, 0, "pieces")), &thisId);
  thisId.fIdentifier = "order";
  y->order = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a
    (emlrtRootTLSGlobal, u, 0, "order")), &thisId);
  thisId.fIdentifier = "dim";
  y->dim = j_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal,
    u, 0, "dim")), &thisId);
  emlrtDestroyArray(&u);
}

static void qb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[2])
{
  static const int32_T dims[2] = { 1, 2 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
    dims);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, ret, 2);
  emlrtDestroyArray(&src);
}

static void r_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[36])
{
  tb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void rb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2])
{
  int32_T iv33[2];
  boolean_T bv7[2] = { false, true };

  static const int32_T dims[2] = { 1, 500 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv7[0], iv33);
  ret_size[0] = iv33[0];
  ret_size[1] = iv33[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void s_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2])
{
  ub_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void sb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  int32_T iv34[2];
  boolean_T bv8[2] = { true, true };

  static const int32_T dims[2] = { 500, 500 };

  int32_T i19;
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv8[0], iv34);
  i19 = ret->size[0] * ret->size[1];
  ret->size[0] = iv34[0];
  ret->size[1] = iv34[1];
  emxEnsureCapacity((emxArray__common *)ret, i19, (int32_T)sizeof(real_T));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, ret->data, 8, false);
  emlrtDestroyArray(&src);
}

static void t_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2])
{
  vb_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void tb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[36])
{
  static const int32_T dims[2] = { 6, 6 };

  int32_T i20;
  int32_T i21;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  for (i20 = 0; i20 < 6; i20++) {
    for (i21 = 0; i21 < 6; i21++) {
      ret[i21 + 6 * i20] = (*(real_T (*)[36])mxGetData(src))[i21 + 6 * i20];
    }
  }

  emlrtDestroyArray(&src);
}

static void u_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_struct5_T *y)
{
  emlrtMsgIdentifier thisId;
  int32_T sizes[2];
  boolean_T bv3[2] = { false, true };

  static const int32_T dims[2] = { 1, 20 };

  static const char * fieldNames[1] = { "cords" };

  int32_T i11;
  int32_T n;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckVsStructR2012b(emlrtRootTLSGlobal, parentId, u, 1, fieldNames, 2U,
    dims, &bv3[0], sizes);
  i11 = y->size[0] * y->size[1];
  y->size[0] = sizes[0];
  y->size[1] = sizes[1];
  emxEnsureCapacity_struct5_T(y, i11);
  n = y->size[1];
  for (i11 = 0; i11 < n; i11++) {
    thisId.fIdentifier = "cords";
    v_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, i11,
      "cords")), &thisId, y->data[i11].cords.data, y->data[i11].cords.size);
  }

  emlrtDestroyArray(&u);
}

static void ub_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2])
{
  int32_T iv35[2];
  boolean_T bv9[2] = { true, true };

  static const int32_T dims[2] = { 5, 20 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv9[0], iv35);
  ret_size[0] = iv35[0];
  ret_size[1] = iv35[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void v_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, struct6_T y_data[], int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  int32_T sizes[2];
  boolean_T bv4[2] = { false, true };

  static const int32_T dims[2] = { 1, 5 };

  static const char * fieldNames[1] = { "axial" };

  int32_T n;
  int32_T i12;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckVsStructR2012b(emlrtRootTLSGlobal, parentId, u, 1, fieldNames, 2U,
    dims, &bv4[0], sizes);
  y_size[0] = sizes[0];
  y_size[1] = sizes[1];
  n = y_size[1];
  for (i12 = 0; i12 < n; i12++) {
    thisId.fIdentifier = "axial";
    w_emlrt_marshallIn(emlrtAlias(emlrtGetFieldR2013a(emlrtRootTLSGlobal, u, i12,
      "axial")), &thisId, y_data[i12].axial.data, y_data[i12].axial.size);
  }

  emlrtDestroyArray(&u);
}

static void vb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2])
{
  int32_T iv36[2];
  boolean_T bv10[2] = { true, false };

  static const int32_T dims[2] = { 5, 2 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv10[0], iv36);
  ret_size[0] = iv36[0];
  ret_size[1] = iv36[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void w_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y_data[], int32_T y_size[2])
{
  wb_emlrt_marshallIn(emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

static void wb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret_data[], int32_T ret_size[2])
{
  int32_T iv37[2];
  boolean_T bv11[2] = { true, false };

  static const int32_T dims[2] = { 1000, 2 };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims, &bv11[0], iv37);
  ret_size[0] = iv37[0];
  ret_size[1] = iv37[1];
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, (void *)ret_data, 8, false);
  emlrtDestroyArray(&src);
}

static void x_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[5])
{
  xb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void xb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[5])
{
  static const int32_T dims[1] = { 5 };

  int32_T i22;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims);
  for (i22 = 0; i22 < 5; i22++) {
    ret[i22] = (*(real_T (*)[5])mxGetData(src))[i22];
  }

  emlrtDestroyArray(&src);
}

static void y_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, real_T y[6])
{
  yb_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void yb_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, real_T ret[6])
{
  static const int32_T dims[1] = { 6 };

  int32_T i23;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 1U,
    dims);
  for (i23 = 0; i23 < 6; i23++) {
    ret[i23] = (*(real_T (*)[6])mxGetData(src))[i23];
  }

  emlrtDestroyArray(&src);
}

void assemble_prebody_api(const mxArray * const prhs[4], const mxArray *plhs[9])
{
  real_T (*break_iter_data)[20000];
  emxArray_struct0_T *EL;
  emxArray_real_T *U_input;
  emxArray_real_T *fint_i;
  emxArray_real_T *Fint_i;
  emxArray_real_T *dof_Fint;
  emxArray_real_T *Kel;
  emxArray_real_T *dof_i;
  emxArray_real_T *dof_j;
  emxArray_real_T *ROT;
  int32_T con_size[2];
  real_T (*con_data)[40000];
  boolean_T par;
  int32_T break_iter_size[1];
  break_iter_data = (real_T (*)[20000])mxMalloc(sizeof(real_T [20000]));
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_struct0_T(&EL, 1, true);
  emxInit_real_T1(emlrtRootTLSGlobal, &U_input, 3, true);
  emxInit_real_T(emlrtRootTLSGlobal, &fint_i, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &Fint_i, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &dof_Fint, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &Kel, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &dof_i, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &dof_j, 2, true);
  emxInit_real_T(emlrtRootTLSGlobal, &ROT, 2, true);

  /* Marshall function inputs */
  emlrt_marshallIn(emlrtAlias(prhs[0]), "con", (real_T **)&con_data, con_size);
  c_emlrt_marshallIn(emlrtAliasP(prhs[1]), "EL", EL);
  gb_emlrt_marshallIn(emlrtAlias(prhs[2]), "U_input", U_input);
  par = ib_emlrt_marshallIn(emlrtAliasP(prhs[3]), "par");

  /* Invoke the target function */
  assemble_prebody(emlrtRootTLSGlobal, *con_data, con_size, EL, U_input, par,
                   fint_i, Fint_i, dof_Fint, Kel, dof_i, dof_j, ROT,
                   *break_iter_data, break_iter_size);

  /* Marshall function outputs */
  plhs[0] = c_emlrt_marshallOut(EL);
  plhs[1] = d_emlrt_marshallOut(fint_i);
  plhs[2] = d_emlrt_marshallOut(Fint_i);
  plhs[3] = d_emlrt_marshallOut(dof_Fint);
  plhs[4] = e_emlrt_marshallOut(Kel);
  plhs[5] = e_emlrt_marshallOut(dof_i);
  plhs[6] = e_emlrt_marshallOut(dof_j);
  plhs[7] = f_emlrt_marshallOut(ROT);
  plhs[8] = g_emlrt_marshallOut(*break_iter_data, break_iter_size);
  ROT->canFreeData = false;
  emxFree_real_T(&ROT);
  dof_j->canFreeData = false;
  emxFree_real_T(&dof_j);
  dof_i->canFreeData = false;
  emxFree_real_T(&dof_i);
  Kel->canFreeData = false;
  emxFree_real_T(&Kel);
  dof_Fint->canFreeData = false;
  emxFree_real_T(&dof_Fint);
  Fint_i->canFreeData = false;
  emxFree_real_T(&Fint_i);
  fint_i->canFreeData = false;
  emxFree_real_T(&fint_i);
  U_input->canFreeData = false;
  emxFree_real_T(&U_input);
  emxFree_struct0_T(&EL);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (_coder_assemble_prebody_api.c) */
