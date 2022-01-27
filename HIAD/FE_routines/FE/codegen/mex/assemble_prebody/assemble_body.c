/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_body.c
 *
 * Code generation for function 'assemble_body'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "assemble_body.h"
#include "assemble_prebody_emxutil.h"
#include "el3.h"
#include "ppval_fast.h"
#include "el4.h"
#include "interp1.h"
#include "el2.h"
#include "el1.h"
#include "k1.h"
#include "T_beam_3d.h"
#include "sum.h"
#include "power.h"
#include "assemble_prebody_mexutil.h"

/* Function Definitions */
void assemble_body(emlrtCTX aTLS, const real_T con[2], const char_T EL_el_data[],
                   const int32_T EL_el_size[2], const real_T EL_el_in_nodes_ij[6],
                   const real_T EL_el_in_orient_ij[3], const b_struct_T
                   *EL_el_in0, const real_T U_input[48], b_struct_T *el_out,
                   real_T fint_ii[12], real_T Fint_ii[12], emxArray_real_T
                   *el_dof, real_T Kel_out[144], emxArray_real_T *dof_i,
                   emxArray_real_T *dof_j, real_T ROT_out[12], real_T
                   *break_iter)
{
  real_T U_in_U0[12];
  real_T U_in_U[12];
  real_T U_in_delta_U[12];
  real_T U_in_DELTA_U[12];
  int32_T itilerow;
  real_T anew;
  real_T d;
  int32_T outsize_idx_1;
  real_T apnd;
  real_T ndbl;
  real_T cdiff;
  real_T absa;
  real_T absb;
  emxArray_real_T *el_dof1;
  int32_T nm1d2;
  int32_T k;
  emxArray_real_T *el_dof2;
  uint32_T sz1[2];
  uint32_T ysize[2];
  emxArray_real_T *y;
  emxArray_real_T *el_dof_temp;
  boolean_T b_bool;
  int32_T exitg4;
  static const char_T cv0[10] = { 'e', 'l', '1', '_', 'n', 'o', 'n', 'l', 'i',
    'n' };

  int32_T exitg3;
  static const char_T cv1[3] = { 'e', 'l', '1' };

  int32_T exitg2;
  static const char_T cv2[3] = { 'e', 'l', '2' };

  int32_T exitg1;
  static const char_T cv3[3] = { 'e', 'l', '3' };

  real_T b_EL_el_in_nodes_ij[3];
  real_T dv0[3];
  real_T L0;
  real_T T[144];
  real_T b_U_in_U[12];
  real_T u[12];
  real_T eps;
  real_T f;
  real_T EAax;
  real_T geom[5];
  real_T b_k[144];
  real_T Kel_out_fun[144];
  char_T TRANSB;
  char_T TRANSA;
  real_T b_y[144];
  ptrdiff_t m_t;
  ptrdiff_t n_t;
  ptrdiff_t k_t;
  ptrdiff_t lda_t;
  ptrdiff_t ldb_t;
  ptrdiff_t ldc_t;
  real_T ROT_rot[6];
  real_T ROT_DELTA_rot[6];
  emxArray_real_T *temp2;
  emlrtHeapReferenceStackEnterFcnR2012b(aTLS);

  /* The loop body for the assemble function */
  /*    Calls element functions and assembles element K matrices. */
  /*    Sets the nodal dof locations to assemble global K matrix. */
  /*    Prepares the internal force vector to be assembled. */
  /*    Desgined for 2 node elements with 6 dof per node. */
  /*  Element nodal displacements */
  for (itilerow = 0; itilerow < 6; itilerow++) {
    U_in_U0[itilerow << 1] = U_input[itilerow];
    U_in_U0[1 + (itilerow << 1)] = U_input[6 + itilerow];
    U_in_U[itilerow << 1] = U_input[12 + itilerow];
    U_in_U[1 + (itilerow << 1)] = U_input[itilerow + 18];
    U_in_delta_U[itilerow << 1] = U_input[24 + itilerow];
    U_in_delta_U[1 + (itilerow << 1)] = U_input[itilerow + 30];
    U_in_DELTA_U[itilerow << 1] = U_input[36 + itilerow];
    U_in_DELTA_U[1 + (itilerow << 1)] = U_input[itilerow + 42];
  }

  /*  Prepare internal force vector (where the internal force vector will be added to) */
  anew = con[0] * 6.0 - 5.0;
  d = con[0] * 6.0;
  if (muDoubleScalarIsNaN(anew) || muDoubleScalarIsNaN(d)) {
    outsize_idx_1 = 1;
    anew = rtNaN;
    apnd = d;
  } else if (d < anew) {
    outsize_idx_1 = 0;
    apnd = d;
  } else if (muDoubleScalarIsInf(anew) || muDoubleScalarIsInf(d)) {
    outsize_idx_1 = 1;
    anew = rtNaN;
    apnd = d;
  } else {
    ndbl = muDoubleScalarFloor((d - anew) + 0.5);
    apnd = anew + ndbl;
    cdiff = apnd - d;
    absa = muDoubleScalarAbs(anew);
    absb = muDoubleScalarAbs(d);
    if (muDoubleScalarAbs(cdiff) < 4.4408920985006262E-16 * muDoubleScalarMax
        (absa, absb)) {
      ndbl++;
      apnd = d;
    } else if (cdiff > 0.0) {
      apnd = anew + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      outsize_idx_1 = (int32_T)ndbl;
    } else {
      outsize_idx_1 = 0;
    }
  }

  emxInit_real_T(aTLS, &el_dof1, 2, true);
  itilerow = el_dof1->size[0] * el_dof1->size[1];
  el_dof1->size[0] = 1;
  el_dof1->size[1] = outsize_idx_1;
  emxEnsureCapacity((emxArray__common *)el_dof1, itilerow, (int32_T)sizeof
                    (real_T));
  if (outsize_idx_1 > 0) {
    el_dof1->data[0] = anew;
    if (outsize_idx_1 > 1) {
      el_dof1->data[outsize_idx_1 - 1] = apnd;
      itilerow = outsize_idx_1 - 1;
      nm1d2 = asr_s32(itilerow, 1U);
      for (k = 1; k < nm1d2; k++) {
        el_dof1->data[k] = anew + (real_T)k;
        el_dof1->data[(outsize_idx_1 - k) - 1] = apnd - (real_T)k;
      }

      if (nm1d2 << 1 == outsize_idx_1 - 1) {
        el_dof1->data[nm1d2] = (anew + apnd) / 2.0;
      } else {
        el_dof1->data[nm1d2] = anew + (real_T)nm1d2;
        el_dof1->data[nm1d2 + 1] = apnd - (real_T)nm1d2;
      }
    }
  }

  anew = con[1] * 6.0 - 5.0;
  d = con[1] * 6.0;
  if (muDoubleScalarIsNaN(anew) || muDoubleScalarIsNaN(d)) {
    outsize_idx_1 = 1;
    anew = rtNaN;
    apnd = d;
  } else if (d < anew) {
    outsize_idx_1 = 0;
    apnd = d;
  } else if (muDoubleScalarIsInf(anew) || muDoubleScalarIsInf(d)) {
    outsize_idx_1 = 1;
    anew = rtNaN;
    apnd = d;
  } else {
    ndbl = muDoubleScalarFloor((d - anew) + 0.5);
    apnd = anew + ndbl;
    cdiff = apnd - d;
    absa = muDoubleScalarAbs(anew);
    absb = muDoubleScalarAbs(d);
    if (muDoubleScalarAbs(cdiff) < 4.4408920985006262E-16 * muDoubleScalarMax
        (absa, absb)) {
      ndbl++;
      apnd = d;
    } else if (cdiff > 0.0) {
      apnd = anew + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      outsize_idx_1 = (int32_T)ndbl;
    } else {
      outsize_idx_1 = 0;
    }
  }

  emxInit_real_T(aTLS, &el_dof2, 2, true);
  itilerow = el_dof2->size[0] * el_dof2->size[1];
  el_dof2->size[0] = 1;
  el_dof2->size[1] = outsize_idx_1;
  emxEnsureCapacity((emxArray__common *)el_dof2, itilerow, (int32_T)sizeof
                    (real_T));
  if (outsize_idx_1 > 0) {
    el_dof2->data[0] = anew;
    if (outsize_idx_1 > 1) {
      el_dof2->data[outsize_idx_1 - 1] = apnd;
      itilerow = outsize_idx_1 - 1;
      nm1d2 = asr_s32(itilerow, 1U);
      for (k = 1; k < nm1d2; k++) {
        el_dof2->data[k] = anew + (real_T)k;
        el_dof2->data[(outsize_idx_1 - k) - 1] = apnd - (real_T)k;
      }

      if (nm1d2 << 1 == outsize_idx_1 - 1) {
        el_dof2->data[nm1d2] = (anew + apnd) / 2.0;
      } else {
        el_dof2->data[nm1d2] = anew + (real_T)nm1d2;
        el_dof2->data[nm1d2 + 1] = apnd - (real_T)nm1d2;
      }
    }
  }

  for (itilerow = 0; itilerow < 2; itilerow++) {
    sz1[itilerow] = (uint32_T)el_dof1->size[itilerow];
  }

  for (outsize_idx_1 = 0; outsize_idx_1 < 2; outsize_idx_1++) {
    ysize[outsize_idx_1] = sz1[outsize_idx_1];
  }

  emxInit_real_T(aTLS, &y, 2, true);
  ysize[1] += el_dof2->size[1];
  itilerow = y->size[0] * y->size[1];
  y->size[0] = (int32_T)ysize[0];
  y->size[1] = (int32_T)ysize[1];
  emxEnsureCapacity((emxArray__common *)y, itilerow, (int32_T)sizeof(real_T));
  nm1d2 = -1;
  for (outsize_idx_1 = 1; outsize_idx_1 <= el_dof1->size[1]; outsize_idx_1++) {
    nm1d2++;
    y->data[nm1d2] = el_dof1->data[outsize_idx_1 - 1];
  }

  for (outsize_idx_1 = 1; outsize_idx_1 <= el_dof2->size[1]; outsize_idx_1++) {
    nm1d2++;
    y->data[nm1d2] = el_dof2->data[outsize_idx_1 - 1];
  }

  emxFree_real_T(&el_dof2);
  emxInit_real_T(aTLS, &el_dof_temp, 2, true);
  itilerow = el_dof_temp->size[0] * el_dof_temp->size[1];
  el_dof_temp->size[0] = y->size[1];
  el_dof_temp->size[1] = y->size[0];
  emxEnsureCapacity((emxArray__common *)el_dof_temp, itilerow, (int32_T)sizeof
                    (real_T));
  outsize_idx_1 = y->size[0];
  for (itilerow = 0; itilerow < outsize_idx_1; itilerow++) {
    k = y->size[1];
    for (nm1d2 = 0; nm1d2 < k; nm1d2++) {
      el_dof_temp->data[nm1d2 + el_dof_temp->size[0] * itilerow] = y->
        data[itilerow + y->size[0] * nm1d2];
    }
  }

  emxFree_real_T(&y);
  itilerow = el_dof->size[0];
  el_dof->size[0] = el_dof_temp->size[0] * el_dof_temp->size[1];
  emxEnsureCapacity((emxArray__common *)el_dof, itilerow, (int32_T)sizeof(real_T));
  outsize_idx_1 = el_dof_temp->size[0] * el_dof_temp->size[1];
  for (itilerow = 0; itilerow < outsize_idx_1; itilerow++) {
    el_dof->data[itilerow] = el_dof_temp->data[itilerow];
  }

  b_bool = false;
  if (EL_el_size[1] != 10) {
  } else {
    outsize_idx_1 = 0;
    do {
      exitg4 = 0;
      if (outsize_idx_1 + 1 < 11) {
        if (EL_el_data[outsize_idx_1] != cv0[outsize_idx_1]) {
          exitg4 = 1;
        } else {
          outsize_idx_1++;
        }
      } else {
        b_bool = true;
        exitg4 = 1;
      }
    } while (exitg4 == 0);
  }

  if (b_bool) {
    outsize_idx_1 = 0;
  } else {
    b_bool = false;
    if (EL_el_size[1] != 3) {
    } else {
      outsize_idx_1 = 0;
      do {
        exitg3 = 0;
        if (outsize_idx_1 + 1 < 4) {
          if (EL_el_data[outsize_idx_1] != cv1[outsize_idx_1]) {
            exitg3 = 1;
          } else {
            outsize_idx_1++;
          }
        } else {
          b_bool = true;
          exitg3 = 1;
        }
      } while (exitg3 == 0);
    }

    if (b_bool) {
      outsize_idx_1 = 1;
    } else {
      b_bool = false;
      if (EL_el_size[1] != 3) {
      } else {
        outsize_idx_1 = 0;
        do {
          exitg2 = 0;
          if (outsize_idx_1 + 1 < 4) {
            if (EL_el_data[outsize_idx_1] != cv2[outsize_idx_1]) {
              exitg2 = 1;
            } else {
              outsize_idx_1++;
            }
          } else {
            b_bool = true;
            exitg2 = 1;
          }
        } while (exitg2 == 0);
      }

      if (b_bool) {
        outsize_idx_1 = 2;
      } else {
        b_bool = false;
        if (EL_el_size[1] != 3) {
        } else {
          outsize_idx_1 = 0;
          do {
            exitg1 = 0;
            if (outsize_idx_1 + 1 < 4) {
              if (EL_el_data[outsize_idx_1] != cv3[outsize_idx_1]) {
                exitg1 = 1;
              } else {
                outsize_idx_1++;
              }
            } else {
              b_bool = true;
              exitg1 = 1;
            }
          } while (exitg1 == 0);
        }

        if (b_bool) {
          outsize_idx_1 = 3;
        } else {
          outsize_idx_1 = -1;
        }
      }
    }
  }

  switch (outsize_idx_1) {
   case 0:
    /* EL1 */
    /*    Axial lookup, 3D beam element */
    /*  Extract variables */
    /*  Geometry */
    /*  Materials */
    for (itilerow = 0; itilerow < 3; itilerow++) {
      b_EL_el_in_nodes_ij[itilerow] = EL_el_in_nodes_ij[1 + (itilerow << 1)] -
        EL_el_in_nodes_ij[itilerow << 1];
    }

    power(b_EL_el_in_nodes_ij, dv0);
    L0 = muDoubleScalarSqrt(b_sum(dv0));

    /*  Obtain displacements of interest */
    /*  Transformation matrix */
    T_beam_3d(EL_el_in_nodes_ij, EL_el_in_orient_ij, T);

    /*  Local element displacements */
    for (itilerow = 0; itilerow < 2; itilerow++) {
      for (nm1d2 = 0; nm1d2 < 6; nm1d2++) {
        b_U_in_U[nm1d2 + 6 * itilerow] = U_in_U[itilerow + (nm1d2 << 1)];
      }
    }

    for (itilerow = 0; itilerow < 12; itilerow++) {
      u[itilerow] = 0.0;
      for (nm1d2 = 0; nm1d2 < 12; nm1d2++) {
        u[itilerow] += T[itilerow + 12 * nm1d2] * b_U_in_U[nm1d2];
      }
    }

    /*  Axial strain */
    eps = (u[6] - u[0]) / L0;

    /*  Nonlinear axial response geometry */
    f = ppval_fast(aTLS, EL_el_in0->axial.breaks.data, EL_el_in0->axial.coefs,
                   EL_el_in0->axial.pieces, EL_el_in0->axial.order, eps);

    /*  Interpolate for force %  */
    EAax = b_ppval_fast(aTLS, EL_el_in0->axial_k.breaks,
                        EL_el_in0->axial_k.coefs, EL_el_in0->axial_k.pieces,
                        EL_el_in0->axial_k.order, eps);

    /*  Stiffness is derivative of force-stain relationship */
    for (itilerow = 0; itilerow < 5; itilerow++) {
      geom[itilerow] = EL_el_in0->geom[itilerow];
    }

    geom[0] = EAax / EL_el_in0->mat[0];

    /*  Vary cross sectional area */
    /*  Local element stiffness matrix */
    k1(EL_el_in0->mat, geom, L0, b_k);

    /*  Element stiffness matrix */
    for (itilerow = 0; itilerow < 12; itilerow++) {
      for (nm1d2 = 0; nm1d2 < 12; nm1d2++) {
        Kel_out_fun[nm1d2 + 12 * itilerow] = T[itilerow + 12 * nm1d2];
      }
    }

    d = 1.0;
    anew = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    memset(&b_y[0], 0, 144U * sizeof(real_T));
    m_t = (ptrdiff_t)12;
    n_t = (ptrdiff_t)12;
    k_t = (ptrdiff_t)12;
    lda_t = (ptrdiff_t)12;
    ldb_t = (ptrdiff_t)12;
    ldc_t = (ptrdiff_t)12;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &d, &Kel_out_fun[0], &lda_t, &b_k
          [0], &ldb_t, &anew, &b_y[0], &ldc_t);
    d = 1.0;
    anew = 0.0;
    TRANSB = 'N';
    TRANSA = 'N';
    memset(&Kel_out_fun[0], 0, 144U * sizeof(real_T));
    m_t = (ptrdiff_t)12;
    n_t = (ptrdiff_t)12;
    k_t = (ptrdiff_t)12;
    lda_t = (ptrdiff_t)12;
    ldb_t = (ptrdiff_t)12;
    ldc_t = (ptrdiff_t)12;
    dgemm(&TRANSA, &TRANSB, &m_t, &n_t, &k_t, &d, &b_y[0], &lda_t, &T[0], &ldb_t,
          &anew, &Kel_out_fun[0], &ldc_t);

    /*  Element internal forces */
    for (itilerow = 0; itilerow < 12; itilerow++) {
      fint_ii[itilerow] = 0.0;
      for (nm1d2 = 0; nm1d2 < 12; nm1d2++) {
        fint_ii[itilerow] += b_k[itilerow + 12 * nm1d2] * u[nm1d2];
      }
    }

    /*  Local */
    fint_ii[0] = -f;
    fint_ii[6] = f;

    /*  Global */
    /*  Extract rotations */
    /*  Total rotation */
    /*  Initialize ROT.DELTA_rot */
    for (itilerow = 0; itilerow < 3; itilerow++) {
      for (nm1d2 = 0; nm1d2 < 2; nm1d2++) {
        ROT_rot[nm1d2 + (itilerow << 1)] = U_in_U[nm1d2 + ((3 + itilerow) << 1)]
          + U_in_delta_U[nm1d2 + ((3 + itilerow) << 1)];
        ROT_DELTA_rot[nm1d2 + (itilerow << 1)] = ROT_rot[nm1d2 + (itilerow << 1)]
          - U_in_U0[nm1d2 + ((3 + itilerow) << 1)];
      }
    }

    /*  Increment change in rotation */
    /*  Do not need to save any variables for future iterations */
    emxCopyStruct_struct_T(el_out, EL_el_in0);
    el_out->b_break = 0.0;
    for (itilerow = 0; itilerow < 12; itilerow++) {
      Fint_ii[itilerow] = 0.0;
      for (nm1d2 = 0; nm1d2 < 12; nm1d2++) {
        Fint_ii[itilerow] += T[nm1d2 + 12 * itilerow] * fint_ii[nm1d2];
      }
    }
    break;

   case 1:
    emxCopyStruct_struct_T(el_out, EL_el_in0);
    el1(U_in_U0, U_in_U, U_in_delta_U, EL_el_in_nodes_ij, EL_el_in_orient_ij,
        el_out, Kel_out_fun, fint_ii, Fint_ii, ROT_rot, ROT_DELTA_rot);
    break;

   case 2:
    emxCopyStruct_struct_T(el_out, EL_el_in0);
    el2(U_in_U, U_in_delta_U, U_in_DELTA_U, EL_el_in_nodes_ij,
        EL_el_in_orient_ij, el_out, Kel_out_fun, fint_ii, Fint_ii, ROT_rot,
        ROT_DELTA_rot);
    break;

   case 3:
    emxCopyStruct_struct_T(el_out, EL_el_in0);
    el3(aTLS, U_in_U, U_in_delta_U, U_in_DELTA_U, EL_el_in_nodes_ij,
        EL_el_in_orient_ij, el_out, Kel_out_fun, fint_ii, Fint_ii, ROT_rot,
        ROT_DELTA_rot);
    break;

   default:
    emxCopyStruct_struct_T(el_out, EL_el_in0);
    el4(aTLS, U_in_U, U_in_delta_U, U_in_DELTA_U, EL_el_in_nodes_ij,
        EL_el_in_orient_ij, el_out, Kel_out_fun, fint_ii, Fint_ii, ROT_rot,
        ROT_DELTA_rot);
    break;
  }

  /*  Store element function outputs */
  for (itilerow = 0; itilerow < 12; itilerow++) {
    ROT_out[itilerow] = 0.0;
  }

  for (itilerow = 0; itilerow < 3; itilerow++) {
    ROT_out[itilerow] = ROT_rot[itilerow << 1];
  }

  for (itilerow = 0; itilerow < 3; itilerow++) {
    ROT_out[3 + itilerow] = ROT_rot[1 + (itilerow << 1)];
  }

  for (itilerow = 0; itilerow < 3; itilerow++) {
    ROT_out[6 + itilerow] = ROT_DELTA_rot[itilerow << 1];
  }

  for (itilerow = 0; itilerow < 3; itilerow++) {
    ROT_out[9 + itilerow] = ROT_DELTA_rot[1 + (itilerow << 1)];
  }

  *break_iter = el_out->b_break;

  /*  Add global element stiffness matrix to system stiffness matrix */
  nm1d2 = el_dof_temp->size[0] * el_dof_temp->size[1];
  itilerow = el_dof1->size[0] * el_dof1->size[1];
  el_dof1->size[0] = 1;
  el_dof1->size[1] = nm1d2;
  emxEnsureCapacity((emxArray__common *)el_dof1, itilerow, (int32_T)sizeof
                    (real_T));
  for (itilerow = 0; itilerow < nm1d2; itilerow++) {
    el_dof1->data[el_dof1->size[0] * itilerow] = el_dof_temp->data[itilerow];
  }

  emxInit_real_T(aTLS, &temp2, 2, true);
  outsize_idx_1 = el_dof1->size[1];
  itilerow = temp2->size[0] * temp2->size[1];
  temp2->size[0] = 12;
  temp2->size[1] = outsize_idx_1;
  emxEnsureCapacity((emxArray__common *)temp2, itilerow, (int32_T)sizeof(real_T));
  if ((!(el_dof1->size[1] == 0)) && (!(outsize_idx_1 == 0))) {
    for (outsize_idx_1 = 0; outsize_idx_1 + 1 <= el_dof1->size[1]; outsize_idx_1
         ++) {
      nm1d2 = outsize_idx_1 * 12;
      for (itilerow = 0; itilerow < 12; itilerow++) {
        temp2->data[nm1d2 + itilerow] = el_dof1->data[outsize_idx_1];
      }
    }
  }

  emxFree_real_T(&el_dof1);
  nm1d2 = el_dof_temp->size[0] * el_dof_temp->size[1];
  outsize_idx_1 = nm1d2 * 12;
  itilerow = dof_i->size[0];
  dof_i->size[0] = outsize_idx_1;
  emxEnsureCapacity((emxArray__common *)dof_i, itilerow, (int32_T)sizeof(real_T));
  nm1d2 = el_dof_temp->size[0] * el_dof_temp->size[1];
  if ((!(nm1d2 == 0)) && (!(outsize_idx_1 == 0))) {
    nm1d2 = el_dof_temp->size[0] * el_dof_temp->size[1];
    for (itilerow = 0; itilerow < 12; itilerow++) {
      outsize_idx_1 = itilerow * nm1d2;
      for (k = 0; k + 1 <= nm1d2; k++) {
        dof_i->data[outsize_idx_1 + k] = el_dof_temp->data[k];
      }
    }
  }

  emxFree_real_T(&el_dof_temp);
  itilerow = dof_j->size[0];
  dof_j->size[0] = 12 * temp2->size[1];
  emxEnsureCapacity((emxArray__common *)dof_j, itilerow, (int32_T)sizeof(real_T));
  outsize_idx_1 = 12 * temp2->size[1];
  for (itilerow = 0; itilerow < outsize_idx_1; itilerow++) {
    dof_j->data[itilerow] = temp2->data[itilerow];
  }

  emxFree_real_T(&temp2);
  for (itilerow = 0; itilerow < 144; itilerow++) {
    Kel_out[itilerow] = Kel_out_fun[itilerow];
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(aTLS);
}

/* End of code generation (assemble_body.c) */
