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
#include "assemble_prebody.h"
#include "histc.h"
#include "interp1.h"
#include "assemble_prebody_emxutil.h"
#include "assemble_prebody_mexutil.h"

/* Function Definitions */
void histc(real_T X, const emxArray_real_T *edges, emxArray_real_T *N, real_T
           *BIN)
{
  int32_T outsize_idx_1;
  int32_T low_ip1;
  int32_T high_i;
  int32_T mid_i;
  outsize_idx_1 = edges->size[1];
  low_ip1 = N->size[0] * N->size[1];
  N->size[0] = 1;
  N->size[1] = outsize_idx_1;
  emxEnsureCapacity((emxArray__common *)N, low_ip1, (int32_T)sizeof(real_T));
  for (low_ip1 = 0; low_ip1 < outsize_idx_1; low_ip1++) {
    N->data[low_ip1] = 0.0;
  }

  outsize_idx_1 = 0;
  if (!muDoubleScalarIsNaN(X)) {
    if ((X >= edges->data[0]) && (X < edges->data[edges->size[1] - 1])) {
      outsize_idx_1 = 1;
      low_ip1 = 2;
      high_i = edges->size[1];
      while (high_i > low_ip1) {
        mid_i = asr_s32(outsize_idx_1, 1U) + asr_s32(high_i, 1U);
        if (((outsize_idx_1 & 1) == 1) && ((high_i & 1) == 1)) {
          mid_i++;
        }

        if (X >= edges->data[mid_i - 1]) {
          outsize_idx_1 = mid_i;
          low_ip1 = mid_i + 1;
        } else {
          high_i = mid_i;
        }
      }
    }

    if (X == edges->data[edges->size[1] - 1]) {
      outsize_idx_1 = edges->size[1];
    }
  }

  if (outsize_idx_1 > 0) {
    N->data[outsize_idx_1 - 1] = 1.0;
  }

  *BIN = outsize_idx_1;
}

/* End of code generation (histc.c) */
