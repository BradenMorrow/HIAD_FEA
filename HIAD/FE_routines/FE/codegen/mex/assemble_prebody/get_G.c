/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * get_G.c
 *
 * Code generation for function 'get_G'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "get_G.h"

/* Function Definitions */
void get_G(const real_T rk[3], const real_T z[3], const real_T e1[3], real_T L,
           const real_T r1[3], real_T G[144])
{
  real_T y;
  real_T A[9];
  int32_T i5;
  int32_T i6;
  static const int8_T iv9[9] = { 1, 0, 0, 0, 1, 0, 0, 0, 1 };

  real_T b_y;
  real_T c_y;
  real_T d_y;
  real_T e_y;
  real_T b_A[9];
  int32_T k;
  real_T Srk[9];
  real_T Sr1[9];
  real_T Sz[9];
  real_T Se1[9];
  real_T f_y;
  real_T c_A[3];
  real_T d_A[9];
  real_T e_A[3];
  real_T f_A[9];
  real_T g_A[9];
  real_T h_A[3];
  real_T i_A[3];
  real_T j_A[9];
  real_T a[3];
  real_T k_A[9];
  real_T g_y;
  real_T l_A[9];
  real_T m_A[9];
  real_T h_y[9];
  real_T g11[9];
  real_T g12[9];

  /* GET_G */
  /*    Get the G matrix */
  /* rk = 3x1 double */
  /* z = 3x1 double */
  /* el = 3x1 double */
  /* L = 1x1 double */
  /* r1 = 3x1 double */
  y = 1.0 / L;
  for (i5 = 0; i5 < 3; i5++) {
    for (i6 = 0; i6 < 3; i6++) {
      A[i5 + 3 * i6] = (real_T)iv9[i5 + 3 * i6] - e1[i5] * e1[i6];
    }
  }

  b_y = -1.0 / L;
  c_y = 0.0;
  d_y = -1.0 / L;
  e_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i5 = 0; i5 < 3; i5++) {
      b_A[i5 + 3 * k] = y * A[i5 + 3 * k];
    }

    c_y += e1[k] * z[k];
    e_y += e1[k] * rk[k];
  }

  /*  Mz = get_M(z,e1,L); */
  /*  Mrk = get_M(rk,e1,L); */
  /* explicitly do get_S for improved performance */
  /* Srk = get_S(rk); %3x3 double */
  /* Sr1 = get_S(r1); %3x3 double */
  /* Sz = get_S(z); %3x3 double */
  /* Se1 = get_S(e1); %3x3 double */
  for (i5 = 0; i5 < 9; i5++) {
    Srk[i5] = 0.0;
    Sr1[i5] = 0.0;
    Sz[i5] = 0.0;
    Se1[i5] = 0.0;
  }

  Srk[1] = rk[2];
  Srk[2] = -rk[1];
  Srk[3] = -rk[2];
  Srk[5] = rk[0];
  Srk[6] = rk[1];
  Srk[7] = -rk[0];
  Sr1[1] = r1[2];
  Sr1[2] = -r1[1];
  Sr1[3] = -r1[2];
  Sr1[5] = r1[0];
  Sr1[6] = r1[1];
  Sr1[7] = -r1[0];
  Sz[1] = z[2];
  Sz[2] = -z[1];
  Sz[3] = -z[2];
  Sz[5] = z[0];
  Sz[6] = z[1];
  Sz[7] = -z[0];
  Se1[1] = e1[2];
  Se1[2] = -e1[1];
  Se1[3] = -e1[2];
  Se1[5] = e1[0];
  Se1[6] = e1[1];
  Se1[7] = -e1[0];
  y = 0.0;
  f_y = 0.0;
  for (k = 0; k < 3; k++) {
    y += rk[k] * e1[k];
    a[k] = e1[k] + r1[k];
    f_y += a[k] * z[k];
    c_A[k] = 0.0;
    for (i5 = 0; i5 < 3; i5++) {
      c_A[k] += b_A[k + 3 * i5] * z[i5];
    }

    e_A[k] = 0.0;
    for (i5 = 0; i5 < 3; i5++) {
      d_A[k + 3 * i5] = c_A[k] * rk[i5];
      e_A[k] += b_A[k + 3 * i5] * rk[i5];
    }

    for (i5 = 0; i5 < 3; i5++) {
      f_A[k + 3 * i5] = e_A[k] * z[i5];
      A[k + 3 * i5] = 0.0;
      for (i6 = 0; i6 < 3; i6++) {
        A[k + 3 * i5] += d_A[k + 3 * i6] * b_A[i6 + 3 * i5];
      }
    }

    h_A[k] = 0.0;
    i_A[k] = 0.0;
    for (i5 = 0; i5 < 3; i5++) {
      g_A[k + 3 * i5] = 0.0;
      for (i6 = 0; i6 < 3; i6++) {
        g_A[k + 3 * i5] += f_A[k + 3 * i6] * b_A[i6 + 3 * i5];
      }

      h_A[k] += b_A[k + 3 * i5] * z[i5];
      i_A[k] += b_A[k + 3 * i5] * z[i5];
    }

    for (i5 = 0; i5 < 3; i5++) {
      j_A[k + 3 * i5] = h_A[k] * e1[i5];
    }
  }

  for (i5 = 0; i5 < 3; i5++) {
    c_A[i5] = 0.0;
    e_A[i5] = 0.0;
    for (i6 = 0; i6 < 3; i6++) {
      f_A[i5 + 3 * i6] = i_A[i6] * e1[i5];
      c_A[i5] += b_A[i5 + 3 * i6] * rk[i6];
      e_A[i5] += b_A[i5 + 3 * i6] * rk[i6];
    }

    for (i6 = 0; i6 < 3; i6++) {
      d_A[i5 + 3 * i6] = c_A[i5] * e1[i6];
    }
  }

  for (i5 = 0; i5 < 3; i5++) {
    for (i6 = 0; i6 < 3; i6++) {
      k_A[i5 + 3 * i6] = e_A[i6] * e1[i5];
    }
  }

  /* 3x3 */
  g_y = 0.0;
  for (k = 0; k < 3; k++) {
    a[k] = e1[k] + r1[k];
    g_y += a[k] * z[k];
    c_A[k] = 0.0;
    for (i5 = 0; i5 < 3; i5++) {
      g11[i5 + 3 * k] = -0.5 * (((A[i5 + 3 * k] + g_A[i5 + 3 * k]) + y * (b_y *
        ((j_A[i5 + 3 * k] + f_A[i5 + 3 * k]) + b_A[i5 + 3 * k] * c_y))) + f_y *
        (d_y * ((d_A[i5 + 3 * k] + k_A[i5 + 3 * k]) + b_A[i5 + 3 * k] * e_y)));
      c_A[k] += b_A[k + 3 * i5] * z[i5];
    }

    for (i5 = 0; i5 < 3; i5++) {
      l_A[k + 3 * i5] = c_A[k] * e1[i5];
    }

    for (i5 = 0; i5 < 3; i5++) {
      m_A[k + 3 * i5] = 0.0;
      for (i6 = 0; i6 < 3; i6++) {
        m_A[k + 3 * i5] += l_A[k + 3 * i6] * Srk[i6 + 3 * i5];
      }
    }
  }

  for (i5 = 0; i5 < 3; i5++) {
    c_A[i5] = 0.0;
    for (i6 = 0; i6 < 3; i6++) {
      h_y[i5 + 3 * i6] = 0.0;
      for (k = 0; k < 3; k++) {
        h_y[i5 + 3 * i6] += g_y * b_A[i5 + 3 * k] * Srk[k + 3 * i6];
      }

      c_A[i5] += b_A[i5 + 3 * i6] * rk[i6];
    }

    for (i6 = 0; i6 < 3; i6++) {
      d_A[i5 + 3 * i6] = c_A[i5] * z[i6];
    }

    for (i6 = 0; i6 < 3; i6++) {
      c_y = 0.0;
      for (k = 0; k < 3; k++) {
        c_y += d_A[i5 + 3 * k] * Sr1[k + 3 * i6];
      }

      f_A[i5 + 3 * i6] = (m_A[i5 + 3 * i6] + h_y[i5 + 3 * i6]) + c_y;
    }
  }

  /* 3x3 */
  y = 0.0;
  b_y = 0.0;
  for (k = 0; k < 3; k++) {
    for (i5 = 0; i5 < 3; i5++) {
      g12[i5 + 3 * k] = -0.25 * f_A[i5 + 3 * k];
    }

    y += rk[k] * e1[k];
    a[k] = e1[k] + r1[k];
    b_y += a[k] * z[k];
  }

  for (i5 = 0; i5 < 3; i5++) {
    c_A[i5] = 0.0;
    for (i6 = 0; i6 < 3; i6++) {
      c_A[i5] += Srk[i5 + 3 * i6] * e1[i6];
    }

    for (i6 = 0; i6 < 3; i6++) {
      A[i5 + 3 * i6] = c_A[i5] * z[i6];
      h_y[i5 + 3 * i6] = 0.0;
      for (k = 0; k < 3; k++) {
        h_y[i5 + 3 * i6] += -y * Sz[i5 + 3 * k] * Sr1[k + 3 * i6];
      }
    }

    e_A[i5] = 0.0;
    for (i6 = 0; i6 < 3; i6++) {
      g_A[i5 + 3 * i6] = 0.0;
      for (k = 0; k < 3; k++) {
        g_A[i5 + 3 * i6] += A[i5 + 3 * k] * Sr1[k + 3 * i6];
      }

      e_A[i5] += Sr1[i5 + 3 * i6] * z[i6];
    }

    for (i6 = 0; i6 < 3; i6++) {
      j_A[i5 + 3 * i6] = e_A[i5] * e1[i6];
      c_y = 0.0;
      for (k = 0; k < 3; k++) {
        c_y += 2.0 * Sz[i5 + 3 * k] * Srk[k + 3 * i6];
      }

      k_A[i5 + 3 * i6] = (h_y[i5 + 3 * i6] + g_A[i5 + 3 * i6]) + c_y;
    }

    for (i6 = 0; i6 < 3; i6++) {
      d_A[i5 + 3 * i6] = 0.0;
      c_y = 0.0;
      for (k = 0; k < 3; k++) {
        d_A[i5 + 3 * i6] += j_A[i5 + 3 * k] * Srk[k + 3 * i6];
        c_y += b_y * Se1[i5 + 3 * k] * Srk[k + 3 * i6];
      }

      l_A[i5 + 3 * i6] = (k_A[i5 + 3 * i6] + d_A[i5 + 3 * i6]) - c_y;
    }
  }

  for (i5 = 0; i5 < 3; i5++) {
    for (i6 = 0; i6 < 3; i6++) {
      b_A[i6 + 3 * i5] = 0.125 * l_A[i6 + 3 * i5];
    }
  }

  /* 3x3 */
  memset(&G[0], 0, 144U * sizeof(real_T));

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
  for (i5 = 0; i5 < 3; i5++) {
    for (i6 = 0; i6 < 3; i6++) {
      G[i6 + 12 * i5] = g11[i6 + 3 * i5];
      G[(i6 + 12 * i5) + 3] = g12[i5 + 3 * i6];
      G[(i6 + 12 * i5) + 6] = -g11[i6 + 3 * i5];
      G[(i6 + 12 * i5) + 9] = g12[i5 + 3 * i6];
      G[i6 + 12 * (3 + i5)] = g12[i6 + 3 * i5];
      G[(i6 + 12 * (3 + i5)) + 3] = b_A[i6 + 3 * i5];
      G[(i6 + 12 * (3 + i5)) + 6] = -g12[i6 + 3 * i5];
      G[(i6 + 12 * (3 + i5)) + 9] = b_A[i6 + 3 * i5];
      G[i6 + 12 * (6 + i5)] = -g11[i6 + 3 * i5];
      G[(i6 + 12 * (6 + i5)) + 3] = -g12[i5 + 3 * i6];
      G[(i6 + 12 * (6 + i5)) + 6] = g11[i6 + 3 * i5];
      G[(i6 + 12 * (6 + i5)) + 9] = -g12[i5 + 3 * i6];
      G[i6 + 12 * (9 + i5)] = g12[i6 + 3 * i5];
      G[(i6 + 12 * (9 + i5)) + 3] = b_A[i6 + 3 * i5];
      G[(i6 + 12 * (9 + i5)) + 6] = -g12[i6 + 3 * i5];
      G[(i6 + 12 * (9 + i5)) + 9] = b_A[i6 + 3 * i5];
    }
  }

  /* set rows 10 to 12 and cols 10 to 12 to g22 */
  /*  G = [g11 g12 -g11 g12 */
  /*      g12' g22 -g12' g22 */
  /*      -g11 -g12 g11 -g12 */
  /*      g12' g22 -g12' g22]; */
}

/* End of code generation (get_G.c) */
