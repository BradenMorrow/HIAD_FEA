/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * el2.c
 *
 * Code generation for function 'el2'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "el2.h"
#include "get_G.h"
#include "get_S.h"
#include "k1.h"
#include "get_L.h"
#include "eye.h"
#include "mpower.h"
#include "asin.h"
#include "norm.h"
#include "get_PHI_quat.h"
#include "quat_prod.h"
#include "get_quat_PHI.h"
#include "normcfast.h"
#include "get_R_PHI.h"
#include "cross.h"
#include "sqrt.h"

/* Function Definitions */
void el2(const real_T U_in_U[12], const real_T U_in_delta_U[12], const real_T
         U_in_DELTA_U[12], const real_T el_in_nodes_ij[6], const real_T
         el_in_orient_ij[3], b_struct_T *el_in0, real_T Kel[144], real_T fint_i
         [12], real_T Fint_i[12], real_T ROT_rot[6], real_T ROT_DELTA_rot[6])
{
  real_T L10;
  real_T L20;
  real_T L30;
  real_T L0;
  real_T L1;
  real_T L2;
  real_T L3;
  real_T L;
  real_T e10[3];
  real_T B;
  real_T b_el_in_orient_ij[3];
  real_T c_el_in_orient_ij[3];
  int32_T i32;
  real_T e30[3];
  real_T e20[3];
  real_T E0[9];
  real_T delta_qi[4];
  real_T delta_qj[4];
  real_T dv45[4];
  real_T dv46[4];
  real_T rot[6];
  real_T dv47[4];
  real_T dv48[4];
  real_T S_nI2[9];
  int32_T k;
  real_T NI[9];
  int32_T i33;
  real_T NJ[9];
  real_T b_NI[9];
  real_T R_bar[9];
  real_T dv49[4];
  real_T dv50[4];
  real_T dv51[4];
  real_T dv52[4];
  real_T y;
  real_T b_e10;
  real_T b_y;
  real_T b_e20;
  real_T phiI1;
  real_T phiI2;
  real_T phiI3;
  real_T phiJ1;
  real_T phiJ2;
  real_T phiJ3;
  real_T D[6];
  real_T A[9];
  real_T L_r2[36];
  real_T L_r3[36];
  real_T S_nI3[9];
  real_T S_nJ1[9];
  real_T S_nJ2[9];
  real_T S_nJ3[9];
  real_T b_L_r2[12];
  real_T b_A[3];
  real_T c_A[3];
  real_T d_A[12];
  real_T c_L_r2[12];
  real_T t2[12];
  real_T t3[12];
  real_T b_L_r3[36];
  real_T c_L_r3[12];
  real_T b_S_nI3[3];
  real_T t4[12];
  real_T d_L_r3[12];
  real_T t5[12];
  real_T t6J[12];
  real_T t6I[12];
  real_T T[72];
  real_T b_k[144];
  real_T c_k[72];
  real_T KL[36];
  real_T P[6];
  real_T m2;
  real_T m3;
  real_T m4;
  real_T m5;
  real_T m6I;
  real_T m6J;
  real_T e_A[144];
  real_T x;
  real_T b_x;
  real_T c_x;
  real_T d_x;
  real_T e_x;
  real_T f_x;
  real_T d_L_r2[36];
  real_T b_m2[9];
  real_T b_m4[9];
  real_T e_L_r2[36];
  real_T b_m5[9];
  real_T e_L_r3[36];
  real_T KD[144];
  static const int8_T iv43[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  real_T c_y;
  real_T d_y;
  real_T e_y;
  real_T f_y;
  real_T g_y;
  real_T h_y;
  real_T S_e2[9];
  real_T S_e1[9];
  real_T S_e3[9];
  real_T f_A[9];
  real_T g_A[9];
  real_T h_A[9];
  real_T i_A[9];
  real_T j_A[9];
  real_T k_A[9];
  real_T KF11[9];
  real_T KF12[9];
  real_T KF14[9];
  char_T TRANSB;
  char_T TRANSA;
  real_T i_y[144];
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  real_T dv53[144];
  real_T dv54[144];
  real_T dv55[144];
  real_T dv56[144];
  real_T dv57[144];
  real_T dv58[144];
  real_T dv59[144];
  real_T b_t6I[144];
  real_T b_t6J[144];
  real_T b_t2[144];
  real_T b_t3[144];
  real_T b_t4[144];
  real_T b_t5[144];
  real_T b_S_e3[9];
  real_T b_S_e2[9];
  real_T b_KF11[144];

  /* ELEMENT_4 */
  /*    3D corotational beam formulation, see Crisfield (1990), A consistent */
  /*    co-rotational formulation for non-linear, three dimensional, */
  /*    beam-elements */
  /*    See also de Souza dissertation (2000), Force-based finite element for */
  /*    large displacement inelastic analysis of frames */
  /*    Generally follows de Souza */
  /*  Extract variables */
  /*  Geometry */
  /*  Material */
  /*  Obtain displacements of interest */
  /*  Components of length and length */
  /*  Initial */
  L10 = el_in_nodes_ij[1] - el_in_nodes_ij[0];
  L20 = el_in_nodes_ij[3] - el_in_nodes_ij[2];
  L30 = el_in_nodes_ij[5] - el_in_nodes_ij[4];
  L0 = (mpower(L10) + mpower(L20)) + mpower(L30);
  b_sqrt(&L0);

  /*  Current */
  L1 = (el_in_nodes_ij[1] + U_in_U[1]) - (el_in_nodes_ij[0] + U_in_U[0]);
  L2 = (el_in_nodes_ij[3] + U_in_U[3]) - (el_in_nodes_ij[2] + U_in_U[2]);
  L3 = (el_in_nodes_ij[5] + U_in_U[5]) - (el_in_nodes_ij[4] + U_in_U[4]);
  L = (mpower(L1) + mpower(L2)) + mpower(L3);
  b_sqrt(&L);

  /*  To orientation nodes */
  /*  Initial */
  /*  Lo10 = orient(1:2,1) - nodes(1:2,1); */
  /*  Lo20 = orient(1:2,2) - nodes(1:2,2); */
  /*  Lo30 = orient(1:2,3) - nodes(1:2,3); */
  /*  Obtain the initial nodal triads */
  /*  Unit vectors at i node */
  e10[0] = L10;
  e10[1] = L20;
  e10[2] = L30;
  B = norm(e10);
  b_el_in_orient_ij[0] = el_in_orient_ij[0] - el_in_nodes_ij[0];
  b_el_in_orient_ij[1] = el_in_orient_ij[1] - el_in_nodes_ij[2];
  b_el_in_orient_ij[2] = el_in_orient_ij[2] - el_in_nodes_ij[4];
  for (i32 = 0; i32 < 3; i32++) {
    c_el_in_orient_ij[i32] = b_el_in_orient_ij[i32];
    e10[i32] /= B;
  }

  cross(e10, c_el_in_orient_ij, e30);
  B = norm(e30);
  for (i32 = 0; i32 < 3; i32++) {
    e30[i32] /= B;
  }

  cross(e30, e10, e20);
  B = norm(e20);

  /*  Section 5.3.2a - de Souza */
  /*  e0 = get_quat_R(E0); */
  for (i32 = 0; i32 < 3; i32++) {
    E0[i32] = e10[i32];
    E0[3 + i32] = e20[i32] / B;
    E0[6 + i32] = e30[i32];
    b_el_in_orient_ij[i32] = U_in_delta_U[(3 + i32) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, delta_qi);
  for (i32 = 0; i32 < 3; i32++) {
    b_el_in_orient_ij[i32] = U_in_delta_U[1 + ((3 + i32) << 1)];
  }

  get_quat_PHI(b_el_in_orient_ij, delta_qj);

  /*  STEP 2 */
  /*  Equation 5.46 */
  /*  Calculate nodal rotation for incorporation into displacement vector */
  for (i32 = 0; i32 < 3; i32++) {
    b_el_in_orient_ij[i32] = U_in_U[(3 + i32) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, dv45);
  quat_prod(delta_qi, dv45, dv46);
  get_PHI_quat(dv46, e10);
  for (i32 = 0; i32 < 3; i32++) {
    b_el_in_orient_ij[i32] = U_in_U[1 + ((3 + i32) << 1)];
    rot[i32 << 1] = e10[i32];
  }

  get_quat_PHI(b_el_in_orient_ij, dv47);
  quat_prod(delta_qj, dv47, dv48);
  get_PHI_quat(dv48, e30);
  for (i32 = 0; i32 < 3; i32++) {
    rot[1 + (i32 << 1)] = e30[i32];
  }

  for (i32 = 0; i32 < 6; i32++) {
    ROT_rot[i32] = rot[i32];
  }

  /* %%%%%%%%%%%%%% */
  /*  If U = zeros, rotI and rotJ = zeros, nI and nJ = e0 ==> OK */
  /*  However, NI and NJ should equal E0, not the case. */
  /*  % % nI = quat_prod(qI,e0); % Equation 5.48 */
  /*  % % nJ = quat_prod(qJ,e0); */
  /*  % %  */
  /*  % % NI = get_R_quat(nI); */
  /*  % % NJ = get_R_quat(nJ); */
  /*  % %  */
  /*  % % % STEP 3 */
  /*  % % gammaI = get_PHI_quat(nI); */
  /*  % % gammaJ = get_PHI_quat(nJ); */
  /*  % %  */
  /*  % % % STEP 4 */
  /*  % % R_bar = get_R_PHI((gammaI + gammaJ)/2); */
  /*  June 25, 2015 */
  for (i32 = 0; i32 < 3; i32++) {
    b_el_in_orient_ij[i32] = rot[i32 << 1];
  }

  get_R_PHI(b_el_in_orient_ij, S_nI2);
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      NI[i32 + 3 * k] = 0.0;
      for (i33 = 0; i33 < 3; i33++) {
        NI[i32 + 3 * k] += S_nI2[i32 + 3 * i33] * E0[i33 + 3 * k];
      }
    }

    b_el_in_orient_ij[i32] = rot[1 + (i32 << 1)];
  }

  get_R_PHI(b_el_in_orient_ij, S_nI2);
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      NJ[i32 + 3 * k] = 0.0;
      for (i33 = 0; i33 < 3; i33++) {
        NJ[i32 + 3 * k] += S_nI2[i32 + 3 * i33] * E0[i33 + 3 * k];
      }
    }
  }

  /*  % % % STEP 3 */
  /*  % % gammaI = get_PHI_quat(nI); */
  /*  % % gammaJ = get_PHI_quat(nJ); */
  /*  STEP 4 */
  for (i32 = 0; i32 < 9; i32++) {
    b_NI[i32] = (NI[i32] + NJ[i32]) / 2.0;
  }

  normcfast(b_NI, R_bar);

  /* normfast is faster than norm and does not do unecissary checks */
  /*  % Also need step change in rotations for arc-length solver (DELTA_U) */
  for (i32 = 0; i32 < 3; i32++) {
    b_el_in_orient_ij[i32] = U_in_DELTA_U[(3 + i32) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, dv49);
  quat_prod(delta_qi, dv49, dv50);
  get_PHI_quat(dv50, e10);
  for (i32 = 0; i32 < 3; i32++) {
    b_el_in_orient_ij[i32] = U_in_DELTA_U[1 + ((3 + i32) << 1)];
    ROT_DELTA_rot[i32 << 1] = e10[i32];
  }

  get_quat_PHI(b_el_in_orient_ij, dv51);
  quat_prod(delta_qj, dv51, dv52);
  get_PHI_quat(dv52, e30);

  /*  RI = get_R_quat(qI); */
  /*  RJ = get_R_quat(qJ); */
  /*  RI0 = get_R_PHI(U0(1,4:6)'); */
  /*  RJ0 = get_R_PHI(U0(2,4:6)'); */
  /*   */
  /*  DELTA_RI = RI*(RI0\eye(3)); */
  /*  DELTA_RJ = RJ*(RJ0\eye(3)); */
  /*   */
  /*  DELTA_rotI = get_PHI_R(DELTA_RI); */
  /*  DELTA_rotJ = get_PHI_R(DELTA_RJ); */
  /*  DELTA_rot = [DELTA_rotI'; DELTA_rotJ']; */
  /*  Compute e1, e2 and e3 to form E */
  e10[0] = L1;
  e10[1] = L2;
  e10[2] = L3;
  B = norm(e10);
  y = 0.0;
  for (k = 0; k < 3; k++) {
    ROT_DELTA_rot[1 + (k << 1)] = e30[k];
    b_e10 = e10[k] / B;
    y += R_bar[3 + k] * b_e10;
    e10[k] = b_e10;
  }

  y /= 2.0;
  for (i32 = 0; i32 < 3; i32++) {
    e30[i32] = R_bar[3 + i32] - y * (R_bar[i32] + e10[i32]);
  }

  /*  e2 = R_bar(:,2) - R_bar(:,2)'*e1/(1 + R_bar(:,1)'*e1)*(R_bar(:,1) + e1); */
  B = norm(e30);
  y = 0.0;
  for (k = 0; k < 3; k++) {
    y += R_bar[6 + k] * e10[k];
    e30[k] /= B;
  }

  y /= 2.0;
  for (i32 = 0; i32 < 3; i32++) {
    e20[i32] = R_bar[6 + i32] - y * (R_bar[i32] + e10[i32]);
  }

  /*  e3 = R_bar(:,3) - R_bar(:,3)'*e1/(1 + R_bar(:,1)'*e1)*(R_bar(:,1) + e1); */
  B = norm(e20);

  /*  E = [e1 e2 e3]; */
  /*  Compute basic rotations */
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    b_e20 = e20[k] / B;
    y += b_e20 * NI[3 + k];
    b_y += e30[k] * NI[6 + k];
    e20[k] = b_e20;
  }

  phiI1 = (y - b_y) / 2.0;
  b_asin(&phiI1);
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += e10[k] * NI[6 + k];
    b_y += e20[k] * NI[k];
  }

  phiI2 = (y - b_y) / 2.0;
  b_asin(&phiI2);
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += e30[k] * NI[k];
    b_y += e10[k] * NI[3 + k];
  }

  phiI3 = (y - b_y) / 2.0;
  b_asin(&phiI3);
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += e20[k] * NJ[3 + k];
    b_y += e30[k] * NJ[6 + k];
  }

  phiJ1 = (y - b_y) / 2.0;
  b_asin(&phiJ1);
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += e10[k] * NJ[6 + k];
    b_y += e20[k] * NJ[k];
  }

  phiJ2 = (y - b_y) / 2.0;
  b_asin(&phiJ2);
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += e30[k] * NJ[k];
    b_y += e10[k] * NJ[3 + k];
  }

  phiJ3 = (y - b_y) / 2.0;
  b_asin(&phiJ3);

  /*  Basic displacements and rotations */
  /*  D = [ul r1z r2z r1y r2y rx]' */
  D[0] = (mpower(L) - mpower(L0)) / (L + L0);
  D[1] = phiI3;
  D[2] = phiJ3;
  D[3] = phiI2;
  D[4] = phiJ2;
  D[5] = phiJ1 - phiI1;

  /*  Transformation matrix */
  y = 1.0 / L;
  eye(E0);
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      b_NI[i32 + 3 * k] = E0[i32 + 3 * k] - e10[i32] * e10[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      A[k + 3 * i32] = y * b_NI[k + 3 * i32];
    }
  }

  /*  Get L matrices */
  get_L(*(real_T (*)[3])&R_bar[3], e10, L, *(real_T (*)[3])&R_bar[0], L_r2);
  get_L(*(real_T (*)[3])&R_bar[6], e10, L, *(real_T (*)[3])&R_bar[0], L_r3);

  /*  Get h vectors */
  get_S(*(real_T (*)[3])&NI[0], E0);
  get_S(*(real_T (*)[3])&NI[3], S_nI2);
  get_S(*(real_T (*)[3])&NI[6], S_nI3);
  get_S(*(real_T (*)[3])&NJ[0], S_nJ1);
  get_S(*(real_T (*)[3])&NJ[3], S_nJ2);
  get_S(*(real_T (*)[3])&NJ[6], S_nJ3);

  /*  Get t vectors and T matrix */
  y = 1.0 / (2.0 * muDoubleScalarCos(phiI3));
  for (i32 = 0; i32 < 12; i32++) {
    b_L_r2[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      b_L_r2[i32] += L_r2[i32 + 12 * k] * NI[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    b_el_in_orient_ij[i32] = 0.0;
    c_el_in_orient_ij[i32] = 0.0;
    c_A[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      b_A[i32] += A[i32 + 3 * k] * NI[3 + k];
      b_el_in_orient_ij[i32] += E0[i32 + 3 * k] * e30[k];
      c_el_in_orient_ij[i32] += S_nI2[i32 + 3 * k] * e10[k];
      c_A[i32] += A[i32 + 3 * k] * NI[3 + k];
    }

    d_A[i32] = b_A[i32];
    d_A[i32 + 3] = b_el_in_orient_ij[i32] - c_el_in_orient_ij[i32];
    d_A[i32 + 6] = -c_A[i32];
  }

  d_A[9] = 0.0;
  d_A[10] = 0.0;
  d_A[11] = 0.0;
  b_y = 1.0 / (2.0 * muDoubleScalarCos(phiJ3));
  for (i32 = 0; i32 < 12; i32++) {
    t2[i32] = y * (b_L_r2[i32] + d_A[i32]);
    c_L_r2[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r2[i32] += L_r2[i32 + 12 * k] * NJ[k];
    }
  }

  d_A[3] = 0.0;
  d_A[4] = 0.0;
  d_A[5] = 0.0;
  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    c_A[i32] = 0.0;
    b_el_in_orient_ij[i32] = 0.0;
    c_el_in_orient_ij[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      b_A[i32] += A[i32 + 3 * k] * NJ[3 + k];
      c_A[i32] += A[i32 + 3 * k] * NJ[3 + k];
      b_el_in_orient_ij[i32] += S_nJ1[i32 + 3 * k] * e30[k];
      c_el_in_orient_ij[i32] += S_nJ2[i32 + 3 * k] * e10[k];
    }

    d_A[i32] = b_A[i32];
    d_A[i32 + 6] = -c_A[i32];
    d_A[i32 + 9] = b_el_in_orient_ij[i32] - c_el_in_orient_ij[i32];
  }

  for (i32 = 0; i32 < 12; i32++) {
    t3[i32] = b_y * (c_L_r2[i32] + d_A[i32]);
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiI2));
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 12; k++) {
      b_L_r3[k + 12 * i32] = -L_r3[k + 12 * i32];
    }
  }

  for (i32 = 0; i32 < 12; i32++) {
    c_L_r3[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r3[i32] += b_L_r3[i32 + 12 * k] * NI[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    b_el_in_orient_ij[i32] = 0.0;
    b_S_nI3[i32] = 0.0;
    c_A[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      b_A[i32] += A[i32 + 3 * k] * NI[6 + k];
      b_el_in_orient_ij[i32] += E0[i32 + 3 * k] * e20[k];
      b_S_nI3[i32] += S_nI3[i32 + 3 * k] * e10[k];
      c_A[i32] += A[i32 + 3 * k] * NI[6 + k];
    }

    d_A[i32] = b_A[i32];
    d_A[i32 + 3] = b_el_in_orient_ij[i32] - b_S_nI3[i32];
    d_A[i32 + 6] = -c_A[i32];
  }

  d_A[9] = 0.0;
  d_A[10] = 0.0;
  d_A[11] = 0.0;
  for (i32 = 0; i32 < 12; i32++) {
    t4[i32] = y * (c_L_r3[i32] - d_A[i32]);
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiJ2));
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 12; k++) {
      b_L_r3[k + 12 * i32] = -L_r3[k + 12 * i32];
    }
  }

  for (i32 = 0; i32 < 12; i32++) {
    c_L_r3[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r3[i32] += b_L_r3[i32 + 12 * k] * NJ[k];
    }
  }

  d_A[3] = 0.0;
  d_A[4] = 0.0;
  d_A[5] = 0.0;
  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    c_A[i32] = 0.0;
    b_el_in_orient_ij[i32] = 0.0;
    b_S_nI3[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      b_A[i32] += A[i32 + 3 * k] * NJ[6 + k];
      c_A[i32] += A[i32 + 3 * k] * NJ[6 + k];
      b_el_in_orient_ij[i32] += S_nJ1[i32 + 3 * k] * e20[k];
      b_S_nI3[i32] += S_nJ3[i32 + 3 * k] * e10[k];
    }

    d_A[i32] = b_A[i32];
    d_A[i32 + 6] = -c_A[i32];
    d_A[i32 + 9] = b_el_in_orient_ij[i32] - b_S_nI3[i32];
  }

  b_y = 1.0 / (2.0 * muDoubleScalarCos(phiJ1));
  for (i32 = 0; i32 < 12; i32++) {
    t5[i32] = y * (c_L_r3[i32] - d_A[i32]);
    d_L_r3[i32] = 0.0;
    b_L_r2[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      d_L_r3[i32] += L_r3[i32 + 12 * k] * NJ[3 + k];
      b_L_r2[i32] += L_r2[i32 + 12 * k] * NJ[6 + k];
    }
  }

  d_A[0] = 0.0;
  d_A[1] = 0.0;
  d_A[2] = 0.0;
  d_A[3] = 0.0;
  d_A[4] = 0.0;
  d_A[5] = 0.0;
  d_A[6] = 0.0;
  d_A[7] = 0.0;
  d_A[8] = 0.0;
  for (i32 = 0; i32 < 3; i32++) {
    c_el_in_orient_ij[i32] = 0.0;
    b_S_nI3[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      c_el_in_orient_ij[i32] += S_nJ2[i32 + 3 * k] * e20[k];
      b_S_nI3[i32] += S_nJ3[i32 + 3 * k] * e30[k];
    }

    d_A[i32 + 9] = c_el_in_orient_ij[i32] - b_S_nI3[i32];
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiI1));
  for (i32 = 0; i32 < 12; i32++) {
    t6J[i32] = b_y * ((d_L_r3[i32] - b_L_r2[i32]) + d_A[i32]);
    c_L_r3[i32] = 0.0;
    c_L_r2[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r3[i32] += L_r3[i32 + 12 * k] * NI[3 + k];
      c_L_r2[i32] += L_r2[i32 + 12 * k] * NI[6 + k];
    }
  }

  d_A[0] = 0.0;
  d_A[1] = 0.0;
  d_A[2] = 0.0;
  for (i32 = 0; i32 < 3; i32++) {
    c_el_in_orient_ij[i32] = 0.0;
    b_S_nI3[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      c_el_in_orient_ij[i32] += S_nI2[i32 + 3 * k] * e20[k];
      b_S_nI3[i32] += S_nI3[i32 + 3 * k] * e30[k];
    }

    d_A[i32 + 3] = c_el_in_orient_ij[i32] - b_S_nI3[i32];
  }

  d_A[6] = 0.0;
  d_A[7] = 0.0;
  d_A[8] = 0.0;
  d_A[9] = 0.0;
  d_A[10] = 0.0;
  d_A[11] = 0.0;
  for (i32 = 0; i32 < 12; i32++) {
    t6I[i32] = y * ((c_L_r3[i32] - c_L_r2[i32]) + d_A[i32]);
  }

  T[18] = 0.0;
  T[24] = 0.0;
  T[30] = 0.0;
  for (i32 = 0; i32 < 3; i32++) {
    T[6 * i32] = -e10[i32];
    T[6 * (i32 + 6)] = e10[i32];
  }

  T[54] = 0.0;
  T[60] = 0.0;
  T[66] = 0.0;

  /*  Linear stiffness matrix */
  k1(el_in0->mat, el_in0->geom, L0, b_k);

  /*  Condense into relevant entries for corotational formulation */
  for (i32 = 0; i32 < 12; i32++) {
    T[1 + 6 * i32] = t2[i32];
    T[2 + 6 * i32] = t3[i32];
    T[3 + 6 * i32] = t4[i32];
    T[4 + 6 * i32] = t5[i32];
    T[5 + 6 * i32] = t6J[i32] - t6I[i32];
    c_k[i32] = b_k[i32];
    c_k[12 + i32] = b_k[60 + i32];
    c_k[24 + i32] = b_k[132 + i32];
    c_k[36 + i32] = b_k[48 + i32];
    c_k[48 + i32] = b_k[120 + i32];
    c_k[60 + i32] = b_k[36 + i32];
  }

  /*  [u1x r1z r2z r1y r2y r1x] */
  for (i32 = 0; i32 < 6; i32++) {
    KL[6 * i32] = c_k[12 * i32];
    KL[1 + 6 * i32] = c_k[5 + 12 * i32];
    KL[2 + 6 * i32] = c_k[11 + 12 * i32];
    KL[3 + 6 * i32] = c_k[4 + 12 * i32];
    KL[4 + 6 * i32] = c_k[10 + 12 * i32];
    KL[5 + 6 * i32] = c_k[3 + 12 * i32];
  }

  for (i32 = 0; i32 < 6; i32++) {
    P[i32] = 0.0;
    for (k = 0; k < 6; k++) {
      P[i32] += KL[i32 + 6 * k] * D[k];
    }
  }

  /*  Internal forces in local coordinate system */
  /*  Vx1 */
  /*  Vy1 */
  /*  Vz1 */
  /*  Mx1 */
  /*  My1 */
  /*  Mz1 */
  /*  Vx2 */
  /*  Vy2 */
  /*  Vz2 */
  /*  Mx2 */
  /*  My2 */
  fint_i[0] = -P[0];
  fint_i[1] = (P[2] + P[1]) / L;
  fint_i[2] = -(P[4] + P[3]) / L;
  fint_i[3] = -P[5];
  fint_i[4] = P[3];
  fint_i[5] = P[1];
  fint_i[6] = P[0];
  fint_i[7] = -(P[2] + P[1]) / L;
  fint_i[8] = (P[4] + P[3]) / L;
  fint_i[9] = P[5];
  fint_i[10] = P[4];
  fint_i[11] = P[2];

  /*  Mz2 */
  /*  Scaled internal forces */
  m2 = P[1] / (2.0 * muDoubleScalarCos(phiI3));
  m3 = P[2] / (2.0 * muDoubleScalarCos(phiJ3));
  m4 = P[3] / (2.0 * muDoubleScalarCos(phiI2));
  m5 = P[4] / (2.0 * muDoubleScalarCos(phiJ2));
  m6I = P[5] / (2.0 * muDoubleScalarCos(phiI1));
  m6J = P[5] / (2.0 * muDoubleScalarCos(phiJ1));

  /*  Geometric stiffness matrix, KG */
  /*  KA */
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      e_A[k + 12 * i32] = A[k + 3 * i32];
      e_A[k + 12 * (i32 + 3)] = 0.0;
      e_A[k + 12 * (i32 + 6)] = -A[k + 3 * i32];
      e_A[k + 12 * (i32 + 9)] = 0.0;
    }
  }

  for (i32 = 0; i32 < 12; i32++) {
    for (k = 0; k < 3; k++) {
      e_A[(k + 12 * i32) + 3] = 0.0;
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      e_A[(k + 12 * i32) + 6] = -A[k + 3 * i32];
      e_A[(k + 12 * (i32 + 3)) + 6] = 0.0;
      e_A[(k + 12 * (i32 + 6)) + 6] = A[k + 3 * i32];
      e_A[(k + 12 * (i32 + 9)) + 6] = 0.0;
    }
  }

  for (i32 = 0; i32 < 12; i32++) {
    for (k = 0; k < 3; k++) {
      e_A[(k + 12 * i32) + 9] = 0.0;
    }

    for (k = 0; k < 12; k++) {
      b_k[k + 12 * i32] = P[0] * e_A[k + 12 * i32];
    }
  }

  /*  KB */
  x = muDoubleScalarTan(phiI3);
  b_x = muDoubleScalarTan(phiJ3);
  c_x = muDoubleScalarTan(phiI2);
  d_x = muDoubleScalarTan(phiJ2);
  e_x = muDoubleScalarTan(phiI1);
  f_x = muDoubleScalarTan(phiJ1);

  /*  P(6)I? */
  /*  KC */
  /*  KD */
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 12; k++) {
      d_L_r2[k + 12 * i32] = -L_r2[k + 12 * i32];
    }

    for (k = 0; k < 3; k++) {
      b_m2[k + 3 * i32] = m2 * E0[k + 3 * i32] + m6I * S_nI3[k + 3 * i32];
      b_m4[k + 3 * i32] = m4 * E0[k + 3 * i32] + m6I * S_nI2[k + 3 * i32];
    }
  }

  for (i32 = 0; i32 < 12; i32++) {
    for (k = 0; k < 3; k++) {
      e_L_r2[i32 + 12 * k] = 0.0;
      b_L_r3[i32 + 12 * k] = 0.0;
      for (i33 = 0; i33 < 3; i33++) {
        e_L_r2[i32 + 12 * k] += d_L_r2[i32 + 12 * i33] * b_m2[i33 + 3 * k];
        b_L_r3[i32 + 12 * k] += L_r3[i32 + 12 * i33] * b_m4[i33 + 3 * k];
      }
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 12; k++) {
      d_L_r2[k + 12 * i32] = -L_r2[k + 12 * i32];
    }

    for (k = 0; k < 3; k++) {
      b_NI[k + 3 * i32] = m3 * S_nJ1[k + 3 * i32] - m6J * S_nJ3[k + 3 * i32];
      b_m5[k + 3 * i32] = m5 * S_nJ1[k + 3 * i32] - m6J * S_nJ2[k + 3 * i32];
    }
  }

  for (i32 = 0; i32 < 12; i32++) {
    for (k = 0; k < 3; k++) {
      L_r2[i32 + 12 * k] = 0.0;
      e_L_r3[i32 + 12 * k] = 0.0;
      for (i33 = 0; i33 < 3; i33++) {
        L_r2[i32 + 12 * k] += d_L_r2[i32 + 12 * i33] * b_NI[i33 + 3 * k];
        e_L_r3[i32 + 12 * k] += L_r3[i32 + 12 * i33] * b_m5[i33 + 3 * k];
      }
    }
  }

  /*  KE */
  /*  KF */
  /*  M_nI2 = get_M_mex(NI(:,2),e1,L); */
  /*  M_nJ2 = get_M_mex(NJ(:,2),e1,L); */
  /*  M_nI3 = get_M_mex(NI(:,3),e1,L); */
  /*  M_nJ3 = get_M_mex(NJ(:,3),e1,L); */
  y = 1.0 / L;
  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 12; k++) {
      KD[k + 12 * i32] = 0.0;
      KD[k + 12 * (i32 + 3)] = e_L_r2[k + 12 * i32] + b_L_r3[k + 12 * i32];
      KD[k + 12 * (i32 + 6)] = 0.0;
      KD[k + 12 * (i32 + 9)] = L_r2[k + 12 * i32] + e_L_r3[k + 12 * i32];
    }

    for (k = 0; k < 3; k++) {
      b_NI[i32 + 3 * k] = (real_T)iv43[i32 + 3 * k] - e10[i32] * e10[k];
    }
  }

  b_y = -1.0 / L;
  B = 0.0;
  c_y = -1.0 / L;
  d_y = 0.0;
  e_y = -1.0 / L;
  f_y = 0.0;
  g_y = -1.0 / L;
  h_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i32 = 0; i32 < 3; i32++) {
      A[i32 + 3 * k] = y * b_NI[i32 + 3 * k];
    }

    B += e10[k] * NI[3 + k];
    d_y += e10[k] * NJ[3 + k];
    f_y += e10[k] * NI[6 + k];
    h_y += e10[k] * NJ[6 + k];
  }

  get_S(e30, S_e2);
  get_S(e10, S_e1);
  get_S(e20, S_e3);
  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    c_A[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      b_A[i32] += A[i32 + 3 * k] * NI[3 + k];
      c_A[i32] += A[i32 + 3 * k] * NI[3 + k];
    }

    for (k = 0; k < 3; k++) {
      b_NI[i32 + 3 * k] = b_A[i32] * e10[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    b_el_in_orient_ij[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      f_A[i32 + 3 * k] = c_A[k] * e10[i32];
      b_A[i32] += A[i32 + 3 * k] * NJ[3 + k];
      b_el_in_orient_ij[i32] += A[i32 + 3 * k] * NJ[3 + k];
    }

    for (k = 0; k < 3; k++) {
      b_m5[i32 + 3 * k] = b_A[i32] * e10[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    c_A[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      h_A[i32 + 3 * k] = b_el_in_orient_ij[k] * e10[i32];
      b_A[i32] += A[i32 + 3 * k] * NI[6 + k];
      c_A[i32] += A[i32 + 3 * k] * NI[6 + k];
    }

    for (k = 0; k < 3; k++) {
      g_A[i32 + 3 * k] = b_A[i32] * e10[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    b_A[i32] = 0.0;
    b_el_in_orient_ij[i32] = 0.0;
    for (k = 0; k < 3; k++) {
      j_A[i32 + 3 * k] = c_A[k] * e10[i32];
      b_A[i32] += A[i32 + 3 * k] * NJ[6 + k];
      b_el_in_orient_ij[i32] += A[i32 + 3 * k] * NJ[6 + k];
    }

    for (k = 0; k < 3; k++) {
      i_A[i32 + 3 * k] = b_A[i32] * e10[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      k_A[i32 + 3 * k] = b_el_in_orient_ij[k] * e10[i32];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      KF11[k + 3 * i32] = ((-m2 * (b_y * ((b_NI[k + 3 * i32] + f_A[k + 3 * i32])
        + A[k + 3 * i32] * B)) - m3 * (c_y * ((b_m5[k + 3 * i32] + h_A[k + 3 *
        i32]) + A[k + 3 * i32] * d_y))) + m4 * (e_y * ((g_A[k + 3 * i32] + j_A[k
        + 3 * i32]) + A[k + 3 * i32] * f_y))) + m5 * (g_y * ((i_A[k + 3 * i32] +
        k_A[k + 3 * i32]) + A[k + 3 * i32] * h_y));
      b_m2[i32 + 3 * k] = 0.0;
      b_m4[i32 + 3 * k] = 0.0;
      for (i33 = 0; i33 < 3; i33++) {
        b_m2[i32 + 3 * k] += -m2 * A[i32 + 3 * i33] * S_nI2[i33 + 3 * k];
        b_m4[i32 + 3 * k] += m4 * A[i32 + 3 * i33] * S_nI3[i33 + 3 * k];
      }
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      KF12[k + 3 * i32] = b_m2[k + 3 * i32] + b_m4[k + 3 * i32];
      b_NI[i32 + 3 * k] = 0.0;
      b_m5[i32 + 3 * k] = 0.0;
      for (i33 = 0; i33 < 3; i33++) {
        b_NI[i32 + 3 * k] += -m3 * A[i32 + 3 * i33] * S_nJ2[i33 + 3 * k];
        b_m5[i32 + 3 * k] += m5 * A[i32 + 3 * i33] * S_nJ3[i33 + 3 * k];
      }
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      KF14[k + 3 * i32] = b_NI[k + 3 * i32] + b_m5[k + 3 * i32];
    }
  }

  /*  KG - geometric stiffness matrix */
  /*  Element global tangent stiffness matrix */
  for (i32 = 0; i32 < 12; i32++) {
    for (k = 0; k < 6; k++) {
      c_k[i32 + 12 * k] = 0.0;
      for (i33 = 0; i33 < 6; i33++) {
        c_k[i32 + 12 * k] += T[i33 + 6 * i32] * KL[i33 + 6 * k];
      }
    }
  }

  B = 1.0;
  c_y = 0.0;
  TRANSB = 'N';
  TRANSA = 'N';
  memset(&i_y[0], 0, 144U * sizeof(real_T));
  m_t = (ptrdiff_t)12;
  n_t = (ptrdiff_t)12;
  k_t = (ptrdiff_t)6;
  lda_t = (ptrdiff_t)12;
  ldb_t = (ptrdiff_t)6;
  ldc_t = (ptrdiff_t)12;
  dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &B, &c_k[0], &lda_t, &T[0], &ldb_t,
        &c_y, &i_y[0], &ldc_t);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NI[0], e10, L, *(real_T (*)
         [3])&R_bar[0], e_A);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NJ[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv53);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NI[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv54);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NJ[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv55);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NJ[3], e10, L, *(real_T (*)
         [3])&R_bar[0], dv56);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NJ[6], e10, L, *(real_T (*)
         [3])&R_bar[0], dv57);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NI[3], e10, L, *(real_T (*)
         [3])&R_bar[0], dv58);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NI[6], e10, L, *(real_T (*)
         [3])&R_bar[0], dv59);
  for (i32 = 0; i32 < 12; i32++) {
    d_A[i32] = -t6I[i32];
    for (k = 0; k < 12; k++) {
      b_t2[i32 + 12 * k] = t2[i32] * t2[k];
      b_t3[i32 + 12 * k] = t3[i32] * t3[k];
      b_t4[i32 + 12 * k] = t4[i32] * t4[k];
      b_t5[i32 + 12 * k] = t5[i32] * t5[k];
      b_t6I[i32 + 12 * k] = d_A[i32] * t6I[k];
      b_t6J[i32 + 12 * k] = t6J[i32] * t6J[k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      b_NI[i32 + 3 * k] = 0.0;
      b_m5[i32 + 3 * k] = 0.0;
      f_A[i32 + 3 * k] = 0.0;
      g_A[i32 + 3 * k] = 0.0;
      h_A[i32 + 3 * k] = 0.0;
      i_A[i32 + 3 * k] = 0.0;
      j_A[i32 + 3 * k] = 0.0;
      k_A[i32 + 3 * k] = 0.0;
      b_m2[i32 + 3 * k] = 0.0;
      b_m4[i32 + 3 * k] = 0.0;
      b_S_e3[i32 + 3 * k] = 0.0;
      b_S_e2[i32 + 3 * k] = 0.0;
      for (i33 = 0; i33 < 3; i33++) {
        b_NI[i32 + 3 * k] += S_e2[i32 + 3 * i33] * E0[i33 + 3 * k];
        b_m5[i32 + 3 * k] += S_e1[i32 + 3 * i33] * S_nI2[i33 + 3 * k];
        f_A[i32 + 3 * k] += S_e3[i32 + 3 * i33] * E0[i33 + 3 * k];
        g_A[i32 + 3 * k] += S_e1[i32 + 3 * i33] * S_nI3[i33 + 3 * k];
        h_A[i32 + 3 * k] += S_e3[i32 + 3 * i33] * S_nI2[i33 + 3 * k];
        i_A[i32 + 3 * k] += S_e2[i32 + 3 * i33] * S_nI3[i33 + 3 * k];
        j_A[i32 + 3 * k] += S_e2[i32 + 3 * i33] * S_nJ1[i33 + 3 * k];
        k_A[i32 + 3 * k] += S_e1[i32 + 3 * i33] * S_nJ2[i33 + 3 * k];
        b_m2[i32 + 3 * k] += S_e3[i32 + 3 * i33] * S_nJ1[i33 + 3 * k];
        b_m4[i32 + 3 * k] += S_e1[i32 + 3 * i33] * S_nJ3[i33 + 3 * k];
        b_S_e3[i32 + 3 * k] += S_e3[i32 + 3 * i33] * S_nJ2[i33 + 3 * k];
        b_S_e2[i32 + 3 * k] += S_e2[i32 + 3 * i33] * S_nJ3[i33 + 3 * k];
      }

      b_KF11[k + 12 * i32] = KF11[k + 3 * i32];
      b_KF11[k + 12 * (i32 + 3)] = KF12[k + 3 * i32];
      b_KF11[k + 12 * (i32 + 6)] = -KF11[k + 3 * i32];
      b_KF11[k + 12 * (i32 + 9)] = KF14[k + 3 * i32];
      b_KF11[(k + 12 * i32) + 3] = KF12[i32 + 3 * k];
    }
  }

  for (i32 = 0; i32 < 3; i32++) {
    for (k = 0; k < 3; k++) {
      b_KF11[(k + 12 * (i32 + 3)) + 3] = (m2 * (b_NI[k + 3 * i32] - b_m5[k + 3 *
        i32]) - m4 * (f_A[k + 3 * i32] - g_A[k + 3 * i32])) - m6I * (h_A[k + 3 *
        i32] - i_A[k + 3 * i32]);
      b_KF11[(k + 12 * (i32 + 6)) + 3] = -KF12[i32 + 3 * k];
      b_KF11[(k + 12 * (i32 + 9)) + 3] = 0.0;
      b_KF11[(k + 12 * i32) + 6] = -KF11[k + 3 * i32];
      b_KF11[(k + 12 * (i32 + 3)) + 6] = -KF12[k + 3 * i32];
      b_KF11[(k + 12 * (i32 + 6)) + 6] = KF11[k + 3 * i32];
      b_KF11[(k + 12 * (i32 + 9)) + 6] = -KF14[k + 3 * i32];
      b_KF11[(k + 12 * i32) + 9] = KF14[i32 + 3 * k];
      b_KF11[(k + 12 * (i32 + 3)) + 9] = 0.0;
      b_KF11[(k + 12 * (i32 + 6)) + 9] = -KF14[i32 + 3 * k];
      b_KF11[(k + 12 * (i32 + 9)) + 9] = (m3 * (j_A[k + 3 * i32] - k_A[k + 3 *
        i32]) - m5 * (b_m2[k + 3 * i32] - b_m4[k + 3 * i32])) + m6J * (b_S_e3[k
        + 3 * i32] - b_S_e2[k + 3 * i32]);
    }
  }

  /*  Element global internal force vector */
  for (i32 = 0; i32 < 12; i32++) {
    for (k = 0; k < 12; k++) {
      Kel[k + 12 * i32] = i_y[k + 12 * i32] + (((((b_k[k + 12 * i32] + ((((P[1] *
        b_t2[k + 12 * i32] * x + P[2] * b_t3[k + 12 * i32] * b_x) + P[3] *
        b_t4[k + 12 * i32] * c_x) + P[4] * b_t5[k + 12 * i32] * d_x) + P[5] *
        (b_t6I[k + 12 * i32] * e_x + b_t6J[k + 12 * i32] * f_x))) + (((((m2 *
        e_A[k + 12 * i32] + m3 * dv53[k + 12 * i32]) - m4 * dv54[k + 12 * i32])
        - m5 * dv55[k + 12 * i32]) + m6I * (dv56[k + 12 * i32] - dv57[k + 12 *
        i32])) - m6J * (dv58[k + 12 * i32] - dv59[k + 12 * i32]))) + KD[k + 12 *
        i32]) + KD[i32 + 12 * k]) + b_KF11[k + 12 * i32]);
    }

    Fint_i[i32] = 0.0;
    for (k = 0; k < 6; k++) {
      Fint_i[i32] += T[k + 6 * i32] * P[k];
    }
  }

  /*  Do not need to save any variables for future iterations */
  el_in0->b_break = 0.0;
}

/* End of code generation (el2.c) */
