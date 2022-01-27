/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_KL_P_flex_shear_noniter.c
 *
 * Code generation for function 'get_KL_P_flex_shear_noniter'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_KL_P_flex_shear_noniter.h"
#include "assemble_prebody_emxutil.h"
#include "sind.h"
#include "cosd.h"
#include "interp1qr.h"
#include "mpower.h"
#include "diag.h"
#include "get_GL.h"

/* Function Definitions */
void get_KL_P_flex_shear_noniter(emlrtCTX aTLS, real_T el_in_p, real_T el_in_r,
  const real_T el_in_alpha_data[], const int32_T el_in_alpha_size[2], real_T
  el_in_beta, const emxArray_struct5_T *el_in_nodes, const real_T el_in_propsLH
  [5], real_T el_in_n, const real_T el_in_flex_K[25], const emxArray_real_T
  *el_in_flex_D, const emxArray_real_T *el_in_flex_Du, const real_T
  el_in_flex_Q[5], const real_T el_in_flex_f_data[], const int32_T
  el_in_flex_f_size[3], const real_T el_in_flex_d_data[], const int32_T
  el_in_flex_d_size[2], const real_T el_in_flex_e_data[], const int32_T
  el_in_flex_e_size[2], const real_T el_in_D[6], const real_T el_in_dD[6],
  real_T el_in_L, real_T KL[36], real_T P[6], struct_T *el_out)
{
  real_T EL;
  real_T GLH;
  real_T t;
  real_T A;
  real_T I;
  int32_T Du_size_idx_1;
  int32_T ix;
  int32_T i3;
  real_T Du_data[100];
  real_T f_data[500];
  real_T d_data[100];
  int32_T e_size_idx_0;
  real_T e_data[400];
  emxArray_real_T *l;
  int32_T i;
  int32_T xi_size[1];
  real_T x_data[5];
  int32_T wi_size[1];
  real_T EA_data[5];
  emxArray_real_T *b;
  emxArray_real_T *dD;
  emxArray_real_T *dd;
  emxArray_real_T *rho;
  emxArray_real_T *de;
  emxArray_real_T *sig;
  emxArray_real_T *EA;
  emxArray_real_T *k;
  emxArray_real_T *Dr;
  emxArray_real_T *Fi;
  real_T F[25];
  real_T wi_data[10];
  real_T xi_data[10];
  real_T r[5];
  real_T dQ[5];
  real_T x;
  static const int8_T iv5[5] = { 1, 0, 0, 0, 0 };

  real_T smax;
  int32_T iy;
  real_T a_data[15];
  real_T b_b[3];
  int32_T jBcol;
  real_T C_data[5];
  real_T s;
  char_T TRANSB;
  char_T TRANSA;
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  real_T b_e_data[20];
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
  real_T b_A[25];
  real_T y_data[15];
  int32_T kAcol;
  boolean_T guard1 = false;
  real_T y[9];
  real_T b_EL[5];
  real_T Q[5];
  real_T K[25];
  int32_T j;
  int8_T ipiv[5];
  int32_T c;
  int32_T b_k;
  real_T Y[25];
  static const int8_T iv6[25] = { 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0,
    0, 0, 1, 0, 0, 0, 0, 0, 1 };

  real_T b_y;
  int32_T exitg1;
  int8_T n;
  real_T c_y[5];
  static const int8_T iv7[5] = { 0, 1, 1, 1, 1 };

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
  /*  Element stiffness */
  /*  Section forces */
  Du_size_idx_1 = el_in_flex_Du->size[1];
  ix = el_in_flex_Du->size[0] * el_in_flex_Du->size[1];
  for (i3 = 0; i3 < ix; i3++) {
    Du_data[i3] = el_in_flex_Du->data[i3];
  }

  /*  Section forces */
  /*  Element forces */
  ix = el_in_flex_f_size[0] * el_in_flex_f_size[1] * el_in_flex_f_size[2];
  for (i3 = 0; i3 < ix; i3++) {
    f_data[i3] = el_in_flex_f_data[i3];
  }

  /*  Section compliance matrices */
  ix = el_in_flex_d_size[0] * el_in_flex_d_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    d_data[i3] = el_in_flex_d_data[i3];
  }

  /*  Section deformations */
  e_size_idx_0 = el_in_flex_e_size[0];
  ix = el_in_flex_e_size[0] * el_in_flex_e_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    e_data[i3] = el_in_flex_e_data[i3];
  }

  emxInit_real_T1(aTLS, &l, 3, true);

  /*  Section fiber strains */
  /*  Number of integration points */
  /*  Initialize */
  /*  Location of fibers */
  i3 = l->size[0] * l->size[1] * l->size[2];
  l->size[0] = el_in_alpha_size[0];
  l->size[1] = 3;
  l->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)l, i3, (int32_T)sizeof(real_T));
  ix = el_in_alpha_size[0] * 3 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    l->data[i3] = 0.0;
  }

  for (i = 0; i < (int32_T)el_in_n; i++) {
    ix = el_in_alpha_size[0];
    xi_size[0] = el_in_alpha_size[0];
    for (i3 = 0; i3 < ix; i3++) {
      x_data[i3] = el_in_alpha_data[i3 + el_in_alpha_size[0] * i];
    }

    cosd(x_data, xi_size);
    ix = xi_size[0];
    for (i3 = 0; i3 < ix; i3++) {
      x_data[i3] *= -el_in_r;
    }

    ix = el_in_alpha_size[0];
    wi_size[0] = el_in_alpha_size[0];
    for (i3 = 0; i3 < ix; i3++) {
      EA_data[i3] = el_in_alpha_data[i3 + el_in_alpha_size[0] * i];
    }

    sind(EA_data, wi_size);
    ix = wi_size[0];
    for (i3 = 0; i3 < ix; i3++) {
      EA_data[i3] *= el_in_r;
    }

    ix = el_in_alpha_size[0];
    for (i3 = 0; i3 < ix; i3++) {
      l->data[i3 + l->size[0] * l->size[1] * i] = 1.0;
    }

    ix = xi_size[0];
    for (i3 = 0; i3 < ix; i3++) {
      l->data[(i3 + l->size[0]) + l->size[0] * l->size[1] * i] = x_data[i3];
    }

    ix = wi_size[0];
    for (i3 = 0; i3 < ix; i3++) {
      l->data[(i3 + (l->size[0] << 1)) + l->size[0] * l->size[1] * i] =
        EA_data[i3];
    }

    /*  Location of fibers (cartesian) */
  }

  emxInit_real_T1(aTLS, &b, 3, true);

  /*  Initialize */
  i3 = b->size[0] * b->size[1] * b->size[2];
  b->size[0] = 5;
  b->size[1] = 5;
  b->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)b, i3, (int32_T)sizeof(real_T));
  ix = 25 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    b->data[i3] = 0.0;
  }

  emxInit_real_T(aTLS, &dD, 2, true);

  /*  Force interpolation functions */
  i3 = dD->size[0] * dD->size[1];
  dD->size[0] = 5;
  dD->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)dD, i3, (int32_T)sizeof(real_T));
  ix = 5 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    dD->data[i3] = 0.0;
  }

  emxInit_real_T(aTLS, &dd, 2, true);

  /*  Section force increment */
  i3 = dd->size[0] * dd->size[1];
  dd->size[0] = 5;
  dd->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)dd, i3, (int32_T)sizeof(real_T));
  ix = 5 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    dd->data[i3] = 0.0;
  }

  emxInit_real_T(aTLS, &rho, 2, true);

  /*  Section deformation increment */
  i3 = rho->size[0] * rho->size[1];
  rho->size[0] = 5;
  rho->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)rho, i3, (int32_T)sizeof(real_T));
  ix = 5 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    rho->data[i3] = 0.0;
  }

  emxInit_real_T(aTLS, &de, 2, true);

  /*  Residual deformations */
  i3 = de->size[0] * de->size[1];
  de->size[0] = l->size[0];
  de->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)de, i3, (int32_T)sizeof(real_T));
  ix = l->size[0] * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    de->data[i3] = 0.0;
  }

  emxInit_real_T(aTLS, &sig, 2, true);

  /*  Fiber strain increments */
  i3 = sig->size[0] * sig->size[1];
  sig->size[0] = l->size[0];
  sig->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)sig, i3, (int32_T)sizeof(real_T));
  ix = l->size[0] * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    sig->data[i3] = 0.0;
  }

  emxInit_real_T(aTLS, &EA, 2, true);

  /*  Fiber force */
  i3 = EA->size[0] * EA->size[1];
  EA->size[0] = l->size[0];
  EA->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)EA, i3, (int32_T)sizeof(real_T));
  ix = l->size[0] * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    EA->data[i3] = 0.0;
  }

  emxInit_real_T1(aTLS, &k, 3, true);

  /*  Fiber stiffness */
  i3 = k->size[0] * k->size[1] * k->size[2];
  k->size[0] = 5;
  k->size[1] = 5;
  k->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)k, i3, (int32_T)sizeof(real_T));
  ix = 25 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    k->data[i3] = 0.0;
  }

  emxInit_real_T(aTLS, &Dr, 2, true);

  /*  Section stiffness matrix */
  i3 = Dr->size[0] * Dr->size[1];
  Dr->size[0] = 5;
  Dr->size[1] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)Dr, i3, (int32_T)sizeof(real_T));
  ix = 5 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    Dr->data[i3] = 0.0;
  }

  emxInit_real_T1(aTLS, &Fi, 3, true);

  /*  Section resisting forces */
  /*  Du = zeros(5,n); % Section unbalanced forces */
  i3 = Fi->size[0] * Fi->size[1] * Fi->size[2];
  Fi->size[0] = 5;
  Fi->size[1] = 5;
  Fi->size[2] = (int32_T)el_in_n;
  emxEnsureCapacity((emxArray__common *)Fi, i3, (int32_T)sizeof(real_T));
  ix = 25 * (int32_T)el_in_n;
  for (i3 = 0; i3 < ix; i3++) {
    Fi->data[i3] = 0.0;
  }

  /*  Element flexibility matrix at section */
  memset(&F[0], 0, 25U * sizeof(real_T));

  /*  Element flexibility matrix */
  /*  Residual element deformations */
  /*  q = zeros(5,1); % Residual element deformations */
  /*  Gauss-Lobatto integration constants */
  get_GL(el_in_n, xi_data, xi_size, wi_data, wi_size);

  /*  Taucer notation */
  /*  Fiber beam element, non-iterative state determination, Neuenhofer and Filippou (1997) */
  /*  (1) Compute the nodal force increments */
  for (i = 0; i < 5; i++) {
    r[i] = 0.0;
    dQ[i] = 0.0;
    for (i3 = 0; i3 < 5; i3++) {
      dQ[i] += el_in_flex_K[i + 5 * i3] * el_in_dD[i3];
    }
  }

  /*  Change in element forces */
  /*  Loop through sections */
  for (i = 0; i < (int32_T)el_in_n; i++) {
    x = el_in_L / 2.0 * xi_data[i] + el_in_L / 2.0;

    /*  Force interpolation at sections */
    /*  [axial Mz My Vz Vy]' */
    for (i3 = 0; i3 < 5; i3++) {
      b->data[b->size[0] * i3 + b->size[0] * b->size[1] * i] = iv5[i3];
    }

    b->data[1 + b->size[0] * b->size[1] * i] = 0.0;
    b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 1] = x / el_in_L - 1.0;
    b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 1] = x / el_in_L;
    b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 1] = 0.0;
    b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 1] = 0.0;
    b->data[2 + b->size[0] * b->size[1] * i] = 0.0;
    b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 2] = 0.0;
    b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 2] = 0.0;
    b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 2] = x / el_in_L -
      1.0;
    b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 2] = x / el_in_L;
    b->data[3 + b->size[0] * b->size[1] * i] = 0.0;
    b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 3] = -1.0 / el_in_L;
    b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 3] = -1.0 /
      el_in_L;
    b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 3] = 0.0;
    b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 3] = 0.0;
    b->data[4 + b->size[0] * b->size[1] * i] = 0.0;
    b->data[(b->size[0] + b->size[0] * b->size[1] * i) + 4] = 0.0;
    b->data[((b->size[0] << 1) + b->size[0] * b->size[1] * i) + 4] = 0.0;
    b->data[(b->size[0] * 3 + b->size[0] * b->size[1] * i) + 4] = 1.0 / el_in_L;
    b->data[((b->size[0] << 2) + b->size[0] * b->size[1] * i) + 4] = 1.0 /
      el_in_L;

    /*  (2) Compute the section force increments */
    /*  Section force increment */
    for (i3 = 0; i3 < 5; i3++) {
      smax = 0.0;
      for (iy = 0; iy < 5; iy++) {
        smax += b->data[(i3 + b->size[0] * iy) + b->size[0] * b->size[1] * i] *
          dQ[iy];
      }

      dD->data[i3 + dD->size[0] * i] = smax + el_in_flex_Du->data[i3 +
        el_in_flex_Du->size[0] * i];
    }

    /*  (3) Compute the section deformation increments */
    for (i3 = 0; i3 < 5; i3++) {
      dd->data[i3 + dd->size[0] * i] = 0.0;
      for (iy = 0; iy < 5; iy++) {
        dd->data[i3 + dd->size[0] * i] += f_data[(i3 + 5 * iy) + 25 * i] *
          dD->data[iy + dD->size[0] * i];
      }
    }

    /*  + r(:,i); */
    for (i3 = 0; i3 < 5; i3++) {
      d_data[i3 + 5 * i] += dd->data[i3 + dd->size[0] * i];
    }

    /*  (4) Compute section resisting forces */
    /*  Compute the fiber deformation increments */
    ix = l->size[0];
    for (i3 = 0; i3 < 3; i3++) {
      for (iy = 0; iy < ix; iy++) {
        a_data[iy + ix * i3] = l->data[(iy + l->size[0] * i3) + l->size[0] *
          l->size[1] * i];
      }
    }

    for (i3 = 0; i3 < 3; i3++) {
      b_b[i3] = dd->data[i3 + dd->size[0] * i];
    }

    i3 = l->size[0];
    jBcol = (int8_T)i3;
    for (iy = 0; iy < jBcol; iy++) {
      C_data[iy] = 0.0;
    }

    iy = l->size[0];
    if (iy < 1) {
    } else {
      smax = 1.0;
      s = 0.0;
      TRANSB = 'N';
      TRANSA = 'N';
      iy = l->size[0];
      m_t = (ptrdiff_t)iy;
      n_t = (ptrdiff_t)1;
      k_t = (ptrdiff_t)3;
      iy = l->size[0];
      lda_t = (ptrdiff_t)iy;
      ldb_t = (ptrdiff_t)3;
      iy = l->size[0];
      ldc_t = (ptrdiff_t)iy;
      dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &smax, &a_data[0], &lda_t, &b_b
            [0], &ldb_t, &s, &C_data[0], &ldc_t);
    }

    ix = (int8_T)i3;
    for (i3 = 0; i3 < ix; i3++) {
      de->data[i3 + de->size[0] * i] = C_data[i3];
    }

    for (i3 = 0; i3 < e_size_idx_0; i3++) {
      b_e_data[i3] = e_data[i3 + e_size_idx_0 * i] + de->data[i3 + de->size[0] *
        i];
    }

    for (i3 = 0; i3 < e_size_idx_0; i3++) {
      e_data[i3 + e_size_idx_0 * i] = b_e_data[i3];
    }

    /*  Compute fiber stresses and tangent moduli */
    /*  Determine current fiber force and stiffness */
    /*  'spline'; % 'pchip'; % */
    for (m = 0; m < el_in_alpha_size[0]; m++) {
      /*  Fibers */
      /*  Extract cord force - strain relationship */
      /*  Calculate cord stiffness */
      ix = el_in_nodes->data[i].cords.data[m].axial.size[0];
      el_in_nodes_size[0] = ix;
      for (i3 = 0; i3 < ix; i3++) {
        el_in_nodes_data[i3] = el_in_nodes->data[i].cords.data[m].axial.data[i3
          + el_in_nodes->data[i].cords.data[m].axial.size[0]];
      }

      ix = el_in_nodes->data[i].cords.data[m].axial.size[0];
      b_el_in_nodes_size[0] = ix;
      for (i3 = 0; i3 < ix; i3++) {
        b_el_in_nodes_data[i3] = el_in_nodes->data[i].cords.data[m]
          .axial.data[i3];
      }

      e[0] = e_data[m + e_size_idx_0 * i];
      e[1] = e_data[m + e_size_idx_0 * i] + 1.0E-10;
      for (i3 = 0; i3 < 2; i3++) {
        b_e[i3] = e[i3];
      }

      interp1qr(el_in_nodes_data, el_in_nodes_size, b_el_in_nodes_data,
                b_el_in_nodes_size, b_e, force);
      sig->data[m + sig->size[0] * i] = force[0];

      /*  force_up = interp1(axial(:,2),axial(:,1),e(m,i) + tol1,interp_meth); */
      EA->data[m + EA->size[0] * i] = (force[1] - force[0]) / 1.0E-10;
    }

    /*  (6) Compute the section tangent stiffness matrix */
    /*  Tangent stiffness */
    for (i3 = 0; i3 < 5; i3++) {
      for (iy = 0; iy < 5; iy++) {
        k->data[(iy + k->size[0] * i3) + k->size[0] * k->size[1] * i] = 0.0;
      }
    }

    ix = l->size[0];
    for (i3 = 0; i3 < ix; i3++) {
      for (iy = 0; iy < 3; iy++) {
        b_a_data[iy + 3 * i3] = l->data[(i3 + l->size[0] * iy) + l->size[0] *
          l->size[1] * i];
      }
    }

    temp = EA->size[0];
    EA_size[0] = temp;
    for (i3 = 0; i3 < temp; i3++) {
      EA_data[i3] = EA->data[i3 + EA->size[0] * i];
    }

    diag(EA_data, EA_size, b_A, b_size);
    if ((ix == 1) || (b_size[0] == 1)) {
      jBcol = b_size[1];
      for (i3 = 0; i3 < 3; i3++) {
        temp = b_size[1];
        for (iy = 0; iy < temp; iy++) {
          y_data[i3 + 3 * iy] = 0.0;
          for (kAcol = 0; kAcol < ix; kAcol++) {
            y_data[i3 + 3 * iy] += b_a_data[i3 + 3 * kAcol] * b_A[kAcol +
              b_size[0] * iy];
          }
        }
      }
    } else {
      jBcol = (int8_T)b_size[1];
      temp = (int8_T)b_size[1];
      for (i3 = 0; i3 < temp; i3++) {
        for (iy = 0; iy < 3; iy++) {
          y_data[iy + 3 * i3] = 0.0;
        }
      }

      if ((b_size[1] < 1) || (ix < 1)) {
      } else {
        smax = 1.0;
        s = 0.0;
        TRANSB = 'N';
        TRANSA = 'N';
        m_t = (ptrdiff_t)3;
        n_t = (ptrdiff_t)b_size[1];
        k_t = (ptrdiff_t)ix;
        lda_t = (ptrdiff_t)3;
        ldb_t = (ptrdiff_t)ix;
        ldc_t = (ptrdiff_t)3;
        dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &smax, &b_a_data[0], &lda_t,
              &b_A[0], &ldb_t, &s, &y_data[0], &ldc_t);
      }
    }

    ix = l->size[0];
    for (i3 = 0; i3 < 3; i3++) {
      for (iy = 0; iy < ix; iy++) {
        a_data[iy + ix * i3] = l->data[(iy + l->size[0] * i3) + l->size[0] *
          l->size[1] * i];
      }
    }

    guard1 = false;
    if (jBcol == 1) {
      guard1 = true;
    } else {
      i3 = l->size[0];
      if (i3 == 1) {
        guard1 = true;
      } else {
        memset(&y[0], 0, 9U * sizeof(real_T));
        if (jBcol < 1) {
        } else {
          smax = 1.0;
          s = 0.0;
          TRANSB = 'N';
          TRANSA = 'N';
          m_t = (ptrdiff_t)3;
          n_t = (ptrdiff_t)3;
          k_t = (ptrdiff_t)jBcol;
          lda_t = (ptrdiff_t)3;
          ldb_t = (ptrdiff_t)jBcol;
          ldc_t = (ptrdiff_t)3;
          dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &smax, &y_data[0], &lda_t,
                &a_data[0], &ldb_t, &s, &y[0], &ldc_t);
        }
      }
    }

    if (guard1) {
      for (i3 = 0; i3 < 3; i3++) {
        for (iy = 0; iy < 3; iy++) {
          y[i3 + 3 * iy] = 0.0;
          for (kAcol = 0; kAcol < jBcol; kAcol++) {
            y[i3 + 3 * iy] += y_data[i3 + 3 * kAcol] * a_data[kAcol + ix * iy];
          }
        }
      }
    }

    for (i3 = 0; i3 < 3; i3++) {
      for (iy = 0; iy < 3; iy++) {
        k->data[(iy + k->size[0] * i3) + k->size[0] * k->size[1] * i] = y[iy + 3
          * i3];
      }
    }

    /*  Including elastic shell, with work done by pressure due to shear deformation induced volume change */
    b_EL[0] = EL * A;
    b_EL[1] = EL * I;
    b_EL[2] = EL * I;
    b_EL[3] = GLH * A / 2.0 + el_in_p * 3.1415926535897931 * mpower(el_in_r);
    b_EL[4] = GLH * A / 2.0 + el_in_p * 3.1415926535897931 * mpower(el_in_r);
    for (i3 = 0; i3 < 5; i3++) {
      Q[i3] = b_EL[i3];
    }

    memset(&K[0], 0, 25U * sizeof(real_T));
    for (j = 0; j < 5; j++) {
      K[j + 5 * j] = Q[j];
    }

    for (i3 = 0; i3 < 5; i3++) {
      for (iy = 0; iy < 5; iy++) {
        k->data[(iy + k->size[0] * i3) + k->size[0] * k->size[1] * i] += K[iy +
          5 * i3];
      }
    }

    /*  (7) Section tangent flexibility matrix */
    for (i3 = 0; i3 < 5; i3++) {
      for (iy = 0; iy < 5; iy++) {
        b_A[iy + 5 * i3] = k->data[(iy + k->size[0] * i3) + k->size[0] * k->
          size[1] * i];
      }
    }

    for (i3 = 0; i3 < 5; i3++) {
      ipiv[i3] = (int8_T)(1 + i3);
    }

    for (j = 0; j < 4; j++) {
      c = j * 6;
      iy = 0;
      ix = c;
      smax = muDoubleScalarAbs(b_A[c]);
      for (b_k = 2; b_k <= 5 - j; b_k++) {
        ix++;
        s = muDoubleScalarAbs(b_A[ix]);
        if (s > smax) {
          iy = b_k - 1;
          smax = s;
        }
      }

      if (b_A[c + iy] != 0.0) {
        if (iy != 0) {
          ipiv[j] = (int8_T)((j + iy) + 1);
          ix = j;
          iy += j;
          for (b_k = 0; b_k < 5; b_k++) {
            smax = b_A[ix];
            b_A[ix] = b_A[iy];
            b_A[iy] = smax;
            ix += 5;
            iy += 5;
          }
        }

        i3 = (c - j) + 5;
        for (temp = c + 1; temp + 1 <= i3; temp++) {
          b_A[temp] /= b_A[c];
        }
      }

      temp = c;
      jBcol = c + 5;
      for (kAcol = 1; kAcol <= 4 - j; kAcol++) {
        smax = b_A[jBcol];
        if (b_A[jBcol] != 0.0) {
          ix = c + 1;
          i3 = (temp - j) + 10;
          for (iy = 6 + temp; iy + 1 <= i3; iy++) {
            b_A[iy] += b_A[ix] * -smax;
            ix++;
          }
        }

        jBcol += 5;
        temp += 5;
      }
    }

    for (i3 = 0; i3 < 25; i3++) {
      Y[i3] = iv6[i3];
    }

    for (jBcol = 0; jBcol < 4; jBcol++) {
      if (ipiv[jBcol] != jBcol + 1) {
        kAcol = ipiv[jBcol] - 1;
        for (iy = 0; iy < 5; iy++) {
          temp = (int32_T)Y[jBcol + 5 * iy];
          Y[jBcol + 5 * iy] = Y[kAcol + 5 * iy];
          Y[kAcol + 5 * iy] = temp;
        }
      }
    }

    for (j = 0; j < 5; j++) {
      jBcol = 5 * j;
      for (b_k = 0; b_k < 5; b_k++) {
        kAcol = 5 * b_k;
        if (Y[b_k + jBcol] != 0.0) {
          for (temp = b_k + 1; temp + 1 < 6; temp++) {
            Y[temp + jBcol] -= Y[b_k + jBcol] * b_A[temp + kAcol];
          }
        }
      }
    }

    for (j = 0; j < 5; j++) {
      jBcol = 5 * j;
      for (b_k = 4; b_k >= 0; b_k += -1) {
        kAcol = 5 * b_k;
        if (Y[b_k + jBcol] != 0.0) {
          Y[b_k + jBcol] /= b_A[b_k + kAcol];
          for (temp = 0; temp + 1 <= b_k; temp++) {
            Y[temp + jBcol] -= Y[b_k + jBcol] * b_A[temp + kAcol];
          }
        }
      }
    }

    for (i3 = 0; i3 < 5; i3++) {
      for (iy = 0; iy < 5; iy++) {
        f_data[(iy + 5 * i3) + 25 * i] = Y[iy + 5 * i3];
      }
    }

    /*  Reordered DOFs [axial Mz My Vz Vy]' */
    i3 = sig->size[0];
    if (i3 == 0) {
      b_y = 0.0;
    } else {
      b_y = sig->data[sig->size[0] * i];
      b_k = 2;
      do {
        exitg1 = 0;
        i3 = sig->size[0];
        if (b_k <= i3) {
          b_y += sig->data[(b_k + sig->size[0] * i) - 1];
          b_k++;
        } else {
          exitg1 = 1;
        }
      } while (exitg1 == 0);
    }

    if (!((!muDoubleScalarIsInf(el_in_beta)) && (!muDoubleScalarIsNaN(el_in_beta))))
    {
      x = rtNaN;
    } else {
      x = muDoubleScalarRem(el_in_beta, 360.0);
      smax = muDoubleScalarAbs(x);
      if (smax > 180.0) {
        if (x > 0.0) {
          x -= 360.0;
        } else {
          x += 360.0;
        }

        smax = muDoubleScalarAbs(x);
      }

      if (smax <= 45.0) {
        x *= 0.017453292519943295;
        n = 0;
      } else if (smax <= 135.0) {
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
    ix = sig->size[0];
    for (i3 = 0; i3 < ix; i3++) {
      x_data[i3] = sig->data[i3 + sig->size[0] * i] * l->data[(i3 + l->size[0])
        + l->size[0] * l->size[1] * i];
    }

    if (ix == 0) {
      smax = 0.0;
    } else {
      smax = x_data[0];
      for (b_k = 2; b_k <= ix; b_k++) {
        smax += x_data[b_k - 1];
      }
    }

    ix = sig->size[0];
    for (i3 = 0; i3 < ix; i3++) {
      x_data[i3] = sig->data[i3 + sig->size[0] * i] * l->data[(i3 + (l->size[0] <<
        1)) + l->size[0] * l->size[1] * i];
    }

    if (ix == 0) {
      s = 0.0;
    } else {
      s = x_data[0];
      for (b_k = 2; b_k <= ix; b_k++) {
        s += x_data[b_k - 1];
      }
    }

    for (i3 = 0; i3 < 5; i3++) {
      EA_data[i3] = 0.0;
      for (iy = 0; iy < 5; iy++) {
        EA_data[i3] += K[i3 + 5 * iy] * d_data[iy + 5 * i];
      }
    }

    c_y[0] = ((b_y + el_in_p * 3.1415926535897931 * (el_in_r * el_in_r) * 2.0 *
               (x * x)) + EL * A * d_data[5 * i]) - el_in_p * 3.1415926535897931
      * (el_in_r * el_in_r);
    c_y[1] = smax;
    c_y[2] = s;
    c_y[3] = 0.0;
    c_y[4] = 0.0;
    for (i3 = 0; i3 < 5; i3++) {
      Dr->data[i3 + Dr->size[0] * i] = c_y[i3] + EA_data[i3] * (real_T)iv7[i3];
    }

    /*  Includes axial prestress and shell forces */
    /*  (8) Compute the element flexibility matrix */
    /*  Flexibility matrix at section */
    for (i3 = 0; i3 < 5; i3++) {
      for (iy = 0; iy < 5; iy++) {
        b_A[i3 + 5 * iy] = 0.0;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          b_A[i3 + 5 * iy] += b->data[(kAcol + b->size[0] * i3) + b->size[0] *
            b->size[1] * i] * f_data[(kAcol + 5 * iy) + 25 * i];
        }
      }
    }

    for (i3 = 0; i3 < 5; i3++) {
      for (iy = 0; iy < 5; iy++) {
        Fi->data[(i3 + Fi->size[0] * iy) + Fi->size[0] * Fi->size[1] * i] = 0.0;
        for (kAcol = 0; kAcol < 5; kAcol++) {
          Fi->data[(i3 + Fi->size[0] * iy) + Fi->size[0] * Fi->size[1] * i] +=
            b_A[i3 + 5 * kAcol] * b->data[(kAcol + b->size[0] * iy) + b->size[0]
            * b->size[1] * i];
        }
      }
    }

    /*  Integrate b(x)'*f(x)*b(x) over the element length to obtain the element */
    /*  flexibility matrix, sum products of function evaluations and weights */
    smax = el_in_L / 2.0 * wi_data[i];
    for (i3 = 0; i3 < 5; i3++) {
      for (iy = 0; iy < 5; iy++) {
        F[iy + 5 * i3] += smax * Fi->data[(iy + Fi->size[0] * i3) + Fi->size[0] *
          Fi->size[1] * i];
      }
    }

    /*  (9) Compute the element stiffness matrix - BELOW */
    /*  (10) Compute the residual section deformations */
    for (i3 = 0; i3 < 5; i3++) {
      EA_data[i3] = (el_in_flex_D->data[i3 + el_in_flex_D->size[0] * i] +
                     dD->data[i3 + dD->size[0] * i]) - Dr->data[i3 + Dr->size[0]
        * i];
    }

    for (i3 = 0; i3 < 5; i3++) {
      rho->data[i3 + rho->size[0] * i] = 0.0;
      for (iy = 0; iy < 5; iy++) {
        rho->data[i3 + rho->size[0] * i] += f_data[(i3 + 5 * iy) + 25 * i] *
          EA_data[iy];
      }
    }

    /*  (11) Compute the residual element displacements */
    smax = el_in_L / 2.0 * wi_data[i];
    for (i3 = 0; i3 < 5; i3++) {
      EA_data[i3] = 0.0;
      for (iy = 0; iy < 5; iy++) {
        s = EA_data[i3] + b->data[(iy + b->size[0] * i3) + b->size[0] * b->size
          [1] * i] * rho->data[iy + rho->size[0] * i];
        EA_data[i3] = s;
      }
    }

    for (i3 = 0; i3 < 5; i3++) {
      r[i3] += smax * EA_data[i3];
    }
  }

  emxFree_real_T(&Fi);
  emxFree_real_T(&k);
  emxFree_real_T(&EA);
  emxFree_real_T(&sig);
  emxFree_real_T(&de);
  emxFree_real_T(&rho);
  emxFree_real_T(&dd);
  emxFree_real_T(&dD);
  emxFree_real_T(&l);

  /*  (9) Compute the element stiffness matrix */
  /*  Inverse of the element flexibility matrix is the element stiffness */
  /*  matrix, K = F^-1 */
  for (i3 = 0; i3 < 5; i3++) {
    ipiv[i3] = (int8_T)(1 + i3);
  }

  for (j = 0; j < 4; j++) {
    c = j * 6;
    iy = 0;
    ix = c;
    smax = muDoubleScalarAbs(F[c]);
    for (b_k = 2; b_k <= 5 - j; b_k++) {
      ix++;
      s = muDoubleScalarAbs(F[ix]);
      if (s > smax) {
        iy = b_k - 1;
        smax = s;
      }
    }

    if (F[c + iy] != 0.0) {
      if (iy != 0) {
        ipiv[j] = (int8_T)((j + iy) + 1);
        ix = j;
        iy += j;
        for (b_k = 0; b_k < 5; b_k++) {
          smax = F[ix];
          F[ix] = F[iy];
          F[iy] = smax;
          ix += 5;
          iy += 5;
        }
      }

      i3 = (c - j) + 5;
      for (i = c + 1; i + 1 <= i3; i++) {
        F[i] /= F[c];
      }
    }

    temp = c;
    jBcol = c + 5;
    for (kAcol = 1; kAcol <= 4 - j; kAcol++) {
      smax = F[jBcol];
      if (F[jBcol] != 0.0) {
        ix = c + 1;
        i3 = (temp - j) + 10;
        for (iy = 6 + temp; iy + 1 <= i3; iy++) {
          F[iy] += F[ix] * -smax;
          ix++;
        }
      }

      jBcol += 5;
      temp += 5;
    }
  }

  for (i3 = 0; i3 < 25; i3++) {
    K[i3] = iv6[i3];
  }

  for (jBcol = 0; jBcol < 4; jBcol++) {
    if (ipiv[jBcol] != jBcol + 1) {
      kAcol = ipiv[jBcol] - 1;
      for (iy = 0; iy < 5; iy++) {
        temp = (int32_T)K[jBcol + 5 * iy];
        K[jBcol + 5 * iy] = K[kAcol + 5 * iy];
        K[kAcol + 5 * iy] = temp;
      }
    }
  }

  for (j = 0; j < 5; j++) {
    jBcol = 5 * j;
    for (b_k = 0; b_k < 5; b_k++) {
      kAcol = 5 * b_k;
      if (K[b_k + jBcol] != 0.0) {
        for (i = b_k + 1; i + 1 < 6; i++) {
          K[i + jBcol] -= K[b_k + jBcol] * F[i + kAcol];
        }
      }
    }
  }

  for (j = 0; j < 5; j++) {
    jBcol = 5 * j;
    for (b_k = 4; b_k >= 0; b_k += -1) {
      kAcol = 5 * b_k;
      if (K[b_k + jBcol] != 0.0) {
        K[b_k + jBcol] /= F[b_k + kAcol];
        for (i = 0; i + 1 <= b_k; i++) {
          K[i + jBcol] -= K[b_k + jBcol] * F[i + kAcol];
        }
      }
    }
  }

  /*  (12) Element resisting forces */
  for (i3 = 0; i3 < 5; i3++) {
    smax = 0.0;
    for (iy = 0; iy < 5; iy++) {
      smax += K[i3 + 5 * iy] * r[iy];
    }

    Q[i3] = (el_in_flex_Q[i3] + dQ[i3]) - smax;
  }

  /*  New element forces */
  /*  (13) Unbalanced section forces */
  for (i = 0; i < (int32_T)el_in_n; i++) {
    for (i3 = 0; i3 < 5; i3++) {
      smax = 0.0;
      for (iy = 0; iy < 5; iy++) {
        smax += b->data[(i3 + b->size[0] * iy) + b->size[0] * b->size[1] * i] *
          Q[iy];
      }

      Du_data[i3 + 5 * i] = smax - Dr->data[i3 + Dr->size[0] * i];
    }
  }

  emxFree_real_T(&b);

  /*  For passing back to corotational formulation */
  J = 6.2831853071795862 * muDoubleScalarPower(el_in_r, 3.0) * t;

  /*  Element forces for corotational formulation (including linear torsion) */
  for (i = 0; i < 5; i++) {
    P[i] = Q[i];
  }

  P[5] = el_in_D[5] * el_in_propsLH[2] * J / el_in_L;

  /*  Element stiffness matrix for corotational formulation (including linear */
  /*  torsion) */
  for (i3 = 0; i3 < 36; i3++) {
    KL[i3] = 0.0;
  }

  KL[35] = el_in_propsLH[2] * J / el_in_L;
  for (i3 = 0; i3 < 5; i3++) {
    for (iy = 0; iy < 5; iy++) {
      KL[iy + 6 * i3] = K[iy + 5 * i3];
    }
  }

  /*  Store variables for future iterations */
  el_out->b_break = 0.0;
  for (i3 = 0; i3 < 25; i3++) {
    el_out->K[i3] = K[i3];
  }

  /*  Element stiffness */
  i3 = el_out->D->size[0] * el_out->D->size[1];
  el_out->D->size[0] = 5;
  el_out->D->size[1] = Dr->size[1];
  emxEnsureCapacity((emxArray__common *)el_out->D, i3, (int32_T)sizeof(real_T));
  ix = Dr->size[0] * Dr->size[1];
  for (i3 = 0; i3 < ix; i3++) {
    el_out->D->data[i3] = Dr->data[i3];
  }

  emxFree_real_T(&Dr);

  /*  Section forces */
  i3 = el_out->Du->size[0] * el_out->Du->size[1];
  el_out->Du->size[0] = 5;
  el_out->Du->size[1] = Du_size_idx_1;
  emxEnsureCapacity((emxArray__common *)el_out->Du, i3, (int32_T)sizeof(real_T));
  ix = 5 * Du_size_idx_1;
  for (i3 = 0; i3 < ix; i3++) {
    el_out->Du->data[i3] = Du_data[i3];
  }

  /*  Unbalanced section forces */
  for (i = 0; i < 5; i++) {
    el_out->Q[i] = Q[i];
  }

  /*  Element forces */
  el_out->f.size[0] = 5;
  el_out->f.size[1] = 5;
  el_out->f.size[2] = el_in_flex_f_size[2];
  ix = 25 * el_in_flex_f_size[2];
  for (i3 = 0; i3 < ix; i3++) {
    el_out->f.data[i3] = f_data[i3];
  }

  /*  Section compliance matrices */
  el_out->d.size[0] = 5;
  el_out->d.size[1] = el_in_flex_d_size[1];
  ix = 5 * el_in_flex_d_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    el_out->d.data[i3] = d_data[i3];
  }

  /*  Section deformations */
  el_out->e.size[0] = el_in_flex_e_size[0];
  el_out->e.size[1] = el_in_flex_e_size[1];
  ix = el_in_flex_e_size[0] * el_in_flex_e_size[1];
  for (i3 = 0; i3 < ix; i3++) {
    el_out->e.data[i3] = e_data[i3];
  }

  /*  Section fiber strains */
  /*  % % % Plot strain at end of beam */
  /*  % % if el_in.el == 3; */
  /*  % %     plot_strain */
  /*  % % end */
  /*  % % */
  /*  % % % For tracking change in volume */
  /*  % % dV_L = L/2*wi'*(pi*R^2*d(1,:)'); */
  /*  % % dV_H = L/2*wi'*(pi*R^2*d(1,:)*nuLH.*(d(1,:)*nuLH - 2))'; */
  /*  % % dV = pi*R^2*(1 - 2*nuLH)*L/2*wi'*d(1,:)'; */
  /*  % % */
  /*  % % el_out.dV_L = dV_L; */
  /*  % % el_out.dV_H = dV_H; */
  /*  % % el_out.dV = dV; */
  emlrtHeapReferenceStackLeaveFcnR2012b(aTLS);
}

/* End of code generation (get_KL_P_flex_shear_noniter.c) */
