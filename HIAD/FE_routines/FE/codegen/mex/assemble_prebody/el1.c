/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * el1.c
 *
 * Code generation for function 'el1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "el1.h"

/* Function Definitions */
void el1(const real_T U_in_U0[12], const real_T U_in_U[12], const real_T
         U_in_delta_U[12], const real_T el_in_nodes_ij[6], const real_T
         el_in_orient_ij[3], b_struct_T *el_in0, real_T Kel[144], real_T fint_i
         [12], real_T Fint_i[12], real_T ROT_rot[6], real_T ROT_DELTA_rot[6])
{
  real_T y[3];
  int32_T k;
  real_T scale;
  real_T b_y;
  real_T L0;
  real_T b_el_in_nodes_ij[3];
  real_T absxk;
  real_T t;
  real_T xp[3];
  real_T b_el_in_orient_ij[3];
  real_T yp[3];
  real_T zp[3];
  real_T c_y;
  real_T d_y;
  real_T e_y;
  real_T f_y;
  real_T g_y;
  real_T h_y;
  real_T b_yp;
  static const int8_T iv44[3] = { 1, 0, 0 };

  static const int8_T iv45[3] = { 0, 1, 0 };

  static const int8_T iv46[3] = { 0, 0, 1 };

  real_T lambda[9];
  int32_T i34;
  real_T T[144];
  real_T b_U_in_U[12];
  real_T G;
  real_T X;
  real_T S;
  real_T phi_y;
  real_T Y1;
  real_T Y2;
  real_T Y3;
  real_T Y4;
  real_T phi_z;
  real_T Z1;
  real_T Z2;
  real_T Z3;
  real_T Z4;
  real_T b_k[144];
  real_T a[144];
  real_T u[12];
  char_T TRANSB;
  char_T TRANSA;
  real_T i_y[144];
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;

  /* EL1 */
  /*    Linear elastic, 3D beam element */
  /*  Extract variables */
  /*  Geometry */
  /*  Materials */
  for (k = 0; k < 3; k++) {
    scale = el_in_nodes_ij[1 + (k << 1)] - el_in_nodes_ij[k << 1];
    y[k] = scale * scale;
  }

  b_y = y[0];
  for (k = 0; k < 2; k++) {
    b_y += y[k + 1];
  }

  L0 = muDoubleScalarSqrt(b_y);

  /*  Obtain displacements of interest */
  /*  Transformation matrix */
  /* T_BEAM_3D */
  /*    Generate the transformation matrix for a 3D beam element; */
  /*  Length of element */
  /*  Vector to orientation node */
  /*  Unit vectors */
  /*  Global */
  /*  Local */
  b_el_in_nodes_ij[0] = el_in_nodes_ij[1] - el_in_nodes_ij[0];
  b_el_in_nodes_ij[1] = el_in_nodes_ij[3] - el_in_nodes_ij[2];
  b_el_in_nodes_ij[2] = el_in_nodes_ij[5] - el_in_nodes_ij[4];
  b_y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(b_el_in_nodes_ij[k]);
    if (absxk > scale) {
      t = scale / absxk;
      b_y = 1.0 + b_y * t * t;
      scale = absxk;
    } else {
      t = absxk / scale;
      b_y += t * t;
    }

    xp[k] = b_el_in_nodes_ij[k];
  }

  b_y = scale * muDoubleScalarSqrt(b_y);
  b_el_in_orient_ij[0] = el_in_orient_ij[0] - el_in_nodes_ij[0];
  b_el_in_orient_ij[1] = el_in_orient_ij[1] - el_in_nodes_ij[2];
  b_el_in_orient_ij[2] = el_in_orient_ij[2] - el_in_nodes_ij[4];
  for (k = 0; k < 3; k++) {
    yp[k] = b_el_in_orient_ij[k];
    xp[k] /= b_y;
  }

  zp[0] = xp[1] * yp[2] - xp[2] * yp[1];
  zp[1] = xp[2] * yp[0] - xp[0] * yp[2];
  zp[2] = xp[0] * yp[1] - xp[1] * yp[0];
  b_y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(zp[k]);
    if (absxk > scale) {
      t = scale / absxk;
      b_y = 1.0 + b_y * t * t;
      scale = absxk;
    } else {
      t = absxk / scale;
      b_y += t * t;
    }
  }

  b_y = scale * muDoubleScalarSqrt(b_y);
  for (k = 0; k < 3; k++) {
    zp[k] /= b_y;
  }

  yp[0] = zp[1] * xp[2] - zp[2] * xp[1];
  yp[1] = zp[2] * xp[0] - zp[0] * xp[2];
  yp[2] = zp[0] * xp[1] - zp[1] * xp[0];
  b_y = 0.0;
  scale = 2.2250738585072014E-308;
  for (k = 0; k < 3; k++) {
    absxk = muDoubleScalarAbs(yp[k]);
    if (absxk > scale) {
      t = scale / absxk;
      b_y = 1.0 + b_y * t * t;
      scale = absxk;
    } else {
      t = absxk / scale;
      b_y += t * t;
    }
  }

  b_y = scale * muDoubleScalarSqrt(b_y);

  /*  Direction cosines matrix */
  scale = 0.0;
  absxk = 0.0;
  t = 0.0;
  c_y = 0.0;
  d_y = 0.0;
  e_y = 0.0;
  f_y = 0.0;
  g_y = 0.0;
  h_y = 0.0;
  for (k = 0; k < 3; k++) {
    b_yp = yp[k] / b_y;
    scale += (real_T)iv44[k] * xp[k];
    absxk += (real_T)iv45[k] * xp[k];
    t += (real_T)iv46[k] * xp[k];
    c_y += (real_T)iv44[k] * b_yp;
    d_y += (real_T)iv45[k] * b_yp;
    e_y += (real_T)iv46[k] * b_yp;
    f_y += (real_T)iv44[k] * zp[k];
    g_y += (real_T)iv45[k] * zp[k];
    h_y += (real_T)iv46[k] * zp[k];
  }

  lambda[0] = scale;
  lambda[3] = absxk;
  lambda[6] = t;
  lambda[1] = c_y;
  lambda[4] = d_y;
  lambda[7] = e_y;
  lambda[2] = f_y;
  lambda[5] = g_y;
  lambda[8] = h_y;

  /*  Assemble transformation matrix */
  for (k = 0; k < 3; k++) {
    for (i34 = 0; i34 < 3; i34++) {
      T[i34 + 12 * k] = lambda[i34 + 3 * k];
      T[i34 + 12 * (k + 3)] = 0.0;
      T[i34 + 12 * (k + 6)] = 0.0;
      T[i34 + 12 * (k + 9)] = 0.0;
      T[(i34 + 12 * k) + 3] = 0.0;
      T[(i34 + 12 * (k + 3)) + 3] = lambda[i34 + 3 * k];
      T[(i34 + 12 * (k + 6)) + 3] = 0.0;
      T[(i34 + 12 * (k + 9)) + 3] = 0.0;
      T[(i34 + 12 * k) + 6] = 0.0;
      T[(i34 + 12 * (k + 3)) + 6] = 0.0;
      T[(i34 + 12 * (k + 6)) + 6] = lambda[i34 + 3 * k];
      T[(i34 + 12 * (k + 9)) + 6] = 0.0;
      T[(i34 + 12 * k) + 9] = 0.0;
      T[(i34 + 12 * (k + 3)) + 9] = 0.0;
      T[(i34 + 12 * (k + 6)) + 9] = 0.0;
      T[(i34 + 12 * (k + 9)) + 9] = lambda[i34 + 3 * k];
    }
  }

  /*  Local element displacements */
  for (k = 0; k < 2; k++) {
    for (i34 = 0; i34 < 6; i34++) {
      b_U_in_U[i34 + 6 * k] = U_in_U[k + (i34 << 1)];
    }
  }

  /*  Local element stiffness matrix */
  /* k_lin_beam */
  /*    Calculate the local element stiffness matrix.  3D beam element, Cook et al. */
  /*    (2002) */
  /*  Extract variables */
  G = el_in0->mat[0] / (2.0 * (1.0 + el_in0->mat[1]));

  /*  Calculate entries of stiffness matrix */
  X = el_in0->mat[0] * el_in0->geom[0] / L0;
  S = G * el_in0->geom[4] / L0;
  phi_y = 12.0 * el_in0->mat[0] * el_in0->geom[1] * el_in0->geom[3] /
    (el_in0->geom[0] * G * (L0 * L0));
  Y1 = 12.0 * el_in0->mat[0] * el_in0->geom[1] / ((1.0 + phi_y) *
    muDoubleScalarPower(L0, 3.0));
  Y2 = 6.0 * el_in0->mat[0] * el_in0->geom[1] / ((1.0 + phi_y) * (L0 * L0));
  Y3 = (4.0 + phi_y) * el_in0->mat[0] * el_in0->geom[1] / ((1.0 + phi_y) * L0);
  Y4 = (2.0 - phi_y) * el_in0->mat[0] * el_in0->geom[1] / ((1.0 + phi_y) * L0);
  phi_z = 12.0 * el_in0->mat[0] * el_in0->geom[2] * el_in0->geom[3] /
    (el_in0->geom[0] * G * (L0 * L0));
  Z1 = 12.0 * el_in0->mat[0] * el_in0->geom[2] / ((1.0 + phi_z) *
    muDoubleScalarPower(L0, 3.0));
  Z2 = 6.0 * el_in0->mat[0] * el_in0->geom[2] / ((1.0 + phi_z) * (L0 * L0));
  Z3 = (4.0 + phi_z) * el_in0->mat[0] * el_in0->geom[2] / ((1.0 + phi_z) * L0);
  Z4 = (2.0 - phi_z) * el_in0->mat[0] * el_in0->geom[2] / ((1.0 + phi_z) * L0);

  /*  Assemble matrix */
  b_k[0] = X;
  b_k[12] = 0.0;
  b_k[24] = 0.0;
  b_k[36] = 0.0;
  b_k[48] = 0.0;
  b_k[60] = 0.0;
  b_k[72] = -X;
  b_k[84] = 0.0;
  b_k[96] = 0.0;
  b_k[108] = 0.0;
  b_k[120] = 0.0;
  b_k[132] = 0.0;
  b_k[1] = 0.0;
  b_k[13] = Y1;
  b_k[25] = 0.0;
  b_k[37] = 0.0;
  b_k[49] = 0.0;
  b_k[61] = Y2;
  b_k[73] = 0.0;
  b_k[85] = -Y1;
  b_k[97] = 0.0;
  b_k[109] = 0.0;
  b_k[121] = 0.0;
  b_k[133] = Y2;
  b_k[2] = 0.0;
  b_k[14] = 0.0;
  b_k[26] = Z1;
  b_k[38] = 0.0;
  b_k[50] = -Z2;
  b_k[62] = 0.0;
  b_k[74] = 0.0;
  b_k[86] = 0.0;
  b_k[98] = -Z1;
  b_k[110] = 0.0;
  b_k[122] = -Z2;
  b_k[134] = 0.0;
  b_k[3] = 0.0;
  b_k[15] = 0.0;
  b_k[27] = 0.0;
  b_k[39] = S;
  b_k[51] = 0.0;
  b_k[63] = 0.0;
  b_k[75] = 0.0;
  b_k[87] = 0.0;
  b_k[99] = 0.0;
  b_k[111] = -S;
  b_k[123] = 0.0;
  b_k[135] = 0.0;
  b_k[4] = 0.0;
  b_k[16] = 0.0;
  b_k[28] = -Z2;
  b_k[40] = 0.0;
  b_k[52] = Z3;
  b_k[64] = 0.0;
  b_k[76] = 0.0;
  b_k[88] = 0.0;
  b_k[100] = Z2;
  b_k[112] = 0.0;
  b_k[124] = Z4;
  b_k[136] = 0.0;
  b_k[5] = 0.0;
  b_k[17] = Y2;
  b_k[29] = 0.0;
  b_k[41] = 0.0;
  b_k[53] = 0.0;
  b_k[65] = Y3;
  b_k[77] = 0.0;
  b_k[89] = -Y2;
  b_k[101] = 0.0;
  b_k[113] = 0.0;
  b_k[125] = 0.0;
  b_k[137] = Y4;
  b_k[6] = -X;
  b_k[18] = 0.0;
  b_k[30] = 0.0;
  b_k[42] = 0.0;
  b_k[54] = 0.0;
  b_k[66] = 0.0;
  b_k[78] = X;
  b_k[90] = 0.0;
  b_k[102] = 0.0;
  b_k[114] = 0.0;
  b_k[126] = 0.0;
  b_k[138] = 0.0;
  b_k[7] = 0.0;
  b_k[19] = -Y1;
  b_k[31] = 0.0;
  b_k[43] = 0.0;
  b_k[55] = 0.0;
  b_k[67] = -Y2;
  b_k[79] = 0.0;
  b_k[91] = Y1;
  b_k[103] = 0.0;
  b_k[115] = 0.0;
  b_k[127] = 0.0;
  b_k[139] = -Y2;
  b_k[8] = 0.0;
  b_k[20] = 0.0;
  b_k[32] = -Z1;
  b_k[44] = 0.0;
  b_k[56] = Z2;
  b_k[68] = 0.0;
  b_k[80] = 0.0;
  b_k[92] = 0.0;
  b_k[104] = Z1;
  b_k[116] = 0.0;
  b_k[128] = Z2;
  b_k[140] = 0.0;
  b_k[9] = 0.0;
  b_k[21] = 0.0;
  b_k[33] = 0.0;
  b_k[45] = -S;
  b_k[57] = 0.0;
  b_k[69] = 0.0;
  b_k[81] = 0.0;
  b_k[93] = 0.0;
  b_k[105] = 0.0;
  b_k[117] = S;
  b_k[129] = 0.0;
  b_k[141] = 0.0;
  b_k[10] = 0.0;
  b_k[22] = 0.0;
  b_k[34] = -Z2;
  b_k[46] = 0.0;
  b_k[58] = Z4;
  b_k[70] = 0.0;
  b_k[82] = 0.0;
  b_k[94] = 0.0;
  b_k[106] = Z2;
  b_k[118] = 0.0;
  b_k[130] = Z3;
  b_k[142] = 0.0;
  b_k[11] = 0.0;
  b_k[23] = Y2;
  b_k[35] = 0.0;
  b_k[47] = 0.0;
  b_k[59] = 0.0;
  b_k[71] = Y4;
  b_k[83] = 0.0;
  b_k[95] = -Y2;
  b_k[107] = 0.0;
  b_k[119] = 0.0;
  b_k[131] = 0.0;
  b_k[143] = Y3;

  /*  Element stiffness matrix */
  for (k = 0; k < 12; k++) {
    u[k] = 0.0;
    for (i34 = 0; i34 < 12; i34++) {
      a[i34 + 12 * k] = T[k + 12 * i34];
      u[k] += T[k + 12 * i34] * b_U_in_U[i34];
    }
  }

  scale = 1.0;
  absxk = 0.0;
  TRANSB = 'N';
  TRANSA = 'N';
  memset(&i_y[0], 0, 144U * sizeof(real_T));
  m_t = (ptrdiff_t)12;
  n_t = (ptrdiff_t)12;
  k_t = (ptrdiff_t)12;
  lda_t = (ptrdiff_t)12;
  ldb_t = (ptrdiff_t)12;
  ldc_t = (ptrdiff_t)12;
  dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &scale, &a[0], &lda_t, &b_k[0],
        &ldb_t, &absxk, &i_y[0], &ldc_t);
  scale = 1.0;
  absxk = 0.0;
  TRANSB = 'N';
  TRANSA = 'N';
  memset(&Kel[0], 0, 144U * sizeof(real_T));
  m_t = (ptrdiff_t)12;
  n_t = (ptrdiff_t)12;
  k_t = (ptrdiff_t)12;
  lda_t = (ptrdiff_t)12;
  ldb_t = (ptrdiff_t)12;
  ldc_t = (ptrdiff_t)12;
  dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &scale, &i_y[0], &lda_t, &T[0],
        &ldb_t, &absxk, &Kel[0], &ldc_t);

  /*  Element internal forces */
  for (k = 0; k < 12; k++) {
    fint_i[k] = 0.0;
    for (i34 = 0; i34 < 12; i34++) {
      fint_i[k] += b_k[k + 12 * i34] * u[i34];
    }
  }

  /*  Local */
  for (k = 0; k < 12; k++) {
    Fint_i[k] = 0.0;
    for (i34 = 0; i34 < 12; i34++) {
      Fint_i[k] += T[i34 + 12 * k] * fint_i[i34];
    }
  }

  /*  Global */
  /*  Extract rotations */
  /*  Total rotation */
  /*  Initialize ROT.DELTA_rot */
  for (k = 0; k < 3; k++) {
    for (i34 = 0; i34 < 2; i34++) {
      ROT_rot[i34 + (k << 1)] = U_in_U[i34 + ((3 + k) << 1)] + U_in_delta_U[i34
        + ((3 + k) << 1)];
      ROT_DELTA_rot[i34 + (k << 1)] = ROT_rot[i34 + (k << 1)] - U_in_U0[i34 +
        ((3 + k) << 1)];
    }
  }

  /*  Increment change in rotation */
  /*  Do not need to save any variables for future iterations */
  el_in0->b_break = 0.0;
}

/* End of code generation (el1.c) */
