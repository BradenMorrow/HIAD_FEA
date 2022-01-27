/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * k1.c
 *
 * Code generation for function 'k1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "k1.h"

/* Function Definitions */
void k1(const real_T material[2], const real_T geom[5], real_T L, real_T k[144])
{
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

  /* k_lin_beam */
  /*    Calculate the local element stiffness matrix.  3D beam element, Cook et al. */
  /*    (2002) */
  /*  Extract variables */
  G = material[0] / (2.0 * (1.0 + material[1]));

  /*  Calculate entries of stiffness matrix */
  X = material[0] * geom[0] / L;
  S = G * geom[4] / L;
  phi_y = 12.0 * material[0] * geom[1] * geom[3] / (geom[0] * G * (L * L));
  Y1 = 12.0 * material[0] * geom[1] / ((1.0 + phi_y) * muDoubleScalarPower(L,
    3.0));
  Y2 = 6.0 * material[0] * geom[1] / ((1.0 + phi_y) * (L * L));
  Y3 = (4.0 + phi_y) * material[0] * geom[1] / ((1.0 + phi_y) * L);
  Y4 = (2.0 - phi_y) * material[0] * geom[1] / ((1.0 + phi_y) * L);
  phi_z = 12.0 * material[0] * geom[2] * geom[3] / (geom[0] * G * (L * L));
  Z1 = 12.0 * material[0] * geom[2] / ((1.0 + phi_z) * muDoubleScalarPower(L,
    3.0));
  Z2 = 6.0 * material[0] * geom[2] / ((1.0 + phi_z) * (L * L));
  Z3 = (4.0 + phi_z) * material[0] * geom[2] / ((1.0 + phi_z) * L);
  Z4 = (2.0 - phi_z) * material[0] * geom[2] / ((1.0 + phi_z) * L);

  /*  Assemble matrix */
  k[0] = X;
  k[12] = 0.0;
  k[24] = 0.0;
  k[36] = 0.0;
  k[48] = 0.0;
  k[60] = 0.0;
  k[72] = -X;
  k[84] = 0.0;
  k[96] = 0.0;
  k[108] = 0.0;
  k[120] = 0.0;
  k[132] = 0.0;
  k[1] = 0.0;
  k[13] = Y1;
  k[25] = 0.0;
  k[37] = 0.0;
  k[49] = 0.0;
  k[61] = Y2;
  k[73] = 0.0;
  k[85] = -Y1;
  k[97] = 0.0;
  k[109] = 0.0;
  k[121] = 0.0;
  k[133] = Y2;
  k[2] = 0.0;
  k[14] = 0.0;
  k[26] = Z1;
  k[38] = 0.0;
  k[50] = -Z2;
  k[62] = 0.0;
  k[74] = 0.0;
  k[86] = 0.0;
  k[98] = -Z1;
  k[110] = 0.0;
  k[122] = -Z2;
  k[134] = 0.0;
  k[3] = 0.0;
  k[15] = 0.0;
  k[27] = 0.0;
  k[39] = S;
  k[51] = 0.0;
  k[63] = 0.0;
  k[75] = 0.0;
  k[87] = 0.0;
  k[99] = 0.0;
  k[111] = -S;
  k[123] = 0.0;
  k[135] = 0.0;
  k[4] = 0.0;
  k[16] = 0.0;
  k[28] = -Z2;
  k[40] = 0.0;
  k[52] = Z3;
  k[64] = 0.0;
  k[76] = 0.0;
  k[88] = 0.0;
  k[100] = Z2;
  k[112] = 0.0;
  k[124] = Z4;
  k[136] = 0.0;
  k[5] = 0.0;
  k[17] = Y2;
  k[29] = 0.0;
  k[41] = 0.0;
  k[53] = 0.0;
  k[65] = Y3;
  k[77] = 0.0;
  k[89] = -Y2;
  k[101] = 0.0;
  k[113] = 0.0;
  k[125] = 0.0;
  k[137] = Y4;
  k[6] = -X;
  k[18] = 0.0;
  k[30] = 0.0;
  k[42] = 0.0;
  k[54] = 0.0;
  k[66] = 0.0;
  k[78] = X;
  k[90] = 0.0;
  k[102] = 0.0;
  k[114] = 0.0;
  k[126] = 0.0;
  k[138] = 0.0;
  k[7] = 0.0;
  k[19] = -Y1;
  k[31] = 0.0;
  k[43] = 0.0;
  k[55] = 0.0;
  k[67] = -Y2;
  k[79] = 0.0;
  k[91] = Y1;
  k[103] = 0.0;
  k[115] = 0.0;
  k[127] = 0.0;
  k[139] = -Y2;
  k[8] = 0.0;
  k[20] = 0.0;
  k[32] = -Z1;
  k[44] = 0.0;
  k[56] = Z2;
  k[68] = 0.0;
  k[80] = 0.0;
  k[92] = 0.0;
  k[104] = Z1;
  k[116] = 0.0;
  k[128] = Z2;
  k[140] = 0.0;
  k[9] = 0.0;
  k[21] = 0.0;
  k[33] = 0.0;
  k[45] = -S;
  k[57] = 0.0;
  k[69] = 0.0;
  k[81] = 0.0;
  k[93] = 0.0;
  k[105] = 0.0;
  k[117] = S;
  k[129] = 0.0;
  k[141] = 0.0;
  k[10] = 0.0;
  k[22] = 0.0;
  k[34] = -Z2;
  k[46] = 0.0;
  k[58] = Z4;
  k[70] = 0.0;
  k[82] = 0.0;
  k[94] = 0.0;
  k[106] = Z2;
  k[118] = 0.0;
  k[130] = Z3;
  k[142] = 0.0;
  k[11] = 0.0;
  k[23] = Y2;
  k[35] = 0.0;
  k[47] = 0.0;
  k[59] = 0.0;
  k[71] = Y4;
  k[83] = 0.0;
  k[95] = -Y2;
  k[107] = 0.0;
  k[119] = 0.0;
  k[131] = 0.0;
  k[143] = Y3;
}

/* End of code generation (k1.c) */
