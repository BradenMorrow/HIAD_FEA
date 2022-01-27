/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * interp1.c
 *
 * Code generation for function 'interp1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "interp1.h"
#include "assemble_prebody_mexutil.h"

/* Function Definitions */
void interp1(const real_T varargin_1_data[], const int32_T varargin_1_size[1],
             const real_T varargin_2_data[], const int32_T varargin_2_size[1],
             const real_T varargin_3[2], real_T Vq[2])
{
  int32_T n;
  int32_T nd2;
  real_T y_data[1000];
  int32_T x_size_idx_0;
  real_T x_data[1000];
  int32_T nyrows;
  int32_T nx;
  int32_T k;
  int32_T exitg1;
  real_T minx;
  real_T maxx;
  int32_T mid_i;
  real_T r;
  n = varargin_2_size[0];
  for (nd2 = 0; nd2 < n; nd2++) {
    y_data[nd2] = varargin_2_data[nd2];
  }

  x_size_idx_0 = varargin_1_size[0];
  n = varargin_1_size[0];
  for (nd2 = 0; nd2 < n; nd2++) {
    x_data[nd2] = varargin_1_data[nd2];
  }

  nyrows = varargin_2_size[0];
  nx = varargin_1_size[0];
  k = 1;
  do {
    exitg1 = 0;
    if (k <= nx) {
      if (muDoubleScalarIsNaN(varargin_1_data[k - 1])) {
        exitg1 = 1;
      } else {
        k++;
      }
    } else {
      if (varargin_1_data[1] < varargin_1_data[0]) {
        nd2 = asr_s32(nx, 1U);
        for (n = 1; n <= nd2; n++) {
          minx = x_data[n - 1];
          x_data[n - 1] = x_data[nx - n];
          x_data[nx - n] = minx;
        }

        if ((!(varargin_2_size[0] == 0)) && (varargin_2_size[0] > 1)) {
          n = varargin_2_size[0];
          nd2 = asr_s32(varargin_2_size[0], 1U);
          for (k = 1; k <= nd2; k++) {
            minx = y_data[k - 1];
            y_data[k - 1] = y_data[n - k];
            y_data[n - k] = minx;
          }
        }
      }

      minx = x_data[0];
      maxx = x_data[x_size_idx_0 - 1];
      for (k = 0; k < 2; k++) {
        Vq[k] = 0.0;
        if (muDoubleScalarIsNaN(varargin_3[k])) {
          Vq[k] = rtNaN;
        } else if (varargin_3[k] > maxx) {
          if (nyrows > 1) {
            Vq[k] = y_data[nyrows - 1] + (varargin_3[k] - maxx) / (maxx -
              x_data[x_size_idx_0 - 2]) * (y_data[nyrows - 1] - y_data[nyrows -
              2]);
          }
        } else if (varargin_3[k] < minx) {
          Vq[k] = y_data[0] + (varargin_3[k] - minx) / (x_data[1] - minx) *
            (y_data[1] - y_data[0]);
        } else {
          n = 1;
          nd2 = 2;
          nx = x_size_idx_0;
          while (nx > nd2) {
            mid_i = asr_s32(n, 1U) + asr_s32(nx, 1U);
            if (((n & 1) == 1) && ((nx & 1) == 1)) {
              mid_i++;
            }

            if (varargin_3[k] >= x_data[mid_i - 1]) {
              n = mid_i;
              nd2 = mid_i + 1;
            } else {
              nx = mid_i;
            }
          }

          r = (varargin_3[k] - x_data[n - 1]) / (x_data[n] - x_data[n - 1]);
          if (r == 0.0) {
            Vq[k] = y_data[n - 1];
          } else if (r == 1.0) {
            Vq[k] = y_data[n];
          } else if (y_data[n - 1] == y_data[n]) {
            Vq[k] = y_data[n - 1];
          } else {
            Vq[k] = (1.0 - r) * y_data[n - 1] + r * y_data[n];
          }
        }
      }

      exitg1 = 1;
    }
  } while (exitg1 == 0);
}

/* End of code generation (interp1.c) */
