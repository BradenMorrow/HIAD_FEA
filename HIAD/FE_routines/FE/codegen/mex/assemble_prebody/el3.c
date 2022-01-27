/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * el3.c
 *
 * Code generation for function 'el3'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "el3.h"
#include "get_KL_P_flex_shear_iter.h"
#include "get_KL_P_flex_shear_noniter.h"
#include "assemble_prebody_emxutil.h"
#include "get_G.h"
#include "get_S.h"
#include "get_L.h"
#include "eye.h"
#include "mpower.h"
#include "asin.h"
#include "norm.h"
#include "get_PHI_quat.h"
#include "quat_prod.h"
#include "get_quat_PHI.h"
#include "get_R_PHI.h"
#include "get_quat_R.h"
#include "cross.h"
#include "sqrt.h"

/* Function Definitions */
void el3(emlrtCTX aTLS, const real_T U_in_U[12], const real_T U_in_delta_U[12],
         const real_T U_in_DELTA_U[12], const real_T el_in_nodes_ij[6], const
         real_T el_in_orient_ij[3], b_struct_T *el_in0, real_T Kel[144], real_T
         fint_i[12], real_T Fint_i[12], real_T ROT_rot[6], real_T ROT_DELTA_rot
         [6])
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
  int32_T i29;
  real_T e30[3];
  real_T e20[3];
  real_T E0[9];
  real_T e0[4];
  real_T delta_qi[4];
  real_T delta_qj[4];
  real_T dv32[4];
  real_T qI[4];
  real_T dv33[4];
  real_T qJ[4];
  real_T b_qI[4];
  int32_T k;
  real_T rot[6];
  real_T Srk[9];
  int32_T i30;
  real_T NI[9];
  real_T dv34[4];
  real_T dv35[4];
  real_T NJ[9];
  real_T R_bar[9];
  real_T dv36[4];
  real_T dv37[4];
  real_T dv38[4];
  real_T dv39[4];
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
  real_T el_in1_p;
  real_T el_in1_r;
  int32_T el_in1_alpha_size[2];
  real_T el_in1_alpha_data[100];
  emxArray_struct5_T *el_in1_nodes;
  real_T el_in1_beta;
  real_T el_in1_propsLH[5];
  real_T el_in1_n;
  real_T el_in1_flex_K[25];
  emxArray_real_T *el_in1_flex_D;
  emxArray_real_T *el_in1_flex_Du;
  real_T el_in1_flex_Q[5];
  int32_T el_in1_flex_f_size[3];
  real_T el_in1_flex_f_data[500];
  int32_T el_in1_flex_d_size[2];
  real_T el_in1_flex_d_data[100];
  int32_T el_in1_flex_e_size[2];
  real_T el_in1_flex_e_data[400];
  real_T el_in1_D[6];
  real_T el_in1_dD[6];
  struct_T el_out0;
  real_T P[6];
  real_T KL[36];
  real_T b_E0[9];
  real_T A[9];
  real_T L_r2[36];
  real_T L_r3[36];
  real_T S_nI1[9];
  real_T S_nI2[9];
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
  real_T m2;
  real_T m3;
  real_T m4;
  real_T m5;
  real_T m6I;
  real_T m6J;
  real_T e_A[144];
  real_T KA[144];
  real_T x;
  real_T b_x;
  real_T c_x;
  real_T d_x;
  real_T e_x;
  real_T f_x;
  real_T f_A[9];
  static const int8_T iv42[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  real_T c_y;
  real_T d_y;
  real_T Sr1[9];
  real_T Sz[9];
  real_T Se1[9];
  real_T e_y;
  real_T g_A[9];
  real_T h_A[9];
  real_T i_A[9];
  real_T j_A[9];
  real_T f_y;
  real_T k_A[9];
  real_T l_A[9];
  real_T g11[9];
  real_T g12[9];
  real_T b_Srk[9];
  real_T c_Srk[9];
  real_T b_Sr1[9];
  real_T c_Sr1[9];
  real_T G7[144];
  real_T G8[144];
  real_T d_L_r2[36];
  real_T e_L_r2[36];
  real_T e_L_r3[36];
  real_T KD[144];
  real_T g_y;
  real_T h_y;
  real_T i_y[72];
  char_T TRANSB;
  char_T TRANSA;
  real_T j_y[144];
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  real_T dv40[144];
  real_T dv41[144];
  real_T dv42[144];
  real_T dv43[144];
  real_T dv44[144];
  real_T b_t6I[144];
  real_T b_t6J[144];
  real_T b_t2[144];
  real_T b_t3[144];
  real_T b_t4[144];
  real_T b_t5[144];
  real_T b_Sz[144];
  emlrtHeapReferenceStackEnterFcnR2012b(aTLS);

  /* ELEMENT_5 */
  /*    3D corotational beam formulation, see Crisfield (1990), A consistent */
  /*    co-rotational formulation for non-linear, three dimensional, */
  /*    beam-elements */
  /*     */
  /*    With material nonlinearity */
  /*     */
  /*    See also de Souza dissertation (2000), Force-based finite element for */
  /*    large displacement inelastic analysis of frames */
  /*    Generally follows de Souza */
  /*  Extract variables */
  /*  Geometry */
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

  /*  Along element (x) */
  B = norm(e10);
  b_el_in_orient_ij[0] = el_in_orient_ij[0] - el_in_nodes_ij[0];
  b_el_in_orient_ij[1] = el_in_orient_ij[1] - el_in_nodes_ij[2];
  b_el_in_orient_ij[2] = el_in_orient_ij[2] - el_in_nodes_ij[4];
  for (i29 = 0; i29 < 3; i29++) {
    c_el_in_orient_ij[i29] = b_el_in_orient_ij[i29];
    e10[i29] /= B;
  }

  cross(e10, c_el_in_orient_ij, e30);

  /*  Cross with i orientation (z) */
  B = norm(e30);
  for (i29 = 0; i29 < 3; i29++) {
    e30[i29] /= B;
  }

  cross(e30, e10, e20);

  /*  Cross with x (y) */
  B = norm(e20);
  for (i29 = 0; i29 < 3; i29++) {
    E0[i29] = e10[i29];
    E0[3 + i29] = e20[i29] / B;
    E0[6 + i29] = e30[i29];
  }

  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  /*  Compute nodal triads and average rotation */
  /*  Section 5.3.2a - de Souza */
  get_quat_R(E0, e0);
  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = U_in_delta_U[(3 + i29) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, delta_qi);
  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = U_in_delta_U[1 + ((3 + i29) << 1)];
  }

  get_quat_PHI(b_el_in_orient_ij, delta_qj);

  /*  STEP 2 */
  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = U_in_U[(3 + i29) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, dv32);
  quat_prod(delta_qi, dv32, qI);

  /*  Equation 5.46 */
  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = U_in_U[1 + ((3 + i29) << 1)];
  }

  get_quat_PHI(b_el_in_orient_ij, dv33);
  quat_prod(delta_qj, dv33, qJ);

  /*  Calculate nodal rotation for incorporation into displacement vector */
  for (k = 0; k < 4; k++) {
    b_qI[k] = qI[k];
  }

  get_PHI_quat(b_qI, e10);
  for (k = 0; k < 4; k++) {
    b_qI[k] = qJ[k];
  }

  get_PHI_quat(b_qI, e30);
  for (i29 = 0; i29 < 3; i29++) {
    rot[i29 << 1] = e10[i29];
    rot[1 + (i29 << 1)] = e30[i29];
  }

  for (i29 = 0; i29 < 6; i29++) {
    ROT_rot[i29] = rot[i29];
  }

  /*  Equation 5.48 */
  /* %%%%%%%%%%%%%% */
  /*  If U = zeros, rotI and rotJ = zeros, nI and nJ = e0 ==> OK */
  /*  However, NI and NJ should equal E0, not the case. (fixed now) */
  /*  % % NI = get_R_quat(nI); */
  /*  % % NJ = get_R_quat(nJ); */
  /*  June 25, 2015 */
  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = rot[i29 << 1];
  }

  get_R_PHI(b_el_in_orient_ij, Srk);
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      NI[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        NI[i29 + 3 * i30] += Srk[i29 + 3 * k] * E0[k + 3 * i30];
      }
    }

    b_el_in_orient_ij[i29] = rot[1 + (i29 << 1)];
  }

  get_R_PHI(b_el_in_orient_ij, Srk);

  /*  STEP 3 */
  quat_prod(qI, e0, dv34);
  get_PHI_quat(dv34, e10);
  quat_prod(qJ, e0, dv35);
  get_PHI_quat(dv35, e30);

  /*  STEP 4 */
  for (k = 0; k < 3; k++) {
    for (i29 = 0; i29 < 3; i29++) {
      NJ[k + 3 * i29] = 0.0;
      for (i30 = 0; i30 < 3; i30++) {
        NJ[k + 3 * i29] += Srk[k + 3 * i30] * E0[i30 + 3 * i29];
      }
    }

    b_el_in_orient_ij[k] = (e10[k] + e30[k]) / 2.0;
  }

  get_R_PHI(b_el_in_orient_ij, R_bar);

  /*  Also need step change in rotations for arc-length solver (DELTA_U) */
  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = U_in_DELTA_U[(3 + i29) << 1];
  }

  get_quat_PHI(b_el_in_orient_ij, dv36);
  quat_prod(delta_qi, dv36, dv37);
  get_PHI_quat(dv37, e10);
  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = U_in_DELTA_U[1 + ((3 + i29) << 1)];
    ROT_DELTA_rot[i29 << 1] = e10[i29];
  }

  get_quat_PHI(b_el_in_orient_ij, dv38);
  quat_prod(delta_qj, dv38, dv39);
  get_PHI_quat(dv39, e30);

  /*  STEP 5 */
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
  for (i29 = 0; i29 < 3; i29++) {
    e30[i29] = R_bar[3 + i29] - y * (R_bar[i29] + e10[i29]);
  }

  /*  e2 = R_bar(:,2) - R_bar(:,2)'*e1/(1 + R_bar(:,1)'*e1)*(R_bar(:,1) + e1); */
  B = norm(e30);
  y = 0.0;
  for (k = 0; k < 3; k++) {
    y += R_bar[6 + k] * e10[k];
    e30[k] /= B;
  }

  y /= 2.0;
  for (i29 = 0; i29 < 3; i29++) {
    e20[i29] = R_bar[6 + i29] - y * (R_bar[i29] + e10[i29]);
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

  /*  Get the linearized stiffness matrix and internal force vector */
  el_in1_p = el_in0->p;
  el_in1_r = el_in0->r;
  el_in1_alpha_size[0] = el_in0->alpha.size[0];
  el_in1_alpha_size[1] = el_in0->alpha.size[1];
  k = el_in0->alpha.size[0] * el_in0->alpha.size[1];
  for (i29 = 0; i29 < k; i29++) {
    el_in1_alpha_data[i29] = el_in0->alpha.data[i29];
  }

  emxInit_struct5_T(aTLS, &el_in1_nodes, 2, true);
  el_in1_beta = el_in0->beta;
  i29 = el_in1_nodes->size[0] * el_in1_nodes->size[1];
  el_in1_nodes->size[0] = 1;
  el_in1_nodes->size[1] = el_in0->nodes->size[1];
  emxEnsureCapacity_struct5_T(el_in1_nodes, i29);
  k = el_in0->nodes->size[0] * el_in0->nodes->size[1];
  for (i29 = 0; i29 < k; i29++) {
    el_in1_nodes->data[i29] = el_in0->nodes->data[i29];
  }

  for (k = 0; k < 5; k++) {
    el_in1_propsLH[k] = el_in0->propsLH[k];
  }

  el_in1_n = el_in0->n;
  for (i29 = 0; i29 < 25; i29++) {
    el_in1_flex_K[i29] = el_in0->flex.K[i29];
  }

  emxInit_real_T(aTLS, &el_in1_flex_D, 2, true);
  i29 = el_in1_flex_D->size[0] * el_in1_flex_D->size[1];
  el_in1_flex_D->size[0] = 5;
  el_in1_flex_D->size[1] = el_in0->flex.D->size[1];
  emxEnsureCapacity((emxArray__common *)el_in1_flex_D, i29, (int32_T)sizeof
                    (real_T));
  k = el_in0->flex.D->size[0] * el_in0->flex.D->size[1];
  for (i29 = 0; i29 < k; i29++) {
    el_in1_flex_D->data[i29] = el_in0->flex.D->data[i29];
  }

  emxInit_real_T(aTLS, &el_in1_flex_Du, 2, true);
  i29 = el_in1_flex_Du->size[0] * el_in1_flex_Du->size[1];
  el_in1_flex_Du->size[0] = 5;
  el_in1_flex_Du->size[1] = el_in0->flex.Du->size[1];
  emxEnsureCapacity((emxArray__common *)el_in1_flex_Du, i29, (int32_T)sizeof
                    (real_T));
  k = el_in0->flex.Du->size[0] * el_in0->flex.Du->size[1];
  for (i29 = 0; i29 < k; i29++) {
    el_in1_flex_Du->data[i29] = el_in0->flex.Du->data[i29];
  }

  for (k = 0; k < 5; k++) {
    el_in1_flex_Q[k] = el_in0->flex.Q[k];
  }

  el_in1_flex_f_size[0] = 5;
  el_in1_flex_f_size[1] = 5;
  el_in1_flex_f_size[2] = el_in0->flex.f.size[2];
  k = el_in0->flex.f.size[0] * el_in0->flex.f.size[1] * el_in0->flex.f.size[2];
  for (i29 = 0; i29 < k; i29++) {
    el_in1_flex_f_data[i29] = el_in0->flex.f.data[i29];
  }

  el_in1_flex_d_size[0] = 5;
  el_in1_flex_d_size[1] = el_in0->flex.d.size[1];
  k = el_in0->flex.d.size[0] * el_in0->flex.d.size[1];
  for (i29 = 0; i29 < k; i29++) {
    el_in1_flex_d_data[i29] = el_in0->flex.d.data[i29];
  }

  el_in1_flex_e_size[0] = el_in0->flex.e.size[0];
  el_in1_flex_e_size[1] = el_in0->flex.e.size[1];
  k = el_in0->flex.e.size[0] * el_in0->flex.e.size[1];
  for (i29 = 0; i29 < k; i29++) {
    el_in1_flex_e_data[i29] = el_in0->flex.e.data[i29];
  }

  for (k = 0; k < 6; k++) {
    el_in1_D[k] = D[k];
    el_in1_dD[k] = D[k] - el_in0->D0[k];
  }

  /*  Obtain element stiffness matrix and element forces */
  emxInitStruct_struct_T1(aTLS, &el_out0, true);
  if (el_in0->state_it) {
    /*  Iterative form of the state determination process */
    get_KL_P_flex_shear_iter(aTLS, el_in1_p, el_in1_r, el_in1_alpha_data,
      el_in1_alpha_size, el_in1_beta, el_in1_nodes, el_in1_propsLH, el_in1_n,
      el_in1_flex_K, el_in1_flex_D, el_in1_flex_Q, el_in1_flex_f_data,
      el_in1_flex_f_size, el_in1_flex_d_data, el_in1_flex_d_size,
      el_in1_flex_e_data, el_in1_flex_e_size, el_in0->state_it, el_in1_D,
      el_in1_dD, L, KL, P, &el_out0);
  } else {
    /*  Non-iterative form of the state determination process */
    get_KL_P_flex_shear_noniter(aTLS, el_in1_p, el_in1_r, el_in1_alpha_data,
      el_in1_alpha_size, el_in1_beta, el_in1_nodes, el_in1_propsLH, el_in1_n,
      el_in1_flex_K, el_in1_flex_D, el_in1_flex_Du, el_in1_flex_Q,
      el_in1_flex_f_data, el_in1_flex_f_size, el_in1_flex_d_data,
      el_in1_flex_d_size, el_in1_flex_e_data, el_in1_flex_e_size, el_in1_D,
      el_in1_dD, L, KL, P, &el_out0);
  }

  emxFree_real_T(&el_in1_flex_Du);
  emxFree_real_T(&el_in1_flex_D);
  emxFree_struct5_T(&el_in1_nodes);

  /*  Transformation matrix */
  y = 1.0 / L;
  eye(E0);
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      b_E0[i29 + 3 * i30] = E0[i29 + 3 * i30] - e10[i29] * e10[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      A[i30 + 3 * i29] = y * b_E0[i30 + 3 * i29];
    }
  }

  /*  Get L matrices */
  get_L(*(real_T (*)[3])&R_bar[3], e10, L, *(real_T (*)[3])&R_bar[0], L_r2);
  get_L(*(real_T (*)[3])&R_bar[6], e10, L, *(real_T (*)[3])&R_bar[0], L_r3);

  /*  Get h vectors */
  get_S(*(real_T (*)[3])&NI[0], S_nI1);
  get_S(*(real_T (*)[3])&NI[3], S_nI2);
  get_S(*(real_T (*)[3])&NI[6], S_nI3);
  get_S(*(real_T (*)[3])&NJ[0], S_nJ1);
  get_S(*(real_T (*)[3])&NJ[3], S_nJ2);
  get_S(*(real_T (*)[3])&NJ[6], S_nJ3);

  /*  Get t vectors and T matrix */
  y = 1.0 / (2.0 * muDoubleScalarCos(phiI3));
  for (i29 = 0; i29 < 12; i29++) {
    b_L_r2[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_L_r2[i29] += L_r2[i29 + 12 * i30] * NI[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    b_el_in_orient_ij[i29] = 0.0;
    c_el_in_orient_ij[i29] = 0.0;
    c_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_A[i29] += A[i29 + 3 * i30] * NI[3 + i30];
      b_el_in_orient_ij[i29] += S_nI1[i29 + 3 * i30] * e30[i30];
      c_el_in_orient_ij[i29] += S_nI2[i29 + 3 * i30] * e10[i30];
      c_A[i29] += A[i29 + 3 * i30] * NI[3 + i30];
    }

    d_A[i29] = b_A[i29];
    d_A[i29 + 3] = b_el_in_orient_ij[i29] - c_el_in_orient_ij[i29];
    d_A[i29 + 6] = -c_A[i29];
  }

  d_A[9] = 0.0;
  d_A[10] = 0.0;
  d_A[11] = 0.0;
  b_y = 1.0 / (2.0 * muDoubleScalarCos(phiJ3));
  for (i29 = 0; i29 < 12; i29++) {
    t2[i29] = y * (b_L_r2[i29] + d_A[i29]);
    c_L_r2[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_L_r2[i29] += L_r2[i29 + 12 * i30] * NJ[i30];
    }
  }

  d_A[3] = 0.0;
  d_A[4] = 0.0;
  d_A[5] = 0.0;
  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    c_A[i29] = 0.0;
    b_el_in_orient_ij[i29] = 0.0;
    c_el_in_orient_ij[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_A[i29] += A[i29 + 3 * i30] * NJ[3 + i30];
      c_A[i29] += A[i29 + 3 * i30] * NJ[3 + i30];
      b_el_in_orient_ij[i29] += S_nJ1[i29 + 3 * i30] * e30[i30];
      c_el_in_orient_ij[i29] += S_nJ2[i29 + 3 * i30] * e10[i30];
    }

    d_A[i29] = b_A[i29];
    d_A[i29 + 6] = -c_A[i29];
    d_A[i29 + 9] = b_el_in_orient_ij[i29] - c_el_in_orient_ij[i29];
  }

  for (i29 = 0; i29 < 12; i29++) {
    t3[i29] = b_y * (c_L_r2[i29] + d_A[i29]);
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiI2));
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 12; i30++) {
      b_L_r3[i30 + 12 * i29] = -L_r3[i30 + 12 * i29];
    }
  }

  for (i29 = 0; i29 < 12; i29++) {
    c_L_r3[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_L_r3[i29] += b_L_r3[i29 + 12 * i30] * NI[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    b_el_in_orient_ij[i29] = 0.0;
    b_S_nI3[i29] = 0.0;
    c_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_A[i29] += A[i29 + 3 * i30] * NI[6 + i30];
      b_el_in_orient_ij[i29] += S_nI1[i29 + 3 * i30] * e20[i30];
      b_S_nI3[i29] += S_nI3[i29 + 3 * i30] * e10[i30];
      c_A[i29] += A[i29 + 3 * i30] * NI[6 + i30];
    }

    d_A[i29] = b_A[i29];
    d_A[i29 + 3] = b_el_in_orient_ij[i29] - b_S_nI3[i29];
    d_A[i29 + 6] = -c_A[i29];
  }

  d_A[9] = 0.0;
  d_A[10] = 0.0;
  d_A[11] = 0.0;
  for (i29 = 0; i29 < 12; i29++) {
    t4[i29] = y * (c_L_r3[i29] - d_A[i29]);
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiJ2));
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 12; i30++) {
      b_L_r3[i30 + 12 * i29] = -L_r3[i30 + 12 * i29];
    }
  }

  for (i29 = 0; i29 < 12; i29++) {
    c_L_r3[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_L_r3[i29] += b_L_r3[i29 + 12 * i30] * NJ[i30];
    }
  }

  d_A[3] = 0.0;
  d_A[4] = 0.0;
  d_A[5] = 0.0;
  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    c_A[i29] = 0.0;
    b_el_in_orient_ij[i29] = 0.0;
    b_S_nI3[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_A[i29] += A[i29 + 3 * i30] * NJ[6 + i30];
      c_A[i29] += A[i29 + 3 * i30] * NJ[6 + i30];
      b_el_in_orient_ij[i29] += S_nJ1[i29 + 3 * i30] * e20[i30];
      b_S_nI3[i29] += S_nJ3[i29 + 3 * i30] * e10[i30];
    }

    d_A[i29] = b_A[i29];
    d_A[i29 + 6] = -c_A[i29];
    d_A[i29 + 9] = b_el_in_orient_ij[i29] - b_S_nI3[i29];
  }

  b_y = 1.0 / (2.0 * muDoubleScalarCos(phiJ1));
  for (i29 = 0; i29 < 12; i29++) {
    t5[i29] = y * (c_L_r3[i29] - d_A[i29]);
    d_L_r3[i29] = 0.0;
    b_L_r2[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      d_L_r3[i29] += L_r3[i29 + 12 * i30] * NJ[3 + i30];
      b_L_r2[i29] += L_r2[i29 + 12 * i30] * NJ[6 + i30];
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
  for (i29 = 0; i29 < 3; i29++) {
    c_el_in_orient_ij[i29] = 0.0;
    b_S_nI3[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_el_in_orient_ij[i29] += S_nJ2[i29 + 3 * i30] * e20[i30];
      b_S_nI3[i29] += S_nJ3[i29 + 3 * i30] * e30[i30];
    }

    d_A[i29 + 9] = c_el_in_orient_ij[i29] - b_S_nI3[i29];
  }

  y = 1.0 / (2.0 * muDoubleScalarCos(phiI1));
  for (i29 = 0; i29 < 12; i29++) {
    t6J[i29] = b_y * ((d_L_r3[i29] - b_L_r2[i29]) + d_A[i29]);
    c_L_r3[i29] = 0.0;
    c_L_r2[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_L_r3[i29] += L_r3[i29 + 12 * i30] * NI[3 + i30];
      c_L_r2[i29] += L_r2[i29 + 12 * i30] * NI[6 + i30];
    }
  }

  d_A[0] = 0.0;
  d_A[1] = 0.0;
  d_A[2] = 0.0;
  for (i29 = 0; i29 < 3; i29++) {
    c_el_in_orient_ij[i29] = 0.0;
    b_S_nI3[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_el_in_orient_ij[i29] += S_nI2[i29 + 3 * i30] * e20[i30];
      b_S_nI3[i29] += S_nI3[i29 + 3 * i30] * e30[i30];
    }

    d_A[i29 + 3] = c_el_in_orient_ij[i29] - b_S_nI3[i29];
  }

  d_A[6] = 0.0;
  d_A[7] = 0.0;
  d_A[8] = 0.0;
  d_A[9] = 0.0;
  d_A[10] = 0.0;
  d_A[11] = 0.0;
  for (i29 = 0; i29 < 12; i29++) {
    t6I[i29] = y * ((c_L_r3[i29] - c_L_r2[i29]) + d_A[i29]);
  }

  T[18] = 0.0;
  T[24] = 0.0;
  T[30] = 0.0;
  for (i29 = 0; i29 < 3; i29++) {
    T[6 * i29] = -e10[i29];
    T[6 * (i29 + 6)] = e10[i29];
  }

  T[54] = 0.0;
  T[60] = 0.0;
  T[66] = 0.0;
  for (i29 = 0; i29 < 12; i29++) {
    T[1 + 6 * i29] = t2[i29];
    T[2 + 6 * i29] = t3[i29];
    T[3 + 6 * i29] = t4[i29];
    T[4 + 6 * i29] = t5[i29];
    T[5 + 6 * i29] = t6J[i29] - t6I[i29];
  }

  /*  Scaled internal forces */
  m2 = P[1] / (2.0 * muDoubleScalarCos(phiI3));
  m3 = P[2] / (2.0 * muDoubleScalarCos(phiJ3));
  m4 = P[3] / (2.0 * muDoubleScalarCos(phiI2));
  m5 = P[4] / (2.0 * muDoubleScalarCos(phiJ2));
  m6I = P[5] / (2.0 * muDoubleScalarCos(phiI1));
  m6J = P[5] / (2.0 * muDoubleScalarCos(phiJ1));

  /*  Geometric stiffness matrix, KG */
  /*  KA */
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      e_A[i30 + 12 * i29] = A[i30 + 3 * i29];
      e_A[i30 + 12 * (i29 + 3)] = 0.0;
      e_A[i30 + 12 * (i29 + 6)] = -A[i30 + 3 * i29];
      e_A[i30 + 12 * (i29 + 9)] = 0.0;
    }
  }

  for (i29 = 0; i29 < 12; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      e_A[(i30 + 12 * i29) + 3] = 0.0;
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      e_A[(i30 + 12 * i29) + 6] = -A[i30 + 3 * i29];
      e_A[(i30 + 12 * (i29 + 3)) + 6] = 0.0;
      e_A[(i30 + 12 * (i29 + 6)) + 6] = A[i30 + 3 * i29];
      e_A[(i30 + 12 * (i29 + 9)) + 6] = 0.0;
    }
  }

  for (i29 = 0; i29 < 12; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      e_A[(i30 + 12 * i29) + 9] = 0.0;
    }

    for (i30 = 0; i30 < 12; i30++) {
      KA[i30 + 12 * i29] = P[0] * e_A[i30 + 12 * i29];
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
  /* GET_G */
  /*    Get the G matrix */
  /* rk = 3x1 double */
  /* z = 3x1 double */
  /* el = 3x1 double */
  /* L = 1x1 double */
  /* r1 = 3x1 double */
  y = 1.0 / L;
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      f_A[i29 + 3 * i30] = (real_T)iv42[i29 + 3 * i30] - e10[i29] * e10[i30];
    }
  }

  b_y = -1.0 / L;
  B = 0.0;
  c_y = -1.0 / L;
  d_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i29 = 0; i29 < 3; i29++) {
      A[i29 + 3 * k] = y * f_A[i29 + 3 * k];
    }

    B += e10[k] * NI[3 + k];
    d_y += e10[k] * R_bar[6 + k];
  }

  /*  Mz = get_M(z,e1,L); */
  /*  Mrk = get_M(rk,e1,L); */
  /* explicitly do get_S for improved performance */
  /* Srk = get_S(rk); %3x3 double */
  /* Sr1 = get_S(r1); %3x3 double */
  /* Sz = get_S(z); %3x3 double */
  /* Se1 = get_S(e1); %3x3 double */
  for (i29 = 0; i29 < 9; i29++) {
    Srk[i29] = 0.0;
    Sr1[i29] = 0.0;
    Sz[i29] = 0.0;
    Se1[i29] = 0.0;
  }

  Srk[1] = R_bar[8];
  Srk[2] = -R_bar[7];
  Srk[3] = -R_bar[8];
  Srk[5] = R_bar[6];
  Srk[6] = R_bar[7];
  Srk[7] = -R_bar[6];
  Sr1[1] = R_bar[2];
  Sr1[2] = -R_bar[1];
  Sr1[3] = -R_bar[2];
  Sr1[5] = R_bar[0];
  Sr1[6] = R_bar[1];
  Sr1[7] = -R_bar[0];
  Sz[1] = NI[5];
  Sz[2] = -NI[4];
  Sz[3] = -NI[5];
  Sz[5] = NI[3];
  Sz[6] = NI[4];
  Sz[7] = -NI[3];
  Se1[1] = e10[2];
  Se1[2] = -e10[1];
  Se1[3] = -e10[2];
  Se1[5] = e10[0];
  Se1[6] = e10[1];
  Se1[7] = -e10[0];
  y = 0.0;
  e_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += R_bar[6 + k] * e10[k];
    b_S_nI3[k] = e10[k] + R_bar[k];
    e_y += b_S_nI3[k] * NI[3 + k];
    b_A[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      b_A[k] += A[k + 3 * i29] * NI[3 + i29];
    }

    c_A[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      g_A[k + 3 * i29] = b_A[k] * R_bar[6 + i29];
      c_A[k] += A[k + 3 * i29] * R_bar[6 + i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      b_E0[k + 3 * i29] = c_A[k] * NI[3 + i29];
      f_A[k + 3 * i29] = 0.0;
      for (i30 = 0; i30 < 3; i30++) {
        f_A[k + 3 * i29] += g_A[k + 3 * i30] * A[i30 + 3 * i29];
      }
    }

    b_el_in_orient_ij[k] = 0.0;
    c_el_in_orient_ij[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      h_A[k + 3 * i29] = 0.0;
      for (i30 = 0; i30 < 3; i30++) {
        h_A[k + 3 * i29] += b_E0[k + 3 * i30] * A[i30 + 3 * i29];
      }

      b_el_in_orient_ij[k] += A[k + 3 * i29] * NI[3 + i29];
      c_el_in_orient_ij[k] += A[k + 3 * i29] * NI[3 + i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      i_A[k + 3 * i29] = b_el_in_orient_ij[k] * e10[i29];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    c_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_E0[i29 + 3 * i30] = c_el_in_orient_ij[i30] * e10[i29];
      b_A[i29] += A[i29 + 3 * i30] * R_bar[6 + i30];
      c_A[i29] += A[i29 + 3 * i30] * R_bar[6 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      g_A[i29 + 3 * i30] = b_A[i29] * e10[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      j_A[i29 + 3 * i30] = c_A[i30] * e10[i29];
    }
  }

  /* 3x3 */
  f_y = 0.0;
  for (k = 0; k < 3; k++) {
    b_S_nI3[k] = e10[k] + R_bar[k];
    f_y += b_S_nI3[k] * NI[3 + k];
    b_A[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      g11[i29 + 3 * k] = -0.5 * (((f_A[i29 + 3 * k] + h_A[i29 + 3 * k]) + y *
        (b_y * ((i_A[i29 + 3 * k] + b_E0[i29 + 3 * k]) + A[i29 + 3 * k] * B))) +
        e_y * (c_y * ((g_A[i29 + 3 * k] + j_A[i29 + 3 * k]) + A[i29 + 3 * k] *
                      d_y)));
      b_A[k] += A[k + 3 * i29] * NI[3 + i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      k_A[k + 3 * i29] = b_A[k] * e10[i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      l_A[k + 3 * i29] = 0.0;
      for (i30 = 0; i30 < 3; i30++) {
        l_A[k + 3 * i29] += k_A[k + 3 * i30] * Srk[i30 + 3 * i29];
      }
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      i_A[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        i_A[i29 + 3 * i30] += f_y * A[i29 + 3 * k] * Srk[k + 3 * i30];
      }

      b_A[i29] += A[i29 + 3 * i30] * R_bar[6 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      g_A[i29 + 3 * i30] = b_A[i29] * NI[3 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      B = 0.0;
      for (k = 0; k < 3; k++) {
        B += g_A[i29 + 3 * k] * Sr1[k + 3 * i30];
      }

      b_E0[i29 + 3 * i30] = (l_A[i29 + 3 * i30] + i_A[i29 + 3 * i30]) + B;
    }
  }

  /* 3x3 */
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i29 = 0; i29 < 3; i29++) {
      g12[i29 + 3 * k] = -0.25 * b_E0[i29 + 3 * k];
    }

    y += R_bar[6 + k] * e10[k];
    b_S_nI3[k] = e10[k] + R_bar[k];
    b_y += b_S_nI3[k] * NI[3 + k];
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_el_in_orient_ij[i29] += Srk[i29 + 3 * i30] * e10[i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      b_Srk[i29 + 3 * i30] = b_el_in_orient_ij[i29] * NI[3 + i30];
      i_A[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        i_A[i29 + 3 * i30] += -y * Sz[i29 + 3 * k] * Sr1[k + 3 * i30];
      }
    }

    c_el_in_orient_ij[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_Srk[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        c_Srk[i29 + 3 * i30] += b_Srk[i29 + 3 * k] * Sr1[k + 3 * i30];
      }

      c_el_in_orient_ij[i29] += Sr1[i29 + 3 * i30] * NI[3 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      b_Sr1[i29 + 3 * i30] = c_el_in_orient_ij[i29] * e10[i30];
      B = 0.0;
      for (k = 0; k < 3; k++) {
        B += 2.0 * Sz[i29 + 3 * k] * Srk[k + 3 * i30];
      }

      f_A[i29 + 3 * i30] = (i_A[i29 + 3 * i30] + c_Srk[i29 + 3 * i30]) + B;
    }

    for (i30 = 0; i30 < 3; i30++) {
      c_Sr1[i29 + 3 * i30] = 0.0;
      B = 0.0;
      for (k = 0; k < 3; k++) {
        c_Sr1[i29 + 3 * i30] += b_Sr1[i29 + 3 * k] * Srk[k + 3 * i30];
        B += b_y * Se1[i29 + 3 * k] * Srk[k + 3 * i30];
      }

      h_A[i29 + 3 * i30] = (f_A[i29 + 3 * i30] + c_Sr1[i29 + 3 * i30]) - B;
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      E0[i30 + 3 * i29] = 0.125 * h_A[i30 + 3 * i29];
    }
  }

  /* 3x3 */
  memset(&G7[0], 0, 144U * sizeof(real_T));

  /*  zeros(12) explicitly state for improved performance */
  /* set rows 1 to 3 and cols 1 to 3 to g11 */
  /* set rows 4 to 6 and cols 1 to 3 to g12 transposed */
  /* set rows 7 to 9 and cols 1 to 3 to -g11 */
  /* set rows 10 to 12 and cols 1 to 3 to g12 transposed */
  /* set rows 1 to 3 and cols 4 to 6 to g12 */
  /* set rows 4 to 6 and cols 4 to 6 to g22 */
  /* set rows 7 to 9 and cols 4 to 6 to -g12 */
  /* set rows 10 to 12 and cols 4 to 6 to g22 */
  /* set rows 1 to 3 and cols 7 to 9 to -g11 */
  /* set rows 4 to 6 and cols 7 to 9 to -g12 */
  /* set rows 7 to 9 and cols 7 to 9 to g11 */
  /* set rows 10 to 12 and cols 7 to 9 to -g12 */
  /* set rows 1 to 3 and cols 10 to 12 to g12 */
  /* set rows 4 to 6 and cols 10 to 12 to g22 */
  /* set rows 7 to 9 and cols 10 to 12 to -g12 */
  /* set rows 10 to 12 and cols 10 to 12 to g22 */
  /*  G = [g11 g12 -g11 g12 */
  /*      g12' g22 -g12' g22 */
  /*      -g11 -g12 g11 -g12 */
  /*      g12' g22 -g12' g22]; */
  /* GET_G */
  /*    Get the G matrix */
  /* rk = 3x1 double */
  /* z = 3x1 double */
  /* el = 3x1 double */
  /* L = 1x1 double */
  /* r1 = 3x1 double */
  y = 1.0 / L;
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      G7[i30 + 12 * i29] = g11[i30 + 3 * i29];
      G7[(i30 + 12 * i29) + 3] = g12[i29 + 3 * i30];
      G7[(i30 + 12 * i29) + 6] = -g11[i30 + 3 * i29];
      G7[(i30 + 12 * i29) + 9] = g12[i29 + 3 * i30];
      G7[i30 + 12 * (3 + i29)] = g12[i30 + 3 * i29];
      G7[(i30 + 12 * (3 + i29)) + 3] = E0[i30 + 3 * i29];
      G7[(i30 + 12 * (3 + i29)) + 6] = -g12[i30 + 3 * i29];
      G7[(i30 + 12 * (3 + i29)) + 9] = E0[i30 + 3 * i29];
      G7[i30 + 12 * (6 + i29)] = -g11[i30 + 3 * i29];
      G7[(i30 + 12 * (6 + i29)) + 3] = -g12[i29 + 3 * i30];
      G7[(i30 + 12 * (6 + i29)) + 6] = g11[i30 + 3 * i29];
      G7[(i30 + 12 * (6 + i29)) + 9] = -g12[i29 + 3 * i30];
      G7[i30 + 12 * (9 + i29)] = g12[i30 + 3 * i29];
      G7[(i30 + 12 * (9 + i29)) + 3] = E0[i30 + 3 * i29];
      G7[(i30 + 12 * (9 + i29)) + 6] = -g12[i30 + 3 * i29];
      G7[(i30 + 12 * (9 + i29)) + 9] = E0[i30 + 3 * i29];
      f_A[i29 + 3 * i30] = (real_T)iv42[i29 + 3 * i30] - e10[i29] * e10[i30];
    }
  }

  b_y = -1.0 / L;
  B = 0.0;
  c_y = -1.0 / L;
  d_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i29 = 0; i29 < 3; i29++) {
      A[i29 + 3 * k] = y * f_A[i29 + 3 * k];
    }

    B += e10[k] * NI[6 + k];
    d_y += e10[k] * R_bar[3 + k];
  }

  /*  Mz = get_M(z,e1,L); */
  /*  Mrk = get_M(rk,e1,L); */
  /* explicitly do get_S for improved performance */
  /* Srk = get_S(rk); %3x3 double */
  /* Sr1 = get_S(r1); %3x3 double */
  /* Sz = get_S(z); %3x3 double */
  /* Se1 = get_S(e1); %3x3 double */
  for (i29 = 0; i29 < 9; i29++) {
    Srk[i29] = 0.0;
    Sr1[i29] = 0.0;
    Sz[i29] = 0.0;
    Se1[i29] = 0.0;
  }

  Srk[1] = R_bar[5];
  Srk[2] = -R_bar[4];
  Srk[3] = -R_bar[5];
  Srk[5] = R_bar[3];
  Srk[6] = R_bar[4];
  Srk[7] = -R_bar[3];
  Sr1[1] = R_bar[2];
  Sr1[2] = -R_bar[1];
  Sr1[3] = -R_bar[2];
  Sr1[5] = R_bar[0];
  Sr1[6] = R_bar[1];
  Sr1[7] = -R_bar[0];
  Sz[1] = NI[8];
  Sz[2] = -NI[7];
  Sz[3] = -NI[8];
  Sz[5] = NI[6];
  Sz[6] = NI[7];
  Sz[7] = -NI[6];
  Se1[1] = e10[2];
  Se1[2] = -e10[1];
  Se1[3] = -e10[2];
  Se1[5] = e10[0];
  Se1[6] = e10[1];
  Se1[7] = -e10[0];
  y = 0.0;
  e_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += R_bar[3 + k] * e10[k];
    b_S_nI3[k] = e10[k] + R_bar[k];
    e_y += b_S_nI3[k] * NI[6 + k];
    b_A[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      b_A[k] += A[k + 3 * i29] * NI[6 + i29];
    }

    c_A[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      g_A[k + 3 * i29] = b_A[k] * R_bar[3 + i29];
      c_A[k] += A[k + 3 * i29] * R_bar[3 + i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      b_E0[k + 3 * i29] = c_A[k] * NI[6 + i29];
      f_A[k + 3 * i29] = 0.0;
      for (i30 = 0; i30 < 3; i30++) {
        f_A[k + 3 * i29] += g_A[k + 3 * i30] * A[i30 + 3 * i29];
      }
    }

    b_el_in_orient_ij[k] = 0.0;
    c_el_in_orient_ij[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      h_A[k + 3 * i29] = 0.0;
      for (i30 = 0; i30 < 3; i30++) {
        h_A[k + 3 * i29] += b_E0[k + 3 * i30] * A[i30 + 3 * i29];
      }

      b_el_in_orient_ij[k] += A[k + 3 * i29] * NI[6 + i29];
      c_el_in_orient_ij[k] += A[k + 3 * i29] * NI[6 + i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      i_A[k + 3 * i29] = b_el_in_orient_ij[k] * e10[i29];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    c_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_E0[i29 + 3 * i30] = c_el_in_orient_ij[i30] * e10[i29];
      b_A[i29] += A[i29 + 3 * i30] * R_bar[3 + i30];
      c_A[i29] += A[i29 + 3 * i30] * R_bar[3 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      g_A[i29 + 3 * i30] = b_A[i29] * e10[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      j_A[i29 + 3 * i30] = c_A[i30] * e10[i29];
    }
  }

  /* 3x3 */
  f_y = 0.0;
  for (k = 0; k < 3; k++) {
    b_S_nI3[k] = e10[k] + R_bar[k];
    f_y += b_S_nI3[k] * NI[6 + k];
    b_A[k] = 0.0;
    for (i29 = 0; i29 < 3; i29++) {
      g11[i29 + 3 * k] = -0.5 * (((f_A[i29 + 3 * k] + h_A[i29 + 3 * k]) + y *
        (b_y * ((i_A[i29 + 3 * k] + b_E0[i29 + 3 * k]) + A[i29 + 3 * k] * B))) +
        e_y * (c_y * ((g_A[i29 + 3 * k] + j_A[i29 + 3 * k]) + A[i29 + 3 * k] *
                      d_y)));
      b_A[k] += A[k + 3 * i29] * NI[6 + i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      k_A[k + 3 * i29] = b_A[k] * e10[i29];
    }

    for (i29 = 0; i29 < 3; i29++) {
      l_A[k + 3 * i29] = 0.0;
      for (i30 = 0; i30 < 3; i30++) {
        l_A[k + 3 * i29] += k_A[k + 3 * i30] * Srk[i30 + 3 * i29];
      }
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      i_A[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        i_A[i29 + 3 * i30] += f_y * A[i29 + 3 * k] * Srk[k + 3 * i30];
      }

      b_A[i29] += A[i29 + 3 * i30] * R_bar[3 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      g_A[i29 + 3 * i30] = b_A[i29] * NI[6 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      B = 0.0;
      for (k = 0; k < 3; k++) {
        B += g_A[i29 + 3 * k] * Sr1[k + 3 * i30];
      }

      b_E0[i29 + 3 * i30] = (l_A[i29 + 3 * i30] + i_A[i29 + 3 * i30]) + B;
    }
  }

  /* 3x3 */
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i29 = 0; i29 < 3; i29++) {
      g12[i29 + 3 * k] = -0.25 * b_E0[i29 + 3 * k];
    }

    y += R_bar[3 + k] * e10[k];
    b_S_nI3[k] = e10[k] + R_bar[k];
    b_y += b_S_nI3[k] * NI[6 + k];
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_el_in_orient_ij[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_el_in_orient_ij[i29] += Srk[i29 + 3 * i30] * e10[i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      b_Srk[i29 + 3 * i30] = b_el_in_orient_ij[i29] * NI[6 + i30];
      i_A[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        i_A[i29 + 3 * i30] += -y * Sz[i29 + 3 * k] * Sr1[k + 3 * i30];
      }
    }

    c_el_in_orient_ij[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      c_Srk[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        c_Srk[i29 + 3 * i30] += b_Srk[i29 + 3 * k] * Sr1[k + 3 * i30];
      }

      c_el_in_orient_ij[i29] += Sr1[i29 + 3 * i30] * NI[6 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      b_Sr1[i29 + 3 * i30] = c_el_in_orient_ij[i29] * e10[i30];
      B = 0.0;
      for (k = 0; k < 3; k++) {
        B += 2.0 * Sz[i29 + 3 * k] * Srk[k + 3 * i30];
      }

      f_A[i29 + 3 * i30] = (i_A[i29 + 3 * i30] + c_Srk[i29 + 3 * i30]) + B;
    }

    for (i30 = 0; i30 < 3; i30++) {
      c_Sr1[i29 + 3 * i30] = 0.0;
      B = 0.0;
      for (k = 0; k < 3; k++) {
        c_Sr1[i29 + 3 * i30] += b_Sr1[i29 + 3 * k] * Srk[k + 3 * i30];
        B += b_y * Se1[i29 + 3 * k] * Srk[k + 3 * i30];
      }

      h_A[i29 + 3 * i30] = (f_A[i29 + 3 * i30] + c_Sr1[i29 + 3 * i30]) - B;
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      E0[i30 + 3 * i29] = 0.125 * h_A[i30 + 3 * i29];
    }
  }

  /* 3x3 */
  memset(&G8[0], 0, 144U * sizeof(real_T));

  /*  zeros(12) explicitly state for improved performance */
  /* set rows 1 to 3 and cols 1 to 3 to g11 */
  /* set rows 4 to 6 and cols 1 to 3 to g12 transposed */
  /* set rows 7 to 9 and cols 1 to 3 to -g11 */
  /* set rows 10 to 12 and cols 1 to 3 to g12 transposed */
  /* set rows 1 to 3 and cols 4 to 6 to g12 */
  /* set rows 4 to 6 and cols 4 to 6 to g22 */
  /* set rows 7 to 9 and cols 4 to 6 to -g12 */
  /* set rows 10 to 12 and cols 4 to 6 to g22 */
  /* set rows 1 to 3 and cols 7 to 9 to -g11 */
  /* set rows 4 to 6 and cols 7 to 9 to -g12 */
  /* set rows 7 to 9 and cols 7 to 9 to g11 */
  /* set rows 10 to 12 and cols 7 to 9 to -g12 */
  /* set rows 1 to 3 and cols 10 to 12 to g12 */
  /* set rows 4 to 6 and cols 10 to 12 to g22 */
  /* set rows 7 to 9 and cols 10 to 12 to -g12 */
  /* set rows 10 to 12 and cols 10 to 12 to g22 */
  /*  G = [g11 g12 -g11 g12 */
  /*      g12' g22 -g12' g22 */
  /*      -g11 -g12 g11 -g12 */
  /*      g12' g22 -g12' g22]; */
  /*  KC */
  /*  KD */
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      G8[i30 + 12 * i29] = g11[i30 + 3 * i29];
      G8[(i30 + 12 * i29) + 3] = g12[i29 + 3 * i30];
      G8[(i30 + 12 * i29) + 6] = -g11[i30 + 3 * i29];
      G8[(i30 + 12 * i29) + 9] = g12[i29 + 3 * i30];
      G8[i30 + 12 * (3 + i29)] = g12[i30 + 3 * i29];
      G8[(i30 + 12 * (3 + i29)) + 3] = E0[i30 + 3 * i29];
      G8[(i30 + 12 * (3 + i29)) + 6] = -g12[i30 + 3 * i29];
      G8[(i30 + 12 * (3 + i29)) + 9] = E0[i30 + 3 * i29];
      G8[i30 + 12 * (6 + i29)] = -g11[i30 + 3 * i29];
      G8[(i30 + 12 * (6 + i29)) + 3] = -g12[i29 + 3 * i30];
      G8[(i30 + 12 * (6 + i29)) + 6] = g11[i30 + 3 * i29];
      G8[(i30 + 12 * (6 + i29)) + 9] = -g12[i29 + 3 * i30];
      G8[i30 + 12 * (9 + i29)] = g12[i30 + 3 * i29];
      G8[(i30 + 12 * (9 + i29)) + 3] = E0[i30 + 3 * i29];
      G8[(i30 + 12 * (9 + i29)) + 6] = -g12[i30 + 3 * i29];
      G8[(i30 + 12 * (9 + i29)) + 9] = E0[i30 + 3 * i29];
    }

    for (i30 = 0; i30 < 12; i30++) {
      d_L_r2[i30 + 12 * i29] = -L_r2[i30 + 12 * i29];
    }

    for (i30 = 0; i30 < 3; i30++) {
      b_Srk[i30 + 3 * i29] = m2 * S_nI1[i30 + 3 * i29] + m6I * S_nI3[i30 + 3 *
        i29];
      c_Srk[i30 + 3 * i29] = m4 * S_nI1[i30 + 3 * i29] + m6I * S_nI2[i30 + 3 *
        i29];
    }
  }

  for (i29 = 0; i29 < 12; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      e_L_r2[i29 + 12 * i30] = 0.0;
      b_L_r3[i29 + 12 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        e_L_r2[i29 + 12 * i30] += d_L_r2[i29 + 12 * k] * b_Srk[k + 3 * i30];
        b_L_r3[i29 + 12 * i30] += L_r3[i29 + 12 * k] * c_Srk[k + 3 * i30];
      }
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 12; i30++) {
      d_L_r2[i30 + 12 * i29] = -L_r2[i30 + 12 * i29];
    }

    for (i30 = 0; i30 < 3; i30++) {
      f_A[i30 + 3 * i29] = m3 * S_nJ1[i30 + 3 * i29] - m6J * S_nJ3[i30 + 3 * i29];
      h_A[i30 + 3 * i29] = m5 * S_nJ1[i30 + 3 * i29] - m6J * S_nJ2[i30 + 3 * i29];
    }
  }

  for (i29 = 0; i29 < 12; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      L_r2[i29 + 12 * i30] = 0.0;
      e_L_r3[i29 + 12 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        L_r2[i29 + 12 * i30] += d_L_r2[i29 + 12 * k] * f_A[k + 3 * i30];
        e_L_r3[i29 + 12 * i30] += L_r3[i29 + 12 * k] * h_A[k + 3 * i30];
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
  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 12; i30++) {
      KD[i30 + 12 * i29] = 0.0;
      KD[i30 + 12 * (i29 + 3)] = e_L_r2[i30 + 12 * i29] + b_L_r3[i30 + 12 * i29];
      KD[i30 + 12 * (i29 + 6)] = 0.0;
      KD[i30 + 12 * (i29 + 9)] = L_r2[i30 + 12 * i29] + e_L_r3[i30 + 12 * i29];
    }

    for (i30 = 0; i30 < 3; i30++) {
      f_A[i29 + 3 * i30] = (real_T)iv42[i29 + 3 * i30] - e10[i29] * e10[i30];
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
    for (i29 = 0; i29 < 3; i29++) {
      A[i29 + 3 * k] = y * f_A[i29 + 3 * k];
    }

    B += e10[k] * NI[3 + k];
    d_y += e10[k] * NJ[3 + k];
    f_y += e10[k] * NI[6 + k];
    h_y += e10[k] * NJ[6 + k];
  }

  /* GET_S */
  /*    Get the S matrix */
  /* replace zeros(3) with explicit definition to improve performance */
  for (i29 = 0; i29 < 9; i29++) {
    E0[i29] = 0.0;
    Srk[i29] = 0.0;
    Sr1[i29] = 0.0;
  }

  E0[1] = e30[2];
  E0[2] = -e30[1];
  E0[3] = -e30[2];
  E0[5] = e30[0];
  E0[6] = e30[1];
  E0[7] = -e30[0];

  /*  S = [0 -w(3) w(2) */
  /*      w(3) 0 -w(1) */
  /*      -w(2) w(1) 0]; */
  /* GET_S */
  /*    Get the S matrix */
  /* replace zeros(3) with explicit definition to improve performance */
  Srk[1] = e10[2];
  Srk[2] = -e10[1];
  Srk[3] = -e10[2];
  Srk[5] = e10[0];
  Srk[6] = e10[1];
  Srk[7] = -e10[0];

  /*  S = [0 -w(3) w(2) */
  /*      w(3) 0 -w(1) */
  /*      -w(2) w(1) 0]; */
  /* GET_S */
  /*    Get the S matrix */
  /* replace zeros(3) with explicit definition to improve performance */
  Sr1[1] = e20[2];
  Sr1[2] = -e20[1];
  Sr1[3] = -e20[2];
  Sr1[5] = e20[0];
  Sr1[6] = e20[1];
  Sr1[7] = -e20[0];

  /*  S = [0 -w(3) w(2) */
  /*      w(3) 0 -w(1) */
  /*      -w(2) w(1) 0]; */
  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    c_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      b_A[i29] += A[i29 + 3 * i30] * NI[3 + i30];
      c_A[i29] += A[i29 + 3 * i30] * NI[3 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      g_A[i29 + 3 * i30] = b_A[i29] * e10[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    b_el_in_orient_ij[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      f_A[i29 + 3 * i30] = c_A[i30] * e10[i29];
      b_A[i29] += A[i29 + 3 * i30] * NJ[3 + i30];
      b_el_in_orient_ij[i29] += A[i29 + 3 * i30] * NJ[3 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      b_E0[i29 + 3 * i30] = b_A[i29] * e10[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    c_A[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      i_A[i29 + 3 * i30] = b_el_in_orient_ij[i30] * e10[i29];
      b_A[i29] += A[i29 + 3 * i30] * NI[6 + i30];
      c_A[i29] += A[i29 + 3 * i30] * NI[6 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      h_A[i29 + 3 * i30] = b_A[i29] * e10[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    b_A[i29] = 0.0;
    b_el_in_orient_ij[i29] = 0.0;
    for (i30 = 0; i30 < 3; i30++) {
      k_A[i29 + 3 * i30] = c_A[i30] * e10[i29];
      b_A[i29] += A[i29 + 3 * i30] * NJ[6 + i30];
      b_el_in_orient_ij[i29] += A[i29 + 3 * i30] * NJ[6 + i30];
    }

    for (i30 = 0; i30 < 3; i30++) {
      j_A[i29 + 3 * i30] = b_A[i29] * e10[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      l_A[i29 + 3 * i30] = b_el_in_orient_ij[i30] * e10[i29];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      Sz[i30 + 3 * i29] = ((-m2 * (b_y * ((g_A[i30 + 3 * i29] + f_A[i30 + 3 *
        i29]) + A[i30 + 3 * i29] * B)) - m3 * (c_y * ((b_E0[i30 + 3 * i29] +
        i_A[i30 + 3 * i29]) + A[i30 + 3 * i29] * d_y))) + m4 * (e_y * ((h_A[i30
        + 3 * i29] + k_A[i30 + 3 * i29]) + A[i30 + 3 * i29] * f_y))) + m5 * (g_y
        * ((j_A[i30 + 3 * i29] + l_A[i30 + 3 * i29]) + A[i30 + 3 * i29] * h_y));
      b_Srk[i29 + 3 * i30] = 0.0;
      c_Srk[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        b_Srk[i29 + 3 * i30] += -m2 * A[i29 + 3 * k] * S_nI2[k + 3 * i30];
        c_Srk[i29 + 3 * i30] += m4 * A[i29 + 3 * k] * S_nI3[k + 3 * i30];
      }
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      Se1[i30 + 3 * i29] = b_Srk[i30 + 3 * i29] + c_Srk[i30 + 3 * i29];
      f_A[i29 + 3 * i30] = 0.0;
      h_A[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        f_A[i29 + 3 * i30] += -m3 * A[i29 + 3 * k] * S_nJ2[k + 3 * i30];
        h_A[i29 + 3 * i30] += m5 * A[i29 + 3 * k] * S_nJ3[k + 3 * i30];
      }
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      g11[i30 + 3 * i29] = f_A[i30 + 3 * i29] + h_A[i30 + 3 * i29];
    }
  }

  /*  KG - geometric stiffness matrix */
  /*  Element global tangent stiffness matrix */
  for (i29 = 0; i29 < 12; i29++) {
    for (i30 = 0; i30 < 6; i30++) {
      i_y[i29 + 12 * i30] = 0.0;
      for (k = 0; k < 6; k++) {
        i_y[i29 + 12 * i30] += T[k + 6 * i29] * KL[k + 6 * i30];
      }
    }
  }

  B = 1.0;
  c_y = 0.0;
  TRANSB = 'N';
  TRANSA = 'N';
  memset(&j_y[0], 0, 144U * sizeof(real_T));
  m_t = (ptrdiff_t)12;
  n_t = (ptrdiff_t)12;
  k_t = (ptrdiff_t)6;
  lda_t = (ptrdiff_t)12;
  ldb_t = (ptrdiff_t)6;
  ldc_t = (ptrdiff_t)12;
  dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &B, &i_y[0], &lda_t, &T[0], &ldb_t,
        &c_y, &j_y[0], &ldc_t);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NI[0], e10, L, *(real_T (*)
         [3])&R_bar[0], e_A);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NJ[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv40);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NI[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv41);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NJ[0], e10, L, *(real_T (*)
         [3])&R_bar[0], dv42);
  get_G(*(real_T (*)[3])&R_bar[6], *(real_T (*)[3])&NJ[3], e10, L, *(real_T (*)
         [3])&R_bar[0], dv43);
  get_G(*(real_T (*)[3])&R_bar[3], *(real_T (*)[3])&NJ[6], e10, L, *(real_T (*)
         [3])&R_bar[0], dv44);
  for (i29 = 0; i29 < 12; i29++) {
    d_A[i29] = -t6I[i29];
    for (i30 = 0; i30 < 12; i30++) {
      b_t2[i29 + 12 * i30] = t2[i29] * t2[i30];
      b_t3[i29 + 12 * i30] = t3[i29] * t3[i30];
      b_t4[i29 + 12 * i30] = t4[i29] * t4[i30];
      b_t5[i29 + 12 * i30] = t5[i29] * t5[i30];
      b_t6I[i29 + 12 * i30] = d_A[i29] * t6I[i30];
      b_t6J[i29 + 12 * i30] = t6J[i29] * t6J[i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      b_E0[i29 + 3 * i30] = 0.0;
      b_Srk[i29 + 3 * i30] = 0.0;
      b_Sr1[i29 + 3 * i30] = 0.0;
      c_Srk[i29 + 3 * i30] = 0.0;
      c_Sr1[i29 + 3 * i30] = 0.0;
      f_A[i29 + 3 * i30] = 0.0;
      h_A[i29 + 3 * i30] = 0.0;
      i_A[i29 + 3 * i30] = 0.0;
      j_A[i29 + 3 * i30] = 0.0;
      g_A[i29 + 3 * i30] = 0.0;
      k_A[i29 + 3 * i30] = 0.0;
      l_A[i29 + 3 * i30] = 0.0;
      for (k = 0; k < 3; k++) {
        b_E0[i29 + 3 * i30] += E0[i29 + 3 * k] * S_nI1[k + 3 * i30];
        b_Srk[i29 + 3 * i30] += Srk[i29 + 3 * k] * S_nI2[k + 3 * i30];
        b_Sr1[i29 + 3 * i30] += Sr1[i29 + 3 * k] * S_nI1[k + 3 * i30];
        c_Srk[i29 + 3 * i30] += Srk[i29 + 3 * k] * S_nI3[k + 3 * i30];
        c_Sr1[i29 + 3 * i30] += Sr1[i29 + 3 * k] * S_nI2[k + 3 * i30];
        f_A[i29 + 3 * i30] += E0[i29 + 3 * k] * S_nI3[k + 3 * i30];
        h_A[i29 + 3 * i30] += E0[i29 + 3 * k] * S_nJ1[k + 3 * i30];
        i_A[i29 + 3 * i30] += Srk[i29 + 3 * k] * S_nJ2[k + 3 * i30];
        j_A[i29 + 3 * i30] += Sr1[i29 + 3 * k] * S_nJ1[k + 3 * i30];
        g_A[i29 + 3 * i30] += Srk[i29 + 3 * k] * S_nJ3[k + 3 * i30];
        k_A[i29 + 3 * i30] += Sr1[i29 + 3 * k] * S_nJ2[k + 3 * i30];
        l_A[i29 + 3 * i30] += E0[i29 + 3 * k] * S_nJ3[k + 3 * i30];
      }

      b_Sz[i30 + 12 * i29] = Sz[i30 + 3 * i29];
      b_Sz[i30 + 12 * (i29 + 3)] = Se1[i30 + 3 * i29];
      b_Sz[i30 + 12 * (i29 + 6)] = -Sz[i30 + 3 * i29];
      b_Sz[i30 + 12 * (i29 + 9)] = g11[i30 + 3 * i29];
      b_Sz[(i30 + 12 * i29) + 3] = Se1[i29 + 3 * i30];
    }
  }

  for (i29 = 0; i29 < 3; i29++) {
    for (i30 = 0; i30 < 3; i30++) {
      b_Sz[(i30 + 12 * (i29 + 3)) + 3] = (m2 * (b_E0[i30 + 3 * i29] - b_Srk[i30
        + 3 * i29]) - m4 * (b_Sr1[i30 + 3 * i29] - c_Srk[i30 + 3 * i29])) - m6I *
        (c_Sr1[i30 + 3 * i29] - f_A[i30 + 3 * i29]);
      b_Sz[(i30 + 12 * (i29 + 6)) + 3] = -Se1[i29 + 3 * i30];
      b_Sz[(i30 + 12 * (i29 + 9)) + 3] = 0.0;
      b_Sz[(i30 + 12 * i29) + 6] = -Sz[i30 + 3 * i29];
      b_Sz[(i30 + 12 * (i29 + 3)) + 6] = -Se1[i30 + 3 * i29];
      b_Sz[(i30 + 12 * (i29 + 6)) + 6] = Sz[i30 + 3 * i29];
      b_Sz[(i30 + 12 * (i29 + 9)) + 6] = -g11[i30 + 3 * i29];
      b_Sz[(i30 + 12 * i29) + 9] = g11[i29 + 3 * i30];
      b_Sz[(i30 + 12 * (i29 + 3)) + 9] = 0.0;
      b_Sz[(i30 + 12 * (i29 + 6)) + 9] = -g11[i29 + 3 * i30];
      b_Sz[(i30 + 12 * (i29 + 9)) + 9] = (m3 * (h_A[i30 + 3 * i29] - i_A[i30 + 3
        * i29]) - m5 * (j_A[i30 + 3 * i29] - g_A[i30 + 3 * i29])) + m6J *
        (k_A[i30 + 3 * i29] - l_A[i30 + 3 * i29]);
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
  /*  Element global internal force vector */
  for (i29 = 0; i29 < 12; i29++) {
    for (i30 = 0; i30 < 12; i30++) {
      Kel[i30 + 12 * i29] = j_y[i30 + 12 * i29] + (((((KA[i30 + 12 * i29] +
        ((((P[1] * b_t2[i30 + 12 * i29] * x + P[2] * b_t3[i30 + 12 * i29] * b_x)
           + P[3] * b_t4[i30 + 12 * i29] * c_x) + P[4] * b_t5[i30 + 12 * i29] *
          d_x) + P[5] * (b_t6I[i30 + 12 * i29] * e_x + b_t6J[i30 + 12 * i29] *
                         f_x))) + (((((m2 * e_A[i30 + 12 * i29] + m3 * dv40[i30
        + 12 * i29]) - m4 * dv41[i30 + 12 * i29]) - m5 * dv42[i30 + 12 * i29]) +
        m6I * (dv43[i30 + 12 * i29] - dv44[i30 + 12 * i29])) - m6J * (G7[i30 +
        12 * i29] - G8[i30 + 12 * i29]))) + KD[i30 + 12 * i29]) + KD[i29 + 12 *
        i30]) + b_Sz[i30 + 12 * i29]);
    }

    Fint_i[i29] = 0.0;
    for (i30 = 0; i30 < 6; i30++) {
      Fint_i[i29] += T[i30 + 6 * i29] * P[i30];
    }
  }

  /*  Update element output; */
  emxCopyStruct_struct_T1(&el_in0->flex, &el_out0);
  el_in0->b_break = el_out0.b_break;
  emxFreeStruct_struct_T1(&el_out0);
  for (k = 0; k < 6; k++) {
    el_in0->D0[k] = D[k];
    el_in0->P0[k] = P[k];
  }

  memcpy(&el_in0->K0[0], &KL[0], 36U * sizeof(real_T));

  /*  D(1) */
  /*  KL_el = T'*KL*T; */
  emlrtHeapReferenceStackLeaveFcnR2012b(aTLS);
}

/* End of code generation (el3.c) */
