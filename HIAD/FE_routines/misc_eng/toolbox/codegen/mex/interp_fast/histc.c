/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * histc.c
 *
 * Code generation for function 'histc'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "interp_fast.h"
#include "histc.h"
#include "interp_fast_emxutil.h"

/* Function Declarations */
static int32_T asr_s32(int32_T u, uint32_T n);

/* Function Definitions */
static int32_T asr_s32(int32_T u, uint32_T n)
{
  int32_T y;
  if (u >= 0) {
    y = (int32_T)((uint32_T)u >> n);
  } else {
    y = -(int32_T)((uint32_T)-(u + 1) >> n) - 1;
  }

  return y;
}

void histc(real_T X, const emxArray_real_T *edges, emxArray_real_T *N, real_T
           *BIN)
{
  int16_T outsize_idx_1;
  int32_T low_i;
  int32_T low_ip1;
  int32_T high_i;
  int32_T mid_i;
  outsize_idx_1 = (int16_T)edges->size[0];
  low_i = N->size[0] * N->size[1];
  N->size[0] = 1;
  N->size[1] = outsize_idx_1;
  emxEnsureCapacity((emxArray__common *)N, low_i, (int32_T)sizeof(real_T));
  low_ip1 = outsize_idx_1;
  for (low_i = 0; low_i < low_ip1; low_i++) {
    N->data[low_i] = 0.0;
  }

  low_i = 0;
  if ((!(edges->size[0] == 0)) && (!muDoubleScalarIsNaN(X))) {
    if ((X >= edges->data[0]) && (X < edges->data[edges->size[0] - 1])) {
      low_i = 1;
      low_ip1 = 2;
      high_i = edges->size[0];
      while (high_i > low_ip1) {
        mid_i = asr_s32(low_i, 1U) + asr_s32(high_i, 1U);
        if (((low_i & 1) == 1) && ((high_i & 1) == 1)) {
          mid_i++;
        }

        if (X >= edges->data[mid_i - 1]) {
          low_i = mid_i;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
    }

    if (X == edges->data[edges->size[0] - 1]) {
      low_i = edges->size[0];
    }
  }

  if (low_i > 0) {
    N->data[low_i - 1] = 1.0;
  }

  *BIN = low_i;
}

/* End of code generation (histc.c) */
