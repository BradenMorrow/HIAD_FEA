/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_GL.c
 *
 * Code generation for function 'get_GL'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_GL.h"

/* Function Definitions */
void get_GL(real_T n, real_T xi_data[], int32_T xi_size[1], real_T wi_data[],
            int32_T wi_size[1])
{
  int32_T i1;
  static const real_T dv2[3] = { 0.33333333, 1.33333333, 0.33333333 };

  static const real_T dv3[4] = { -1.0, -0.4472136, 0.4472136, 1.0 };

  static const real_T dv4[4] = { 0.16666667, 0.83333333, 0.83333333, 0.16666667
  };

  static const real_T dv5[5] = { -1.0, -0.65465367, 0.0, 0.65465367, 1.0 };

  static const real_T dv6[5] = { 0.1, 0.54444444, 0.71111111, 0.54444444, 0.1 };

  static const real_T dv7[6] = { -1.0, -0.76505532, -0.28523152, 0.28523152,
    0.76505532, 1.0 };

  static const real_T dv8[6] = { 0.06666667, 0.37847496, 0.55485838, 0.55485838,
    0.37847496, 0.06666667 };

  static const real_T dv9[7] = { -1.0, -0.8302239, -0.46884879, 0.0, 0.46884879,
    0.8302239, 1.0 };

  static const real_T dv10[7] = { 0.04761904, 0.27682604, 0.43174538, 0.48761904,
    0.43174538, 0.27682604, 0.04761904 };

  static const real_T dv11[8] = { -1.0, -0.87174015, -0.59170018, -0.20929922,
    0.20929922, 0.59170018, 0.87174015, 1.0 };

  static const real_T dv12[8] = { 0.03571428, 0.21070422, 0.3411227, 0.4124588,
    0.4124588, 0.3411227, 0.21070422, 0.03571428 };

  static const real_T dv13[9] = { -1.0, -0.8997579954, -0.6771862795,
    -0.3631174638, 0.0, 0.3631174638, 0.6771862795, 0.8997579954, 1.0 };

  static const real_T dv14[9] = { 0.0277777778, 0.1654953616, 0.2745387126,
    0.346428511, 0.3715192744, 0.346428511, 0.2745387126, 0.1654953616,
    0.0277777778 };

  static const real_T dv15[10] = { -1.0, -0.9195339082, -0.7387738651,
    -0.4779249498, -0.1652789577, 0.1652789577, 0.4779249498, 0.7387738651,
    0.9195339082, 1.0 };

  static const real_T dv16[10] = { 0.0222222222, 0.1333059908, 0.224889342,
    0.2920426836, 0.3275397612, 0.3275397612, 0.2920426836, 0.224889342,
    0.1333059908, 0.0222222222 };

  /*  Gauss - Lobatto integration constants */
  /*  For 3 <= n <= 10 */
  if (n == 3.0) {
    xi_size[0] = 3;
    wi_size[0] = 3;
    for (i1 = 0; i1 < 3; i1++) {
      xi_data[i1] = -1.0 + (real_T)i1;
      wi_data[i1] = dv2[i1];
    }
  } else if (n == 4.0) {
    xi_size[0] = 4;
    wi_size[0] = 4;
    for (i1 = 0; i1 < 4; i1++) {
      xi_data[i1] = dv3[i1];
      wi_data[i1] = dv4[i1];
    }
  } else if (n == 5.0) {
    xi_size[0] = 5;
    wi_size[0] = 5;
    for (i1 = 0; i1 < 5; i1++) {
      xi_data[i1] = dv5[i1];
      wi_data[i1] = dv6[i1];
    }
  } else if (n == 6.0) {
    xi_size[0] = 6;
    wi_size[0] = 6;
    for (i1 = 0; i1 < 6; i1++) {
      xi_data[i1] = dv7[i1];
      wi_data[i1] = dv8[i1];
    }
  } else if (n == 7.0) {
    xi_size[0] = 7;
    wi_size[0] = 7;
    for (i1 = 0; i1 < 7; i1++) {
      xi_data[i1] = dv9[i1];
      wi_data[i1] = dv10[i1];
    }
  } else if (n == 8.0) {
    xi_size[0] = 8;
    wi_size[0] = 8;
    memcpy(&xi_data[0], &dv11[0], sizeof(real_T) << 3);
    memcpy(&wi_data[0], &dv12[0], sizeof(real_T) << 3);
  } else if (n == 9.0) {
    xi_size[0] = 9;
    wi_size[0] = 9;
    memcpy(&xi_data[0], &dv13[0], 9U * sizeof(real_T));
    memcpy(&wi_data[0], &dv14[0], 9U * sizeof(real_T));
  } else {
    xi_size[0] = 10;
    wi_size[0] = 10;
    memcpy(&xi_data[0], &dv15[0], 10U * sizeof(real_T));
    memcpy(&wi_data[0], &dv16[0], 10U * sizeof(real_T));
  }
}

/* End of code generation (get_GL.c) */
