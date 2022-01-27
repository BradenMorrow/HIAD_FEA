/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_KL_P_flex_shear_iter.c
 *
 * Code generation for function 'get_KL_P_flex_shear_iter'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_KL_P_flex_shear_iter.h"
#include "assemble_prebody_emxutil.h"
#include "sind.h"
#include "cosd.h"
#include "interp1.h"
#include "sum.h"
#include "mldivide.h"
#include "mpower.h"
#include "diag.h"
#include "abs.h"
#include "get_GL.h"

/* Function Definitions */
void get_KL_P_flex_shear_iter(emlrtCTX aTLS, real_T el_in_p, real_T el_in_r,
  const real_T el_in_alpha_data[], const int32_T el_in_alpha_size[2], real_T
  el_in_beta, const emxArray_struct5_T *el_in_nodes, const real_T el_in_propsLH
  [5], real_T el_in_n, const real_T el_in_flex_K[25], const emxArray_real_T
  *el_in_flex_D, const real_T el_in_flex_Q[5], const real_T el_in_flex_f_data[],
  const int32_T el_in_flex_f_size[3], const real_T el_in_flex_d_data[], const
  int32_T el_in_flex_d_size[2], const real_T el_in_flex_e_data[], const int32_T
  el_in_flex_e_size[2], boolean_T el_in_state_it, const real_T el_in_D[6], const
  real_T el_in_dD[6], real_T el_in_L, real_T KL[36], real_T P[6], struct_T
  *el_out)
{
  real_T EL;
  real_T GLH;
  real_T t;
  real_T A;
  real_T I;
  real_T K[25];
  int32_T D_size_idx_1;
  int32_T loop_ub;
  int32_T i0;
  real_T D_data[100];
  real_T Q[5];
  int32_T i;
  real_T f_data[500];
  real_T d_data[100];
  int32_T e_size_idx_0;
  real_T e_data[400];
  emxArray_real_T *l;
  int32_T xi_size[1];
  real_T x_data[5];
  int32_T wi_size[1];
  real_T EA_data[5];
  emxArray_real_T *b;
  emxArray_real_T *dD;
  emxArray_real_T *dd;
  emxArray_real_T *r;
  emxArray_real_T *de;
  emxArray_real_T *sig;
  emxArray_real_T *EA;
  emxArray_real_T *k;
  emxArray_real_T *Dr;
  emxArray_real_T *Du;
  emxArray_real_T *Fi;
  real_T F[25];
  real_T wi_data[10];
  real_T xi_data[10];
  real_T s[5];
  real_T dq[5];
  real_T j;
  real_T conv;
  int8_T iv2[2];
  real_T tol_D_data[100];
  real_T EC;
  int32_T iterate;
  emxArray_real_T *tol_a;
  emxArray_real_T *r0;
  real_T dQ[5];
  int32_T kAcol;
  real_T x;
  static const int8_T iv3[5] = { 1, 0, 0, 0, 0 };

  real_T d0;
  real_T a_data[15];
  real_T b_b[3];
  int32_T ixstart;
  real_T C_data[5];
  real_T b_s;
  real_T smax;
  char_T TRANSB;
  char_T TRANSA;
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  real_T y_data[20];
  int32_T m;
  real_T el_in_nodes_data[1000];
  int32_T el_in_nodes_size[1];
  real_T b_el_in_nodes_data[1000];
  int32_T b_el_in_nodes_size[1];
  real_T e[2];
  real_T b_e[2];
  real_T force[2];
  real_T b_a_data[15];
  int32_T temp;
  int32_T EA_size[1];
  int32_T b_size[2];
  real_T b_data[25];
  real_T b_y_data[15];
  int32_T iy;
  boolean_T guard1 = false;
  real_T y[9];
  real_T b_EL[5];
  int32_T b_j;
  real_T b_A[25];
  static const int8_T B[25] = { 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0,
    0, 0, 1, 0, 0, 0, 0, 0, 1 };

  int8_T n;
  int32_T sig_size[1];
  real_T dv1[5];
  static const int8_T iv4[5] = { 0, 1, 1, 1, 1 };

  int8_T ipiv[5];
  int32_T ix;
  real_T b_D_data[100];
  int32_T D_size[2];
  emxArray_real_T c_D_data;
  real_T tol_b_data[100];
  boolean_T b_x_data[100];
  real_T J;
  emlrtHeapReferenceStackEnterFcnR2012b(aTLS);

  /* GET_KL_P_FLEX */
  /*    Calculate the element stiffness matrix and element forces using the */
  /*    flexibility method.  Following Taucer et al. (1991), A Fiber */
  /*    Beam-Column Element... */
  /*    Shear deformability from Marini and Spacone (2006), Analysis of */
  /*    Reinforced Concrete Elemnents Including Shear Effects */
  /*  Extract variables */
  /*  Element length */
  /*  Radius of tube */
  /*  Fiber constitutive relationships */
  /*  Internal pressure */
  /*  Braid angle */
  EL = el_in_propsLH[0];

  /*  Longitudinal modulus */
  GLH = el_in_propsLH[2];

  /*  Inplane shear modulus */
  t = 3.0 * el_in_propsLH[4];

  /*  Shell thickness */
  A = 6.2831853071795862 * el_in_r * t;

  /*  Shell area */
  I = 3.1415926535897931 * b_mpower(el_in_r) * t;

  /*  Shell moment of inertia */
  /*  State determination variables */
  memcpy(&K[0], &el_in_flex_K[0], 25U * sizeof(real_T));

  /*  Element stiffness */
  D_size_idx_1 = el_in_flex_D->size[1];
  loop_ub = el_in_flex_D->size[0] * el_in_flex_D->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    D_data[i0] = el_in_flex_D->data[i0];
  }

  /*  Section forces */
  for (i = 0; i < 5; i++) {
    Q[i] = el_in_flex_Q[i];
  }

  /*  Element forces */
  loop_ub = el_in_flex_f_size[0] * el_in_flex_f_size[1] * el_in_flex_f_size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    f_data[i0] = el_in_flex_f_data[i0];
  }

  /*  Section compliance matrices */
  loop_ub = el_in_flex_d_size[0] * el_in_flex_d_size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    d_data[i0] = el_in_flex_d_data[i0];
  }

  /*  Section deformations */
  e_size_idx_0 = el_in_flex_e_size[0];
  loop_ub = el_in_flex_e_size[0] * el_in_flex_e_size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    e_data[i0] = el_in_flex_e_data[i0];
  }

  emxInit_real_T1(aTLS, &l, 3, true);

  /*  Section fiber strains */
  /*  Iterative or non-iterative state determination procedure */
  /*  Number of integration points */
  /*  Initialize */
  /*  Location of fibers */
  i0 = l->size[0] * l->size[1] * l->size[2];
  l->size[0] = el_in_alpha_size[0];
  l->size[1] = 3;
  l->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)l, i0, (int32_T)sizeof(real_T));
  loop_ub = el_in_alpha_size[0] * 3 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    l->data[i0] = 0.0;
  }

  for (i = 0; i < (int32_T)el_in_n; i++) {
    loop_ub = el_in_alpha_size[0];
    xi_size[0] = el_in_alpha_size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      x_data[i0] = el_in_alpha_data[i0 + el_in_alpha_size[0] * i];
    }

    cosd(x_data, xi_size);
    loop_ub = xi_size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      x_data[i0] *= -el_in_r;
    }

    loop_ub = el_in_alpha_size[0];
    wi_size[0] = el_in_alpha_size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      EA_data[i0] = el_in_alpha_data[i0 + el_in_alpha_size[0] * i];
    }

    sind(EA_data, wi_size);
    loop_ub = wi_size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      EA_data[i0] *= el_in_r;
    }

    loop_ub = el_in_alpha_size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      l->data[i0 + l->size[0] * l->size[1] * i] = 1.0;
    }

    loop_ub = xi_size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      l->data[(i0 + l->size[0]) + l->size[0] * l->size[1] * i] = x_data[i0];
    }

    loop_ub = wi_size[0];
    for (i0 = 0; i0 < loop_ub; i0++) {
      l->data[(i0 + (l->size[0] << 1)) + l->size[0] * l->size[1] * i] =
        EA_data[i0];
    }

    /*  Location of fibers (cartesian) */
  }

  emxInit_real_T1(aTLS, &b, 3, true);

  /*  Initialize */
  i0 = b->size[0] * b->size[1] * b->size[2];
  b->size[0] = 5;
  b->size[1] = 5;
  b->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)b, i0, (int32_T)sizeof(real_T));
  loop_ub = 25 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    b->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &dD, 2, true);

  /*  Force interpolation functions */
  i0 = dD->size[0] * dD->size[1];
  dD->size[0] = 5;
  dD->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)dD, i0, (int32_T)sizeof(real_T));
  loop_ub = 5 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    dD->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &dd, 2, true);

  /*  Section force increment */
  i0 = dd->size[0] * dd->size[1];
  dd->size[0] = 5;
  dd->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)dd, i0, (int32_T)sizeof(real_T));
  loop_ub = 5 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    dd->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &r, 2, true);

  /*  Section deformation increment */
  i0 = r->size[0] * r->size[1];
  r->size[0] = 5;
  r->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)r, i0, (int32_T)sizeof(real_T));
  loop_ub = 5 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    r->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &de, 2, true);

  /*  Residual deformations */
  i0 = de->size[0] * de->size[1];
  de->size[0] = l->size[0];
  de->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)de, i0, (int32_T)sizeof(real_T));
  loop_ub = l->size[0] * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    de->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &sig, 2, true);

  /*  Fiber strain increments */
  i0 = sig->size[0] * sig->size[1];
  sig->size[0] = l->size[0];
  sig->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)sig, i0, (int32_T)sizeof(real_T));
  loop_ub = l->size[0] * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    sig->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &EA, 2, true);

  /*  Fiber force */
  i0 = EA->size[0] * EA->size[1];
  EA->size[0] = l->size[0];
  EA->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)EA, i0, (int32_T)sizeof(real_T));
  loop_ub = l->size[0] * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    EA->data[i0] = 0.0;
  }

  emxInit_real_T1(aTLS, &k, 3, true);

  /*  Fiber stiffness */
  i0 = k->size[0] * k->size[1] * k->size[2];
  k->size[0] = 5;
  k->size[1] = 5;
  k->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)k, i0, (int32_T)sizeof(real_T));
  loop_ub = 25 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    k->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &Dr, 2, true);

  /*  Section stiffness matrix */
  i0 = Dr->size[0] * Dr->size[1];
  Dr->size[0] = 5;
  Dr->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)Dr, i0, (int32_T)sizeof(real_T));
  loop_ub = 5 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    Dr->data[i0] = 0.0;
  }

  emxInit_real_T(aTLS, &Du, 2, true);

  /*  Section resisting forces */
  i0 = Du->size[0] * Du->size[1];
  Du->size[0] = 5;
  Du->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)Du, i0, (int32_T)sizeof(real_T));
  loop_ub = 5 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    Du->data[i0] = 0.0;
  }

  emxInit_real_T1(aTLS, &Fi, 3, true);

  /*  Section unbalanced forces */
  i0 = Fi->size[0] * Fi->size[1] * Fi->size[2];
  Fi->size[0] = 5;
  Fi->size[1] = 5;
  Fi->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)Fi, i0, (int32_T)sizeof(real_T));
  loop_ub = 25 * (int32_T)el_in_n;
  for (i0 = 0; i0 < loop_ub; i0++) {
    Fi->data[i0] = 0.0;
  }

  /*  Element flexibility matrix at section */
  memset(&F[0], 0, 25U * sizeof(real_T));

  /*  Element flexibility matrix */
  /*  Residual element deformations */
  /*  Residual element deformations */
  /*  Gauss-Lobatto integration constants */
  get_GL(el_in_n, xi_data, xi_size, wi_data, wi_size);

  /*  Fiber beam element state determination (Taucer et al. 1991, pg 59) */
  /*  (1) Solve global system of equations and update structure displacements */
  /*  Global */
  /*  (2) Update element deformations, q, (D in corotational formulation) */
  for (i = 0; i < 5; i++) {
    s[i] = 0.0;
    dq[i] = el_in_dD[i];
  }

  /*  Taucer notation */
  /*  (3) Start fiber beam-column element state determination */
  j = 0.0;
  conv = 1.0;
  for (i0 = 0; i0 < 2; i0++) {
    iv2[i0] = (int8_T)el_in_flex_D->size[i0];
  }

  loop_ub = 5 * iv2[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    tol_D_data[i0] = 0.0;
  }

  EC = 5.0 * el_in_n;
  iterate = 1;
  emxInit_real_T(aTLS, &tol_a, 2, true);
  emxInit_real_T(aTLS, &r0, 2, true);
  while (iterate != 0) {
    j++;

    /*  (4) Compute the element force increments */
    /*  Change in element forces */
    /*  (5) Update the element forces */
    for (i0 = 0; i0 < 5; i0++) {
      dQ[i0] = 0.0;
      for (kAcol = 0; kAcol < 5; kAcol++) {
        dQ[i0] += K[i0 + 5 * kAcol] * dq[kAcol];
      }

      Q[i0] += dQ[i0];
    }

    /*  New element forces */
    /*  Loop through sections */
    for (i = 0; i < (int32_T)el_in_n; i++) {
      x = el_in_L / 2.0 * xi_data[i] + el_in_L / 2.0;

      /*  Force interpolation at sections */
      /*  [axial Mz My Vz Vy]' */
      for (i0 = 0; i0 < 5; i0++) {
        b->data[b->size[0] * i0 + b->size[0] * b->size[1] * i] = iv3[i0];
      }

      b->data[1 + b->size[0] * b->size[1] * i] = 0.0;
      b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 1] = x / el_in_L -
        1.0;
      b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 1] = x /
        el_in_L;
      b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 1] = 0.0;
      b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 1] = 0.0;
      b->data[2 + b->size[0] * b->size[1] * i] = 0.0;
      b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 2] = 0.0;
      b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 2] = 0.0;
      b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 2] = x / el_in_L
        - 1.0;
      b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 2] = x /
        el_in_L;
      b->data[3 + b->size[0] * b->size[1] * i] = 0.0;
      b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 3] = -1.0 / el_in_L;
      b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 3] = -1.0 /
        el_in_L;
      b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 3] = 0.0;
      b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 3] = 0.0;
      b->data[4 + b->size[0] * b->size[1] * i] = 0.0;
      b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 4] = 0.0;
      b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 4] = 0.0;
      b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 4] = 1.0 /
        el_in_L;
      b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 4] = 1.0 /
        el_in_L;

      /*  (6) Compute the section force increments */
      /*  Section force increment */
      for (i0 = 0; i0 < 5; i0++) {
        dD->data[i0 + dD->size[0] * i] = 0.0;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          dD->data[i0 + dD->size[0] * i] += b->data[(i0 + b->size[0] * kAcol) +
            b->size[0] * b->size[1] * i] * dQ[kAcol];
        }
      }

      for (i0 = 0; i0 < 5; i0++) {
        D_data[i0 + 5 * i] += dD->data[i0 + dD->size[0] * i];
      }

      /*  (7) Compute the section deformation increments */
      for (i0 = 0; i0 < 5; i0++) {
        d0 = 0.0;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          d0 += f_data[(i0 + 5 * kAcol) + 25 * i] * dD->data[kAcol + dD->size[0]
            * i];
        }

        dd->data[i0 + dd->size[0] * i] = d0 + r->data[i0 + r->size[0] * i];
      }

      for (i0 = 0; i0 < 5; i0++) {
        d_data[i0 + 5 * i] += dd->data[i0 + dd->size[0] * i];
      }

      /*  (8) Compute the fiber deformation increments */
      loop_ub = l->size[0];
      for (i0 = 0; i0 < 3; i0++) {
        for (kAcol = 0; kAcol < loop_ub; kAcol++) {
          a_data[kAcol + loop_ub * i0] = l->data[(kAcol + l->size[0] * i0) +
            l->size[0] * l->size[1] * i];
        }
      }

      for (i0 = 0; i0 < 3; i0++) {
        b_b[i0] = dd->data[i0 + dd->size[0] * i];
      }

      i0 = l->size[0];
      ixstart = (int8_T)i0;
      for (kAcol = 0; kAcol < ixstart; kAcol++) {
        C_data[kAcol] = 0.0;
      }

      kAcol = l->size[0];
      if (kAcol < 1) {
      } else {
        b_s = 1.0;
        smax = 0.0;
        TRANSB = 'N';
        TRANSA = 'N';
        kAcol = l->size[0];
        m_t = (ptrdiff_t)kAcol;
        n_t = (ptrdiff_t)1;
        k_t = (ptrdiff_t)3;
        kAcol = l->size[0];
        lda_t = (ptrdiff_t)kAcol;
        ldb_t = (ptrdiff_t)3;
        kAcol = l->size[0];
        ldc_t = (ptrdiff_t)kAcol;
        dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &b_s, &a_data[0], &lda_t,
              &b_b[0], &ldb_t, &smax, &C_data[0], &ldc_t);
      }

      loop_ub = (int8_T)i0;
      for (i0 = 0; i0 < loop_ub; i0++) {
        de->data[i0 + de->size[0] * i] = C_data[i0];
      }

      for (i0 = 0; i0 < e_size_idx_0; i0++) {
        y_data[i0] = e_data[i0 + e_size_idx_0 * i] + de->data[i0 + de->size[0] *
          i];
      }

      for (i0 = 0; i0 < e_size_idx_0; i0++) {
        e_data[i0 + e_size_idx_0 * i] = y_data[i0];
      }

      /*  (9) Compute fiber stresses and tangent moduli */
      /*  Determine current fiber force and stiffness */
      /*  'spline'; % 'pchip'; % */
      for (m = 0; m < el_in_alpha_size[0]; m++) {
        /*  Fibers */
        /*  Extract cord force - strain relationship */
        /*  Calculate cord stiffness */
        loop_ub = el_in_nodes->data[i].cords.data[m].axial.size[0];
        el_in_nodes_size[0] = loop_ub;
        for (i0 = 0; i0 < loop_ub; i0++) {
          el_in_nodes_data[i0] = el_in_nodes->data[i].cords.data[m]
            .axial.data[i0 + el_in_nodes->data[i].cords.data[m].axial.size[0]];
        }

        loop_ub = el_in_nodes->data[i].cords.data[m].axial.size[0];
        b_el_in_nodes_size[0] = loop_ub;
        for (i0 = 0; i0 < loop_ub; i0++) {
          b_el_in_nodes_data[i0] = el_in_nodes->data[i].cords.data[m]
            .axial.data[i0];
        }

        e[0] = e_data[m + e_size_idx_0 * i];
        e[1] = e_data[m + e_size_idx_0 * i] + 1.0E-10;
        for (i0 = 0; i0 < 2; i0++) {
          b_e[i0] = e[i0];
        }

        interp1(el_in_nodes_data, el_in_nodes_size, b_el_in_nodes_data,
                b_el_in_nodes_size, b_e, force);
        sig->data[m + sig->size[0] * i] = force[0];

        /*  force_up = interp1(axial(:,2),axial(:,1),e(m,i) + tol1,interp_meth); */
        EA->data[m + EA->size[0] * i] = (force[1] - force[0]) / 1.0E-10;
      }

      /*  (10) Compute the section tangent stiffness and flexibility matrices */
      /*  Tangent stiffness */
      for (i0 = 0; i0 < 5; i0++) {
        for (kAcol = 0; kAcol < 5; kAcol++) {
          k->data[(kAcol + k->size[0] * i0) + k->size[0] * k->size[1] * i] = 0.0;
        }
      }

      loop_ub = l->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        for (kAcol = 0; kAcol < 3; kAcol++) {
          b_a_data[kAcol + 3 * i0] = l->data[(i0 + l->size[0] * kAcol) + l->
            size[0] * l->size[1] * i];
        }
      }

      temp = EA->size[0];
      EA_size[0] = temp;
      for (i0 = 0; i0 < temp; i0++) {
        EA_data[i0] = EA->data[i0 + EA->size[0] * i];
      }

      diag(EA_data, EA_size, b_data, b_size);
      if ((loop_ub == 1) || (b_size[0] == 1)) {
        ixstart = b_size[1];
        for (i0 = 0; i0 < 3; i0++) {
          temp = b_size[1];
          for (kAcol = 0; kAcol < temp; kAcol++) {
            b_y_data[i0 + 3 * kAcol] = 0.0;
            for (iy = 0; iy < loop_ub; iy++) {
              b_y_data[i0 + 3 * kAcol] += b_a_data[i0 + 3 * iy] * b_data[iy +
                b_size[0] * kAcol];
            }
          }
        }
      } else {
        ixstart = (int8_T)b_size[1];
        temp = (int8_T)b_size[1];
        for (i0 = 0; i0 < temp; i0++) {
          for (kAcol = 0; kAcol < 3; kAcol++) {
            b_y_data[kAcol + 3 * i0] = 0.0;
          }
        }

        if ((b_size[1] < 1) || (loop_ub < 1)) {
        } else {
          b_s = 1.0;
          smax = 0.0;
          TRANSB = 'N';
          TRANSA = 'N';
          m_t = (ptrdiff_t)3;
          n_t = (ptrdiff_t)b_size[1];
          k_t = (ptrdiff_t)loop_ub;
          lda_t = (ptrdiff_t)3;
          ldb_t = (ptrdiff_t)loop_ub;
          ldc_t = (ptrdiff_t)3;
          dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &b_s, &b_a_data[0], &lda_t,
                &b_data[0], &ldb_t, &smax, &b_y_data[0], &ldc_t);
        }
      }

      loop_ub = l->size[0];
      for (i0 = 0; i0 < 3; i0++) {
        for (kAcol = 0; kAcol < loop_ub; kAcol++) {
          a_data[kAcol + loop_ub * i0] = l->data[(kAcol + l->size[0] * i0) +
            l->size[0] * l->size[1] * i];
        }
      }

      guard1 = false;
      if (ixstart == 1) {
        guard1 = true;
      } else {
        i0 = l->size[0];
        if (i0 == 1) {
          guard1 = true;
        } else {
          memset(&y[0], 0, 9U * sizeof(real_T));
          if (ixstart < 1) {
          } else {
            b_s = 1.0;
            smax = 0.0;
            TRANSB = 'N';
            TRANSA = 'N';
            m_t = (ptrdiff_t)3;
            n_t = (ptrdiff_t)3;
            k_t = (ptrdiff_t)ixstart;
            lda_t = (ptrdiff_t)3;
            ldb_t = (ptrdiff_t)ixstart;
            ldc_t = (ptrdiff_t)3;
            dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &b_s, &b_y_data[0], &lda_t,
                  &a_data[0], &ldb_t, &smax, &y[0], &ldc_t);
          }
        }
      }

      if (guard1) {
        for (i0 = 0; i0 < 3; i0++) {
          for (kAcol = 0; kAcol < 3; kAcol++) {
            y[i0 + 3 * kAcol] = 0.0;
            for (iy = 0; iy < ixstart; iy++) {
              y[i0 + 3 * kAcol] += b_y_data[i0 + 3 * iy] * a_data[iy + loop_ub *
                kAcol];
            }
          }
        }
      }

      for (i0 = 0; i0 < 3; i0++) {
        for (kAcol = 0; kAcol < 3; kAcol++) {
          k->data[(kAcol + k->size[0] * i0) + k->size[0] * k->size[1] * i] =
            y[kAcol + 3 * i0];
        }
      }

      /*  Including elastic shell, with work done by pressure due to shear deformation induced volume change */
      b_EL[0] = EL * A;
      b_EL[1] = EL * I;
      b_EL[2] = EL * I;
      b_EL[3] = GLH * A / 2.0 + el_in_p * 3.1415926535897931 * mpower(el_in_r);
      b_EL[4] = GLH * A / 2.0 + el_in_p * 3.1415926535897931 * (el_in_r *
        el_in_r);
      for (i0 = 0; i0 < 5; i0++) {
        dq[i0] = b_EL[i0];
      }

      memset(&K[0], 0, 25U * sizeof(real_T));
      for (b_j = 0; b_j < 5; b_j++) {
        K[b_j + 5 * b_j] = dq[b_j];
      }

      for (i0 = 0; i0 < 5; i0++) {
        for (kAcol = 0; kAcol < 5; kAcol++) {
          k->data[(kAcol + k->size[0] * i0) + k->size[0] * k->size[1] * i] +=
            K[kAcol + 5 * i0];
        }
      }

      /*  Tangent flexibility */
      for (i0 = 0; i0 < 25; i0++) {
        b_A[i0] = B[i0];
      }

      for (i0 = 0; i0 < 5; i0++) {
        for (kAcol = 0; kAcol < 5; kAcol++) {
          b_data[kAcol + 5 * i0] = k->data[(kAcol + k->size[0] * i0) + k->size[0]
            * k->size[1] * i];
        }
      }

      mldivide(b_data, b_A);
      for (i0 = 0; i0 < 5; i0++) {
        for (kAcol = 0; kAcol < 5; kAcol++) {
          f_data[(kAcol + 5 * i0) + 25 * i] = b_A[kAcol + 5 * i0];
        }
      }

      /*  (11) Compute the section resisting forces */
      /*  Reordered DOFs [axial Mz My Vz Vy]' */
      if (!((!muDoubleScalarIsInf(el_in_beta)) && (!muDoubleScalarIsNaN
            (el_in_beta)))) {
        x = rtNaN;
      } else {
        x = muDoubleScalarRem(el_in_beta, 360.0);
        b_s = muDoubleScalarAbs(x);
        if (b_s > 180.0) {
          if (x > 0.0) {
            x -= 360.0;
          } else {
            x += 360.0;
          }

          b_s = muDoubleScalarAbs(x);
        }

        if (b_s <= 45.0) {
          x *= 0.017453292519943295;
          n = 0;
        } else if (b_s <= 135.0) {
          if (x > 0.0) {
            x = 0.017453292519943295 * (x - 90.0);
            n = 1;
          } else {
            x = 0.017453292519943295 * (x + 90.0);
            n = -1;
          }
        } else if (x > 0.0) {
          x = 0.017453292519943295 * (x - 180.0);
          n = 2;
        } else {
          x = 0.017453292519943295 * (x + 180.0);
          n = -2;
        }

        x = muDoubleScalarTan(x);
        if ((n == 1) || (n == -1)) {
          x = -1.0 / x;
          if (muDoubleScalarIsInf(x) && (n == 1)) {
            x = -x;
          }
        }
      }

      x = 1.0 / x;
      loop_ub = sig->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        x_data[i0] = sig->data[i0 + sig->size[0] * i] * l->data[(i0 + l->size[0])
          + l->size[0] * l->size[1] * i];
      }

      if (loop_ub == 0) {
        b_s = 0.0;
      } else {
        b_s = x_data[0];
        for (ixstart = 2; ixstart <= loop_ub; ixstart++) {
          b_s += x_data[ixstart - 1];
        }
      }

      loop_ub = sig->size[0];
      for (i0 = 0; i0 < loop_ub; i0++) {
        x_data[i0] = sig->data[i0 + sig->size[0] * i] * l->data[(i0 + (l->size[0]
          << 1)) + l->size[0] * l->size[1] * i];
      }

      if (loop_ub == 0) {
        smax = 0.0;
      } else {
        smax = x_data[0];
        for (ixstart = 2; ixstart <= loop_ub; ixstart++) {
          smax += x_data[ixstart - 1];
        }
      }

      loop_ub = sig->size[0];
      sig_size[0] = loop_ub;
      for (i0 = 0; i0 < loop_ub; i0++) {
        EA_data[i0] = sig->data[i0 + sig->size[0] * i];
      }

      d0 = sum(EA_data, sig_size);
      for (i0 = 0; i0 < 5; i0++) {
        EA_data[i0] = 0.0;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          EA_data[i0] += K[i0 + 5 * kAcol] * d_data[kAcol + 5 * i];
        }
      }

      dv1[0] = ((d0 + el_in_p * 3.1415926535897931 * (el_in_r * el_in_r) * 2.0 *
                 (x * x)) + EL * A * d_data[5 * i]) - el_in_p *
        3.1415926535897931 * (el_in_r * el_in_r);
      dv1[1] = b_s;
      dv1[2] = smax;
      dv1[3] = 0.0;
      dv1[4] = 0.0;
      for (i0 = 0; i0 < 5; i0++) {
        Dr->data[i0 + Dr->size[0] * i] = dv1[i0] + EA_data[i0] * (real_T)iv4[i0];
      }

      /*  Includes axial prestress and shell forces */
      /*  (12) Compute the section unbalanced forces */
      for (i0 = 0; i0 < 5; i0++) {
        Du->data[i0 + Du->size[0] * i] = D_data[i0 + 5 * i] - Dr->data[i0 +
          Dr->size[0] * i];
      }

      /*  (13) Compute the residual section deformations */
      for (i0 = 0; i0 < 5; i0++) {
        r->data[i0 + r->size[0] * i] = 0.0;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          r->data[i0 + r->size[0] * i] += f_data[(i0 + 5 * kAcol) + 25 * i] *
            Du->data[kAcol + Du->size[0] * i];
        }
      }

      /*  (14) Compute the element flexibility matrix */
      /*  Flexibility matrix at section */
      for (i0 = 0; i0 < 5; i0++) {
        for (kAcol = 0; kAcol < 5; kAcol++) {
          b_data[i0 + 5 * kAcol] = 0.0;
          for (iy = 0; iy < 5; iy++) {
            b_data[i0 + 5 * kAcol] += b->data[(iy + b->size[0] * i0) + b->size[0]
              * b->size[1] * i] * f_data[(iy + 5 * kAcol) + 25 * i];
          }
        }
      }

      for (i0 = 0; i0 < 5; i0++) {
        for (kAcol = 0; kAcol < 5; kAcol++) {
          Fi->data[(i0 + Fi->size[0] * kAcol) + Fi->size[0] * Fi->size[1] * i] =
            0.0;
          for (iy = 0; iy < 5; iy++) {
            Fi->data[(i0 + Fi->size[0] * kAcol) + Fi->size[0] * Fi->size[1] * i]
              += b_data[i0 + 5 * iy] * b->data[(iy + b->size[0] * kAcol) +
              b->size[0] * b->size[1] * i];
          }
        }
      }

      /*  Integrate b(x)'*f(x)*b(x) over the element length to obtain the element */
      /*  flexibility matrix, sum products of function evaluations and weights */
      b_s = el_in_L / 2.0 * wi_data[i];
      for (i0 = 0; i0 < 5; i0++) {
        for (kAcol = 0; kAcol < 5; kAcol++) {
          F[kAcol + 5 * i0] += b_s * Fi->data[(kAcol + Fi->size[0] * i0) +
            Fi->size[0] * Fi->size[1] * i];
        }
      }

      /*  (15) Compute the residual element deformations */
      b_s = el_in_L / 2.0 * wi_data[i];
      for (i0 = 0; i0 < 5; i0++) {
        EA_data[i0] = 0.0;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          smax = EA_data[i0] + b->data[(kAcol + b->size[0] * i0) + b->size[0] *
            b->size[1] * i] * r->data[kAcol + r->size[0] * i];
          EA_data[i0] = smax;
        }
      }

      for (i0 = 0; i0 < 5; i0++) {
        s[i0] += b_s * EA_data[i0];
      }
    }

    /*  (14 continued) Compute the element stiffness matrix */
    /*  Inverse of the element flexibility matrix is the element stiffness */
    /*  matrix, K = F^-1 */
    memcpy(&b_A[0], &F[0], 25U * sizeof(real_T));
    for (i0 = 0; i0 < 5; i0++) {
      ipiv[i0] = (int8_T)(1 + i0);
    }

    for (b_j = 0; b_j < 4; b_j++) {
      loop_ub = b_j * 6;
      temp = 0;
      ix = loop_ub;
      smax = muDoubleScalarAbs(b_A[loop_ub]);
      for (ixstart = 2; ixstart <= 5 - b_j; ixstart++) {
        ix++;
        b_s = muDoubleScalarAbs(b_A[ix]);
        if (b_s > smax) {
          temp = ixstart - 1;
          smax = b_s;
        }
      }

      if (b_A[loop_ub + temp] != 0.0) {
        if (temp != 0) {
          ipiv[b_j] = (int8_T)((b_j + temp) + 1);
          ix = b_j;
          iy = b_j + temp;
          for (ixstart = 0; ixstart < 5; ixstart++) {
            b_s = b_A[ix];
            b_A[ix] = b_A[iy];
            b_A[iy] = b_s;
            ix += 5;
            iy += 5;
          }
        }

        i0 = (loop_ub - b_j) + 5;
        for (i = loop_ub + 1; i + 1 <= i0; i++) {
          b_A[i] /= b_A[loop_ub];
        }
      }

      temp = loop_ub;
      ixstart = loop_ub + 5;
      for (kAcol = 1; kAcol <= 4 - b_j; kAcol++) {
        b_s = b_A[ixstart];
        if (b_A[ixstart] != 0.0) {
          ix = loop_ub + 1;
          i0 = (temp - b_j) + 10;
          for (iy = 6 + temp; iy + 1 <= i0; iy++) {
            b_A[iy] += b_A[ix] * -b_s;
            ix++;
          }
        }

        ixstart += 5;
        temp += 5;
      }
    }

    for (i0 = 0; i0 < 25; i0++) {
      K[i0] = B[i0];
    }

    for (ixstart = 0; ixstart < 4; ixstart++) {
      if (ipiv[ixstart] != ixstart + 1) {
        iy = ipiv[ixstart] - 1;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          temp = (int32_T)K[ixstart + 5 * kAcol];
          K[ixstart + 5 * kAcol] = K[iy + 5 * kAcol];
          K[iy + 5 * kAcol] = temp;
        }
      }
    }

    for (b_j = 0; b_j < 5; b_j++) {
      iy = 5 * b_j;
      for (ixstart = 0; ixstart < 5; ixstart++) {
        kAcol = 5 * ixstart;
        if (K[ixstart + iy] != 0.0) {
          for (i = ixstart + 1; i + 1 < 6; i++) {
            K[i + iy] -= K[ixstart + iy] * b_A[i + kAcol];
          }
        }
      }
    }

    for (b_j = 0; b_j < 5; b_j++) {
      iy = 5 * b_j;
      for (ixstart = 4; ixstart >= 0; ixstart += -1) {
        kAcol = 5 * ixstart;
        if (K[ixstart + iy] != 0.0) {
          K[ixstart + iy] /= b_A[ixstart + kAcol];
          for (i = 0; i + 1 <= ixstart; i++) {
            K[i + iy] -= K[ixstart + iy] * b_A[i + kAcol];
          }
        }
      }
    }

    /*  (15 continued) Check for element convergence */
    /*  Absolute criteria */
    b_s = 1.0E-6 * el_in_L;
    i0 = tol_a->size[0] * tol_a->size[1];
    tol_a->size[0] = 5;
    tol_a->size[1] = (int32_T)el_in_n;
    emxEnsureCapacity((emxArray__common *)tol_a, i0, (int32_T)sizeof(real_T));
    loop_ub = (int32_T)el_in_n;
    for (i0 = 0; i0 < loop_ub; i0++) {
      tol_a->data[tol_a->size[0] * i0] = 1.0E-6;
    }

    loop_ub = (int32_T)el_in_n;
    for (i0 = 0; i0 < loop_ub; i0++) {
      for (kAcol = 0; kAcol < 2; kAcol++) {
        tol_a->data[(kAcol + tol_a->size[0] * i0) + 1] = b_s;
      }
    }

    loop_ub = (int32_T)el_in_n;
    for (i0 = 0; i0 < loop_ub; i0++) {
      for (kAcol = 0; kAcol < 2; kAcol++) {
        tol_a->data[(kAcol + tol_a->size[0] * i0) + 3] = 1.0E-6;
      }
    }

    /*  Relative criteria */
    D_size[0] = 5;
    D_size[1] = D_size_idx_1;
    loop_ub = 5 * D_size_idx_1;
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_D_data[i0] = D_data[i0] * 1.0E-6;
    }

    c_D_data.data = (real_T *)&b_D_data;
    c_D_data.size = (int32_T *)&D_size;
    c_D_data.allocatedSize = 100;
    c_D_data.numDimensions = 2;
    c_D_data.canFreeData = false;
    b_abs(&c_D_data, r0);
    loop_ub = r0->size[0] * r0->size[1];
    for (i0 = 0; i0 < loop_ub; i0++) {
      tol_b_data[i0] = r0->data[i0];
    }

    /*  Maximum of criteria */
    ixstart = 5 * tol_a->size[1];
    for (i = 0; i < ixstart; i++) {
      if (0.0 < tol_a->data[i] - tol_b_data[i]) {
        tol_D_data[i] = tol_a->data[i];
      }
    }

    ixstart = 5 * tol_a->size[1];
    for (i = 0; i < ixstart; i++) {
      if (!(0.0 < tol_a->data[i] - tol_b_data[i])) {
        tol_D_data[i] = tol_b_data[i];
      }
    }

    /*  Number of converged DOFs */
    b_abs(Du, r0);
    temp = r0->size[1];
    loop_ub = r0->size[0] * r0->size[1];
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_x_data[i0] = (r0->data[i0] < tol_D_data[i0]);
    }

    if (temp == 0) {
    } else {
      ix = -1;
      iy = -1;
      for (i = 1; i <= temp; i++) {
        ixstart = ix + 1;
        ix++;
        b_s = b_x_data[ixstart];
        for (ixstart = 0; ixstart < 4; ixstart++) {
          ix++;
          b_s += (real_T)b_x_data[ix];
        }

        iy++;
        y_data[iy] = b_s;
      }
    }

    if ((int8_T)temp == 0) {
      conv = 0.0;
    } else {
      conv = y_data[0];
      for (ixstart = 2; ixstart <= (int8_T)temp; ixstart++) {
        conv += y_data[ixstart - 1];
      }
    }

    /*  Update element deformations for next iteration */
    for (i = 0; i < 5; i++) {
      dq[i] = -s[i];
    }

    if (el_in_state_it) {
      if ((conv != EC) && (j < 100.0)) {
      } else {
        iterate = 0;
      }
    } else {
      iterate = 0;
    }
  }

  emxFree_real_T(&r0);
  emxFree_real_T(&tol_a);
  emxFree_real_T(&Fi);
  emxFree_real_T(&Dr);
  emxFree_real_T(&k);
  emxFree_real_T(&EA);
  emxFree_real_T(&sig);
  emxFree_real_T(&de);
  emxFree_real_T(&r);
  emxFree_real_T(&dd);
  emxFree_real_T(&dD);
  emxFree_real_T(&b);
  emxFree_real_T(&l);

  /*  % (4) Compute the element force increments */
  /*  dQ = K*dq; % Change in element forces */
  /*  (5) Update the element forces */
  /*  Q = Q - K*s; % New element forces */
  /*  If state determination process has not converged, cutback Newton */
  /*  iteration */
  if ((j == 100.0) && (conv != EC)) {
    /*      warning('State determination cutback') % Print this to a file */
    el_out->b_break = 1.0;
  } else {
    el_out->b_break = 0.0;
  }

  /*  (16) Assemble structure resisting forces and structural stiffness matrix */
  /*  For passing back to corotational formulation */
  J = 6.2831853071795862 * muDoubleScalarPower(el_in_r, 3.0) * t;

  /*  Element forces for corotational formulation (including linear torsion) */
  for (i = 0; i < 5; i++) {
    P[i] = Q[i];
  }

  P[5] = el_in_D[5] * el_in_propsLH[2] * J / el_in_L;

  /*  Element stiffness matrix for corotational formulation (including linear */
  /*  torsion) */
  for (i0 = 0; i0 < 36; i0++) {
    KL[i0] = 0.0;
  }

  KL[35] = el_in_propsLH[2] * J / el_in_L;
  for (i0 = 0; i0 < 5; i0++) {
    for (kAcol = 0; kAcol < 5; kAcol++) {
      KL[kAcol + 6 * i0] = K[kAcol + 5 * i0];
    }
  }

  /*  Store variables for future iterations */
  for (i0 = 0; i0 < 25; i0++) {
    el_out->K[i0] = K[i0];
  }

  /*  Element stiffness */
  i0 = el_out->D->size[0] * el_out->D->size[1];
  el_out->D->size[0] = 5;
  el_out->D->size[1] = D_size_idx_1;
  emxEnsureCapacity((emxArray__common *)el_out->D, i0, (int32_T)sizeof(real_T));
  loop_ub = 5 * D_size_idx_1;
  for (i0 = 0; i0 < loop_ub; i0++) {
    el_out->D->data[i0] = D_data[i0];
  }

  /*  Section forces */
  i0 = el_out->Du->size[0] * el_out->Du->size[1];
  el_out->Du->size[0] = 5;
  el_out->Du->size[1] = Du->size[1];
  emxEnsureCapacity((emxArray__common *)el_out->Du, i0, (int32_T)sizeof(real_T));
  loop_ub = Du->size[0] * Du->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    el_out->Du->data[i0] = Du->data[i0];
  }

  emxFree_real_T(&Du);

  /*  Unbalanced section forces */
  for (i = 0; i < 5; i++) {
    el_out->Q[i] = Q[i];
  }

  /*  Element forces */
  el_out->f.size[0] = 5;
  el_out->f.size[1] = 5;
  el_out->f.size[2] = el_in_flex_f_size[2];
  loop_ub = 25 * el_in_flex_f_size[2];
  for (i0 = 0; i0 < loop_ub; i0++) {
    el_out->f.data[i0] = f_data[i0];
  }

  /*  Section compliance matrices */
  el_out->d.size[0] = 5;
  el_out->d.size[1] = el_in_flex_d_size[1];
  loop_ub = 5 * el_in_flex_d_size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    el_out->d.data[i0] = d_data[i0];
  }

  /*  Section deformations */
  el_out->e.size[0] = el_in_flex_e_size[0];
  el_out->e.size[1] = el_in_flex_e_size[1];
  loop_ub = el_in_flex_e_size[0] * el_in_flex_e_size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    el_out->e.data[i0] = e_data[i0];
  }

  /*  Section fiber strains */
  /*  % % % Plot strain at end of beam */
  /*  % % if el_in.el == 3; */
  /*  % %     plot_strain */
  /*  % % end */
  /*  % % */
  /*  % % % For tracking change in volumae */
  /*  % % dV_L = L/2*wi'*(pi*R^2*d(1,:)'); */
  /*  % % dV_H = L/2*wi'*(pi*R^2*d(1,:)*nuLH.*(d(1,:)*nuLH - 2))'; */
  /*  % % dV = pi*R^2*(1 - 2*nuLH)*L/2*wi'*d(1,:)'; */
  /*  % % */
  /*  % % el_out.dV_L = dV_L; */
  /*  % % el_out.dV_H = dV_H; */
  /*  % % el_out.dV = dV; */
  emlrtHeapReferenceStackLeaveFcnR2012b(aTLS);
}

/* End of code generation (get_KL_P_flex_shear_iter.c) */
