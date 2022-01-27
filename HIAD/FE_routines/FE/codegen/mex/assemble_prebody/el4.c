/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * el4.c
 *
 * Code generation for function 'el4'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "el4.h"
#include "ppval_fast.h"
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
void el4(emlrtCTX aTLS, const real_T U_in_U[12], const real_T U_in_delta_U[12],
         const real_T U_in_DELTA_U[12], const real_T el_in_nodes_ij[6], const
         real_T el_in_orient_ij[3], b_struct_T *el_in0, real_T Kel[144], real_T
         fint_i[12], real_T Fint_i[12], real_T ROT_rot[6], real_T ROT_DELTA_rot
         [6])
{
  real_T geom[5];
  int32_T i35;
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
  real_T e30[3];
  real_T e20[3];
  real_T E0[9];
  real_T delta_qi[4];
  real_T delta_qj[4];
  real_T dv60[4];
  real_T dv61[4];
  real_T rot[6];
  real_T dv62[4];
  real_T dv63[4];
  real_T S_nI2[9];
  int32_T k;
  real_T NI[9];
  int32_T i36;
  real_T NJ[9];
  real_T b_NI[9];
  real_T R_bar[9];
  real_T dv64[4];
  real_T dv65[4];
  real_T dv66[4];
  real_T dv67[4];
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
  real_T A;
  real_T D[6];
  real_T b_A[9];
  real_T L_r2[36];
  real_T L_r3[36];
  real_T S_nI3[9];
  real_T S_nJ1[9];
  real_T S_nJ2[9];
  real_T S_nJ3[9];
  real_T b_L_r2[12];
  real_T c_A[3];
  real_T d_A[3];
  real_T e_A[12];
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
  real_T eps_ax;
  real_T f;
  real_T EAax;
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
  real_T f_A[144];
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
  static const int8_T iv47[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  real_T c_y;
  real_T d_y;
  real_T e_y;
  real_T f_y;
  real_T g_y;
  real_T S_e2[9];
  real_T S_e1[9];
  real_T S_e3[9];
  real_T g_A[9];
  real_T h_A[9];
  real_T i_A[9];
  real_T j_A[9];
  real_T k_A[9];
  real_T l_A[9];
  real_T KF11[9];
  real_T KF12[9];
  real_T KF14[9];
  char_T TRANSB;
  char_T TRANSA;
  real_T h_y[144];
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  real_T dv68[144];
  real_T dv69[144];
  real_T dv70[144];
  real_T dv71[144];
  real_T dv72[144];
  real_T dv73[144];
  real_T dv74[144];
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
  for (i35 = 0; i35 < 5; i35++) {
    geom[i35] = el_in0->geom[i35];
  }

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
  for (i35 = 0; i35 < 3; i35++) {
    c_el_in_orient_ij[i35] = b_el_in_orient_ij[i35];
    e10[i35] /= B;
  }

  cross(e10, c_el_in_orient_ij, e30);
  B = norm(e30);
  for (i35 = 0; i35 < 3; i35++) {
    e30[i35] /= B;
  }

  cross(e30, e10, e20);
  B = norm(e20);

  /*  Section 5.3.2a - de Souza */
  /*  e0 = get_quat_R(E0); */
  for (i35 = 0; i35 < 3; i35++) {
    E0[i35] = e10[i35];
    E0[3 + i35] = e20[i35] / B;
    E0[6 + i35] = e30[i35];
    b_el_in_orient_ij[i35] = U_in_delta_U[(3 + i35) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, delta_qi);
  for (i35 = 0; i35 < 3; i35++) {
    b_el_in_orient_ij[i35] = U_in_delta_U[1 + ((3 + i35) << 1)];
  }

  get_quat_PHI(b_el_in_orient_ij, delta_qj);

  /*  STEP 2 */
  /*  Equation 5.46 */
  /*  Calculate nodal rotation for incorporation into displacement vector */
  for (i35 = 0; i35 < 3; i35++) {
    b_el_in_orient_ij[i35] = U_in_U[(3 + i35) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, dv60);
  quat_prod(delta_qi, dv60, dv61);
  get_PHI_quat(dv61, e10);
  for (i35 = 0; i35 < 3; i35++) {
    b_el_in_orient_ij[i35] = U_in_U[1 + ((3 + i35) << 1)];
    rot[i35 << 1] = e10[i35];
  }

  get_quat_PHI(b_el_in_orient_ij, dv62);
  quat_prod(delta_qj, dv62, dv63);
  get_PHI_quat(dv63, e30);
  for (i35 = 0; i35 < 3; i35++) {
    rot[1 + (i35 << 1)] = e30[i35];
  }

  for (i35 = 0; i35 < 6; i35++) {
    ROT_rot[i35] = rot[i35];
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
  for (i35 = 0; i35 < 3; i35++) {
    b_el_in_orient_ij[i35] = rot[i35 << 1];
  }

  get_R_PHI(b_el_in_orient_ij, S_nI2);
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      NI[i35 + 3 * k] = 0.0;
      for (i36 = 0; i36 < 3; i36++) {
        NI[i35 + 3 * k] += S_nI2[i35 + 3 * i36] * E0[i36 + 3 * k];
      }
    }

    b_el_in_orient_ij[i35] = rot[1 + (i35 << 1)];
  }

  get_R_PHI(b_el_in_orient_ij, S_nI2);
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      NJ[i35 + 3 * k] = 0.0;
      for (i36 = 0; i36 < 3; i36++) {
        NJ[i35 + 3 * k] += S_nI2[i35 + 3 * i36] * E0[i36 + 3 * k];
      }
    }
  }

  /*  % % % STEP 3 */
  /*  % % gammaI = get_PHI_quat(nI); */
  /*  % % gammaJ = get_PHI_quat(nJ); */
  /*  STEP 4 */
  for (i35 = 0; i35 < 9; i35++) {
    b_NI[i35] = (NI[i35] + NJ[i35]) / 2.0;
  }

  normcfast(b_NI, R_bar);

  /* normfast is faster than norm and does not do unecissary checks */
  /*  % Also need step change in rotations for arc-length solver (DELTA_U) */
  for (i35 = 0; i35 < 3; i35++) {
    b_el_in_orient_ij[i35] = U_in_DELTA_U[(3 + i35) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, dv64);
  quat_prod(delta_qi, dv64, dv65);
  get_PHI_quat(dv65, e10);
  for (i35 = 0; i35 < 3; i35++) {
    b_el_in_orient_ij[i35] = U_in_DELTA_U[1 + ((3 + i35) << 1)];
    ROT_DELTA_rot[i35 << 1] = e10[i35];
  }

  get_quat_PHI(b_el_in_orient_ij, dv66);
  quat_prod(delta_qj, dv66, dv67);
  get_PHI_quat(dv67, e30);

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
  for (i35 = 0; i35 < 3; i35++) {
    e30[i35] = R_bar[3 + i35] - y * (R_bar[i35] + e10[i35]);
  }

  /*  e2 = R_bar(:,2) - R_bar(:,2)'*e1/(1 + R_bar(:,1)'*e1)*(R_bar(:,1) + e1); */
  B = norm(e30);
  y = 0.0;
  for (k = 0; k < 3; k++) {
    y += R_bar[6 + k] * e10[k];
    e30[k] /= B;
  }

  y /= 2.0;
  for (i35 = 0; i35 < 3; i35++) {
    e20[i35] = R_bar[6 + i35] - y * (R_bar[i35] + e10[i35]);
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
  A = mpower(L) - mpower(L0);
  B = L + L0;
  D[0] = A / B;
  D[1] = phiI3;
  D[2] = phiJ3;
  D[3] = phiI2;
  D[4] = phiJ2;
  D[5] = phiJ1 - phiI1;

  /*  Transformation matrix */
  y = 1.0 / L;
  eye(E0);
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      b_NI[i35 + 3 * k] = E0[i35 + 3 * k] - e10[i35] * e10[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      b_A[k + 3 * i35] = y * b_NI[k + 3 * i35];
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
  for (i35 = 0; i35 < 12; i35++) {
    b_L_r2[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      b_L_r2[i35] += L_r2[i35 + 12 * k] * NI[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    b_el_in_orient_ij[i35] = 0.0;
    c_el_in_orient_ij[i35] = 0.0;
    d_A[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_A[i35] += b_A[i35 + 3 * k] * NI[3 + k];
      b_el_in_orient_ij[i35] += E0[i35 + 3 * k] * e30[k];
      c_el_in_orient_ij[i35] += S_nI2[i35 + 3 * k] * e10[k];
      d_A[i35] += b_A[i35 + 3 * k] * NI[3 + k];
    }

    e_A[i35] = c_A[i35];
    e_A[i35 + 3] = b_el_in_orient_ij[i35] - c_el_in_orient_ij[i35];
    e_A[i35 + 6] = -d_A[i35];
  }

  e_A[9] = 0.0;
  e_A[10] = 0.0;
  e_A[11] = 0.0;
  b_y = 1.0 / (2.0 * muDoubleScalarCos(phiJ3));
  for (i35 = 0; i35 < 12; i35++) {
    t2[i35] = y * (b_L_r2[i35] + e_A[i35]);
    c_L_r2[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r2[i35] += L_r2[i35 + 12 * k] * NJ[k];
    }
  }

  e_A[3] = 0.0;
  e_A[4] = 0.0;
  e_A[5] = 0.0;
  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    d_A[i35] = 0.0;
    b_el_in_orient_ij[i35] = 0.0;
    c_el_in_orient_ij[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_A[i35] += b_A[i35 + 3 * k] * NJ[3 + k];
      d_A[i35] += b_A[i35 + 3 * k] * NJ[3 + k];
      b_el_in_orient_ij[i35] += S_nJ1[i35 + 3 * k] * e30[k];
      c_el_in_orient_ij[i35] += S_nJ2[i35 + 3 * k] * e10[k];
    }

    e_A[i35] = c_A[i35];
    e_A[i35 + 6] = -d_A[i35];
    e_A[i35 + 9] = b_el_in_orient_ij[i35] - c_el_in_orient_ij[i35];
  }

  for (i35 = 0; i35 < 12; i35++) {
    t3[i35] = b_y * (c_L_r2[i35] + e_A[i35]);
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiI2));
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 12; k++) {
      b_L_r3[k + 12 * i35] = -L_r3[k + 12 * i35];
    }
  }

  for (i35 = 0; i35 < 12; i35++) {
    c_L_r3[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r3[i35] += b_L_r3[i35 + 12 * k] * NI[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    b_el_in_orient_ij[i35] = 0.0;
    b_S_nI3[i35] = 0.0;
    d_A[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_A[i35] += b_A[i35 + 3 * k] * NI[6 + k];
      b_el_in_orient_ij[i35] += E0[i35 + 3 * k] * e20[k];
      b_S_nI3[i35] += S_nI3[i35 + 3 * k] * e10[k];
      d_A[i35] += b_A[i35 + 3 * k] * NI[6 + k];
    }

    e_A[i35] = c_A[i35];
    e_A[i35 + 3] = b_el_in_orient_ij[i35] - b_S_nI3[i35];
    e_A[i35 + 6] = -d_A[i35];
  }

  e_A[9] = 0.0;
  e_A[10] = 0.0;
  e_A[11] = 0.0;
  for (i35 = 0; i35 < 12; i35++) {
    t4[i35] = y * (c_L_r3[i35] - e_A[i35]);
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiJ2));
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 12; k++) {
      b_L_r3[k + 12 * i35] = -L_r3[k + 12 * i35];
    }
  }

  for (i35 = 0; i35 < 12; i35++) {
    c_L_r3[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r3[i35] += b_L_r3[i35 + 12 * k] * NJ[k];
    }
  }

  e_A[3] = 0.0;
  e_A[4] = 0.0;
  e_A[5] = 0.0;
  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    d_A[i35] = 0.0;
    b_el_in_orient_ij[i35] = 0.0;
    b_S_nI3[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_A[i35] += b_A[i35 + 3 * k] * NJ[6 + k];
      d_A[i35] += b_A[i35 + 3 * k] * NJ[6 + k];
      b_el_in_orient_ij[i35] += S_nJ1[i35 + 3 * k] * e20[k];
      b_S_nI3[i35] += S_nJ3[i35 + 3 * k] * e10[k];
    }

    e_A[i35] = c_A[i35];
    e_A[i35 + 6] = -d_A[i35];
    e_A[i35 + 9] = b_el_in_orient_ij[i35] - b_S_nI3[i35];
  }

  b_y = 1.0 / (2.0 * muDoubleScalarCos(phiJ1));
  for (i35 = 0; i35 < 12; i35++) {
    t5[i35] = y * (c_L_r3[i35] - e_A[i35]);
    d_L_r3[i35] = 0.0;
    b_L_r2[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      d_L_r3[i35] += L_r3[i35 + 12 * k] * NJ[3 + k];
      b_L_r2[i35] += L_r2[i35 + 12 * k] * NJ[6 + k];
    }
  }

  e_A[0] = 0.0;
  e_A[1] = 0.0;
  e_A[2] = 0.0;
  e_A[3] = 0.0;
  e_A[4] = 0.0;
  e_A[5] = 0.0;
  e_A[6] = 0.0;
  e_A[7] = 0.0;
  e_A[8] = 0.0;
  for (i35 = 0; i35 < 3; i35++) {
    c_el_in_orient_ij[i35] = 0.0;
    b_S_nI3[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_el_in_orient_ij[i35] += S_nJ2[i35 + 3 * k] * e20[k];
      b_S_nI3[i35] += S_nJ3[i35 + 3 * k] * e30[k];
    }

    e_A[i35 + 9] = c_el_in_orient_ij[i35] - b_S_nI3[i35];
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiI1));
  for (i35 = 0; i35 < 12; i35++) {
    t6J[i35] = b_y * ((d_L_r3[i35] - b_L_r2[i35]) + e_A[i35]);
    c_L_r3[i35] = 0.0;
    c_L_r2[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_L_r3[i35] += L_r3[i35 + 12 * k] * NI[3 + k];
      c_L_r2[i35] += L_r2[i35 + 12 * k] * NI[6 + k];
    }
  }

  e_A[0] = 0.0;
  e_A[1] = 0.0;
  e_A[2] = 0.0;
  for (i35 = 0; i35 < 3; i35++) {
    c_el_in_orient_ij[i35] = 0.0;
    b_S_nI3[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_el_in_orient_ij[i35] += S_nI2[i35 + 3 * k] * e20[k];
      b_S_nI3[i35] += S_nI3[i35 + 3 * k] * e30[k];
    }

    e_A[i35 + 3] = c_el_in_orient_ij[i35] - b_S_nI3[i35];
  }

  e_A[6] = 0.0;
  e_A[7] = 0.0;
  e_A[8] = 0.0;
  e_A[9] = 0.0;
  e_A[10] = 0.0;
  e_A[11] = 0.0;
  for (i35 = 0; i35 < 12; i35++) {
    t6I[i35] = y * ((c_L_r3[i35] - c_L_r2[i35]) + e_A[i35]);
  }

  T[18] = 0.0;
  T[24] = 0.0;
  T[30] = 0.0;
  for (i35 = 0; i35 < 3; i35++) {
    T[6 * i35] = -e10[i35];
    T[6 * (i35 + 6)] = e10[i35];
  }

  T[54] = 0.0;
  T[60] = 0.0;
  T[66] = 0.0;
  for (i35 = 0; i35 < 12; i35++) {
    T[1 + 6 * i35] = t2[i35];
    T[2 + 6 * i35] = t3[i35];
    T[3 + 6 * i35] = t4[i35];
    T[4 + 6 * i35] = t5[i35];
    T[5 + 6 * i35] = t6J[i35] - t6I[i35];
  }

  /*  % % % Axial stiffness */
  /*  % % eps_ax = D(1)/L0; % Axial strain */
  /*  % % d_eps = 1e-4; % step size */
  /*  % % f = ppval(axial,[eps_ax eps_ax + d_eps]'); % interp1(axial(:,2),axial(:,1),[eps_ax eps_ax + d_eps]'); % Interpolate for force */
  /*  % % EAax = (f(2) - f(1))/d_eps; % Stiffness is derivative of force-stain relationship */
  /*  % % geom(1) = EAax/mat(1); % Vary cross sectional area */
  /*  % % % Axial stiffness */
  /*  % % d_eps = 1e-4; % step size */
  /*  % % eps_ax = D(1)/L0; % Axial strain */
  /*  % % f = interp1(axial(:,2),axial(:,1),[eps_ax eps_ax + d_eps]'); % Interpolate for force % ppval(axial,eps_ax); %  */
  /*  % % EAax = (f(2) - f(1))/d_eps; % interp1(axial_k(:,2),axial_k(:,1),eps_ax); % ppval(axial_k,eps_ax); % Stiffness is derivative of force-stain relationship %  */
  /*  % % geom(1) = EAax/mat(1); % Vary cross sectional area */
  /*  Axial stiffness */
  /*  try */
  /*      eps0 = el_in0.eps0; */
  /*  catch */
  /*      eps0 = 0; */
  /*  end */
  eps_ax = A / B / L0 + el_in0->eps0;

  /*  Axial strain */
  f = ppval_fast(aTLS, el_in0->axial.breaks.data, el_in0->axial.coefs,
                 el_in0->axial.pieces, el_in0->axial.order, eps_ax);

  /*  interp1(axial(:,2),axial(:,1),[eps_ax eps_ax + d_eps]'); % Interpolate for force %  */
  EAax = b_ppval_fast(aTLS, el_in0->axial_k.breaks, el_in0->axial_k.coefs,
                      el_in0->axial_k.pieces, el_in0->axial_k.order, eps_ax);

  /*  Stiffness is derivative of force-stain relationship % (f(2) - f(1))/d_eps; % interp1(axial_k(:,2),axial_k(:,1),eps_ax); %  */
  geom[0] = EAax / el_in0->mat[0];

  /*  Vary cross sectional area */
  /*  if el_in0.el > 12729 */
  /*      geom(1) = 114000/mat(1); */
  /*  end */
  /*  % % % Axial stiffness */
  /*  % % eps_ax = D(1)/L0; % Axial strain */
  /*  % % f = 114000*eps_ax; % interp1(axial(:,2),axial(:,1),[eps_ax eps_ax + d_eps]'); % Interpolate for force */
  /*  % % EAax = 114000; % Stiffness is derivative of force-stain relationship */
  /*  % % geom(1) = EAax/mat(1); % Vary cross sectional area */
  /*  Linear stiffness matrix */
  k1(el_in0->mat, geom, L0, b_k);

  /*  Condense into relevant entries for corotational formulation */
  for (i35 = 0; i35 < 12; i35++) {
    c_k[i35] = b_k[i35];
    c_k[12 + i35] = b_k[60 + i35];
    c_k[24 + i35] = b_k[132 + i35];
    c_k[36 + i35] = b_k[48 + i35];
    c_k[48 + i35] = b_k[120 + i35];
    c_k[60 + i35] = b_k[36 + i35];
  }

  /*  [u1x r1z r2z r1y r2y r1x] */
  for (i35 = 0; i35 < 6; i35++) {
    KL[6 * i35] = c_k[12 * i35];
    KL[1 + 6 * i35] = c_k[5 + 12 * i35];
    KL[2 + 6 * i35] = c_k[11 + 12 * i35];
    KL[3 + 6 * i35] = c_k[4 + 12 * i35];
    KL[4 + 6 * i35] = c_k[10 + 12 * i35];
    KL[5 + 6 * i35] = c_k[3 + 12 * i35];
  }

  for (i35 = 0; i35 < 6; i35++) {
    P[i35] = 0.0;
    for (k = 0; k < 6; k++) {
      P[i35] += KL[i35 + 6 * k] * D[k];
    }
  }

  /*  Interpoate for axial force */
  P[0] = f;

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
  fint_i[0] = -f;
  fint_i[1] = (P[2] + P[1]) / L;
  fint_i[2] = -(P[4] + P[3]) / L;
  fint_i[3] = -P[5];
  fint_i[4] = P[3];
  fint_i[5] = P[1];
  fint_i[6] = f;
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
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      f_A[k + 12 * i35] = b_A[k + 3 * i35];
      f_A[k + 12 * (i35 + 3)] = 0.0;
      f_A[k + 12 * (i35 + 6)] = -b_A[k + 3 * i35];
      f_A[k + 12 * (i35 + 9)] = 0.0;
    }
  }

  for (i35 = 0; i35 < 12; i35++) {
    for (k = 0; k < 3; k++) {
      f_A[(k + 12 * i35) + 3] = 0.0;
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      f_A[(k + 12 * i35) + 6] = -b_A[k + 3 * i35];
      f_A[(k + 12 * (i35 + 3)) + 6] = 0.0;
      f_A[(k + 12 * (i35 + 6)) + 6] = b_A[k + 3 * i35];
      f_A[(k + 12 * (i35 + 9)) + 6] = 0.0;
    }
  }

  for (i35 = 0; i35 < 12; i35++) {
    for (k = 0; k < 3; k++) {
      f_A[(k + 12 * i35) + 9] = 0.0;
    }

    for (k = 0; k < 12; k++) {
      b_k[k + 12 * i35] = f * f_A[k + 12 * i35];
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
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 12; k++) {
      d_L_r2[k + 12 * i35] = -L_r2[k + 12 * i35];
    }

    for (k = 0; k < 3; k++) {
      b_m2[k + 3 * i35] = m2 * E0[k + 3 * i35] + m6I * S_nI3[k + 3 * i35];
      b_m4[k + 3 * i35] = m4 * E0[k + 3 * i35] + m6I * S_nI2[k + 3 * i35];
    }
  }

  for (i35 = 0; i35 < 12; i35++) {
    for (k = 0; k < 3; k++) {
      e_L_r2[i35 + 12 * k] = 0.0;
      b_L_r3[i35 + 12 * k] = 0.0;
      for (i36 = 0; i36 < 3; i36++) {
        e_L_r2[i35 + 12 * k] += d_L_r2[i35 + 12 * i36] * b_m2[i36 + 3 * k];
        b_L_r3[i35 + 12 * k] += L_r3[i35 + 12 * i36] * b_m4[i36 + 3 * k];
      }
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 12; k++) {
      d_L_r2[k + 12 * i35] = -L_r2[k + 12 * i35];
    }

    for (k = 0; k < 3; k++) {
      b_NI[k + 3 * i35] = m3 * S_nJ1[k + 3 * i35] - m6J * S_nJ3[k + 3 * i35];
      b_m5[k + 3 * i35] = m5 * S_nJ1[k + 3 * i35] - m6J * S_nJ2[k + 3 * i35];
    }
  }

  for (i35 = 0; i35 < 12; i35++) {
    for (k = 0; k < 3; k++) {
      L_r2[i35 + 12 * k] = 0.0;
      e_L_r3[i35 + 12 * k] = 0.0;
      for (i36 = 0; i36 < 3; i36++) {
        L_r2[i35 + 12 * k] += d_L_r2[i35 + 12 * i36] * b_NI[i36 + 3 * k];
        e_L_r3[i35 + 12 * k] += L_r3[i35 + 12 * i36] * b_m5[i36 + 3 * k];
      }
    }
  }

  /*  KE */
  /*  KF */
  /*  M_nI2 = get_M(NI(:,2),e1,L); */
  /*  M_nJ2 = get_M(NJ(:,2),e1,L); */
  /*  M_nI3 = get_M(NI(:,3),e1,L); */
  /*  M_nJ3 = get_M(NJ(:,3),e1,L); */
  y = 1.0 / L;
  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 12; k++) {
      KD[k + 12 * i35] = 0.0;
      KD[k + 12 * (i35 + 3)] = e_L_r2[k + 12 * i35] + b_L_r3[k + 12 * i35];
      KD[k + 12 * (i35 + 6)] = 0.0;
      KD[k + 12 * (i35 + 9)] = L_r2[k + 12 * i35] + e_L_r3[k + 12 * i35];
    }

    for (k = 0; k < 3; k++) {
      b_NI[i35 + 3 * k] = (real_T)iv47[i35 + 3 * k] - e10[i35] * e10[k];
    }
  }

  b_y = -1.0 / L;
  A = 0.0;
  B = -1.0 / L;
  c_y = 0.0;
  d_y = -1.0 / L;
  e_y = 0.0;
  f_y = -1.0 / L;
  g_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i35 = 0; i35 < 3; i35++) {
      b_A[i35 + 3 * k] = y * b_NI[i35 + 3 * k];
    }

    A += e10[k] * NI[3 + k];
    c_y += e10[k] * NJ[3 + k];
    e_y += e10[k] * NI[6 + k];
    g_y += e10[k] * NJ[6 + k];
  }

  get_S(e30, S_e2);
  get_S(e10, S_e1);
  get_S(e20, S_e3);
  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    d_A[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      c_A[i35] += b_A[i35 + 3 * k] * NI[3 + k];
      d_A[i35] += b_A[i35 + 3 * k] * NI[3 + k];
    }

    for (k = 0; k < 3; k++) {
      b_NI[i35 + 3 * k] = c_A[i35] * e10[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    b_el_in_orient_ij[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      g_A[i35 + 3 * k] = d_A[k] * e10[i35];
      c_A[i35] += b_A[i35 + 3 * k] * NJ[3 + k];
      b_el_in_orient_ij[i35] += b_A[i35 + 3 * k] * NJ[3 + k];
    }

    for (k = 0; k < 3; k++) {
      b_m5[i35 + 3 * k] = c_A[i35] * e10[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    d_A[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      i_A[i35 + 3 * k] = b_el_in_orient_ij[k] * e10[i35];
      c_A[i35] += b_A[i35 + 3 * k] * NI[6 + k];
      d_A[i35] += b_A[i35 + 3 * k] * NI[6 + k];
    }

    for (k = 0; k < 3; k++) {
      h_A[i35 + 3 * k] = c_A[i35] * e10[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    c_A[i35] = 0.0;
    b_el_in_orient_ij[i35] = 0.0;
    for (k = 0; k < 3; k++) {
      k_A[i35 + 3 * k] = d_A[k] * e10[i35];
      c_A[i35] += b_A[i35 + 3 * k] * NJ[6 + k];
      b_el_in_orient_ij[i35] += b_A[i35 + 3 * k] * NJ[6 + k];
    }

    for (k = 0; k < 3; k++) {
      j_A[i35 + 3 * k] = c_A[i35] * e10[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      l_A[i35 + 3 * k] = b_el_in_orient_ij[k] * e10[i35];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      KF11[k + 3 * i35] = ((-m2 * (b_y * ((b_NI[k + 3 * i35] + g_A[k + 3 * i35])
        + b_A[k + 3 * i35] * A)) - m3 * (B * ((b_m5[k + 3 * i35] + i_A[k + 3 *
        i35]) + b_A[k + 3 * i35] * c_y))) + m4 * (d_y * ((h_A[k + 3 * i35] +
        k_A[k + 3 * i35]) + b_A[k + 3 * i35] * e_y))) + m5 * (f_y * ((j_A[k + 3 *
        i35] + l_A[k + 3 * i35]) + b_A[k + 3 * i35] * g_y));
      b_m2[i35 + 3 * k] = 0.0;
      b_m4[i35 + 3 * k] = 0.0;
      for (i36 = 0; i36 < 3; i36++) {
        b_m2[i35 + 3 * k] += -m2 * b_A[i35 + 3 * i36] * S_nI2[i36 + 3 * k];
        b_m4[i35 + 3 * k] += m4 * b_A[i35 + 3 * i36] * S_nI3[i36 + 3 * k];
      }
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      KF12[k + 3 * i35] = b_m2[k + 3 * i35] + b_m4[k + 3 * i35];
      b_NI[i35 + 3 * k] = 0.0;
      b_m5[i35 + 3 * k] = 0.0;
      for (i36 = 0; i36 < 3; i36++) {
        b_NI[i35 + 3 * k] += -m3 * b_A[i35 + 3 * i36] * S_nJ2[i36 + 3 * k];
        b_m5[i35 + 3 * k] += m5 * b_A[i35 + 3 * i36] * S_nJ3[i36 + 3 * k];
      }
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      KF14[k + 3 * i35] = b_NI[k + 3 * i35] + b_m5[k + 3 * i35];
    }
  }

  /*  KG - geometric stiffness matrix */
  /*  Element global tangent stiffness matrix */
  for (i35 = 0; i35 < 12; i35++) {
    for (k = 0; k < 6; k++) {
      c_k[i35 + 12 * k] = 0.0;
      for (i36 = 0; i36 < 6; i36++) {
        c_k[i35 + 12 * k] += T[i36 + 6 * i35] * KL[i36 + 6 * k];
      }
    }
  }

  A = 1.0;
  B = 0.0;
  TRANSB = 'N';
  TRANSA = 'N';
  memset(&h_y[0], 0, 144U * sizeof(real_T));
  m_t = (ptrdiff_t)12;
  n_t = (ptrdiff_t)12;
  k_t = (ptrdiff_t)6;
  lda_t = (ptrdiff_t)12;
  ldb_t = (ptrdiff_t)6;
  ldc_t = (ptrdiff_t)12;
  dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &A, &c_k[0], &lda_t, &T[0], &ldb_t,
        &B, &h_y[0], &ldc_t);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NI[0], e10, L, *(real_T (*)
         [3])&R_bar[0], f_A);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NJ[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv68);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NI[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv69);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NJ[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv70);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NJ[3], e10, L, *(real_T (*)
         [3])&R_bar[0], dv71);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NJ[6], e10, L, *(real_T (*)
         [3])&R_bar[0], dv72);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NI[3], e10, L, *(real_T (*)
         [3])&R_bar[0], dv73);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NI[6], e10, L, *(real_T (*)
         [3])&R_bar[0], dv74);
  for (i35 = 0; i35 < 12; i35++) {
    e_A[i35] = -t6I[i35];
    for (k = 0; k < 12; k++) {
      b_t2[i35 + 12 * k] = t2[i35] * t2[k];
      b_t3[i35 + 12 * k] = t3[i35] * t3[k];
      b_t4[i35 + 12 * k] = t4[i35] * t4[k];
      b_t5[i35 + 12 * k] = t5[i35] * t5[k];
      b_t6I[i35 + 12 * k] = e_A[i35] * t6I[k];
      b_t6J[i35 + 12 * k] = t6J[i35] * t6J[k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      b_NI[i35 + 3 * k] = 0.0;
      b_m5[i35 + 3 * k] = 0.0;
      g_A[i35 + 3 * k] = 0.0;
      h_A[i35 + 3 * k] = 0.0;
      i_A[i35 + 3 * k] = 0.0;
      j_A[i35 + 3 * k] = 0.0;
      k_A[i35 + 3 * k] = 0.0;
      l_A[i35 + 3 * k] = 0.0;
      b_m2[i35 + 3 * k] = 0.0;
      b_m4[i35 + 3 * k] = 0.0;
      b_S_e3[i35 + 3 * k] = 0.0;
      b_S_e2[i35 + 3 * k] = 0.0;
      for (i36 = 0; i36 < 3; i36++) {
        b_NI[i35 + 3 * k] += S_e2[i35 + 3 * i36] * E0[i36 + 3 * k];
        b_m5[i35 + 3 * k] += S_e1[i35 + 3 * i36] * S_nI2[i36 + 3 * k];
        g_A[i35 + 3 * k] += S_e3[i35 + 3 * i36] * E0[i36 + 3 * k];
        h_A[i35 + 3 * k] += S_e1[i35 + 3 * i36] * S_nI3[i36 + 3 * k];
        i_A[i35 + 3 * k] += S_e3[i35 + 3 * i36] * S_nI2[i36 + 3 * k];
        j_A[i35 + 3 * k] += S_e2[i35 + 3 * i36] * S_nI3[i36 + 3 * k];
        k_A[i35 + 3 * k] += S_e2[i35 + 3 * i36] * S_nJ1[i36 + 3 * k];
        l_A[i35 + 3 * k] += S_e1[i35 + 3 * i36] * S_nJ2[i36 + 3 * k];
        b_m2[i35 + 3 * k] += S_e3[i35 + 3 * i36] * S_nJ1[i36 + 3 * k];
        b_m4[i35 + 3 * k] += S_e1[i35 + 3 * i36] * S_nJ3[i36 + 3 * k];
        b_S_e3[i35 + 3 * k] += S_e3[i35 + 3 * i36] * S_nJ2[i36 + 3 * k];
        b_S_e2[i35 + 3 * k] += S_e2[i35 + 3 * i36] * S_nJ3[i36 + 3 * k];
      }

      b_KF11[k + 12 * i35] = KF11[k + 3 * i35];
      b_KF11[k + 12 * (i35 + 3)] = KF12[k + 3 * i35];
      b_KF11[k + 12 * (i35 + 6)] = -KF11[k + 3 * i35];
      b_KF11[k + 12 * (i35 + 9)] = KF14[k + 3 * i35];
      b_KF11[(k + 12 * i35) + 3] = KF12[i35 + 3 * k];
    }
  }

  for (i35 = 0; i35 < 3; i35++) {
    for (k = 0; k < 3; k++) {
      b_KF11[(k + 12 * (i35 + 3)) + 3] = (m2 * (b_NI[k + 3 * i35] - b_m5[k + 3 *
        i35]) - m4 * (g_A[k + 3 * i35] - h_A[k + 3 * i35])) - m6I * (i_A[k + 3 *
        i35] - j_A[k + 3 * i35]);
      b_KF11[(k + 12 * (i35 + 6)) + 3] = -KF12[i35 + 3 * k];
      b_KF11[(k + 12 * (i35 + 9)) + 3] = 0.0;
      b_KF11[(k + 12 * i35) + 6] = -KF11[k + 3 * i35];
      b_KF11[(k + 12 * (i35 + 3)) + 6] = -KF12[k + 3 * i35];
      b_KF11[(k + 12 * (i35 + 6)) + 6] = KF11[k + 3 * i35];
      b_KF11[(k + 12 * (i35 + 9)) + 6] = -KF14[k + 3 * i35];
      b_KF11[(k + 12 * i35) + 9] = KF14[i35 + 3 * k];
      b_KF11[(k + 12 * (i35 + 3)) + 9] = 0.0;
      b_KF11[(k + 12 * (i35 + 6)) + 9] = -KF14[i35 + 3 * k];
      b_KF11[(k + 12 * (i35 + 9)) + 9] = (m3 * (k_A[k + 3 * i35] - l_A[k + 3 *
        i35]) - m5 * (b_m2[k + 3 * i35] - b_m4[k + 3 * i35])) + m6J * (b_S_e3[k
        + 3 * i35] - b_S_e2[k + 3 * i35]);
    }
  }

  /*  Element global internal force vector */
  for (i35 = 0; i35 < 12; i35++) {
    for (k = 0; k < 12; k++) {
      Kel[k + 12 * i35] = h_y[k + 12 * i35] + (((((b_k[k + 12 * i35] + ((((P[1] *
        b_t2[k + 12 * i35] * x + P[2] * b_t3[k + 12 * i35] * b_x) + P[3] *
        b_t4[k + 12 * i35] * c_x) + P[4] * b_t5[k + 12 * i35] * d_x) + P[5] *
        (b_t6I[k + 12 * i35] * e_x + b_t6J[k + 12 * i35] * f_x))) + (((((m2 *
        f_A[k + 12 * i35] + m3 * dv68[k + 12 * i35]) - m4 * dv69[k + 12 * i35])
        - m5 * dv70[k + 12 * i35]) + m6I * (dv71[k + 12 * i35] - dv72[k + 12 *
        i35])) - m6J * (dv73[k + 12 * i35] - dv74[k + 12 * i35]))) + KD[k + 12 *
        i35]) + KD[i35 + 12 * k]) + b_KF11[k + 12 * i35]);
    }

    Fint_i[i35] = 0.0;
    for (k = 0; k < 6; k++) {
      Fint_i[i35] += T[k + 6 * i35] * P[k];
    }
  }

  /*  Do not need to save any variables for future iterations */
  /*  el_out.D = D; */
  /*  el_out.P = P; */
  /*  el_out.eps_ax = eps_ax; */
  el_in0->b_break = 0.0;

  /*  figure(11) */
  /*  plot(D(1)/L,P(1),'ro') */
  /*  drawnow */
  /*  % % figure(100) */
  /*  % % % clf */
  /*  % % box on */
  /*  % % hold on */
  /*  % % % plot(EL(4129).el_in0.axial(:,2),EL(4129).el_in0.axial(:,1),'b-') */
  /*  % %  */
  /*  % % plot(eps_ax,P(1),'cx') */
  /*  % % % xlim([-.01 .03]) */
  /*  % % drawnow */
  /*  % % if el_in0.el == 12839 */
  /*  % %     disp([eps_ax P(1)]) */
  /*  % % end */
  /*  % % if el_in0.el == 4129 */
  /*  % %     figure(100) */
  /*  % %     hold on */
  /*  % % %     plot(eps_ax,P(1),'rs') */
  /*  % %     plot(0,0,'rs') */
  /*  % %     drawnow */
  /*  % %     disp([D P]) */
  /*  % % end */
}

/* End of code generation (el4.c) */
