/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_prebody.c
 *
 * Code generation for function 'assemble_prebody'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "assemble_body.h"
#include "assemble_prebody_emxutil.h"

/* Function Definitions */
void assemble_prebody(emlrtCTX aTLS, const real_T con_data[], const int32_T
                      con_size[2], emxArray_struct0_T *EL, const emxArray_real_T
                      *U_input, boolean_T par, emxArray_real_T *fint_i,
                      emxArray_real_T *Fint_i, emxArray_real_T *dof_Fint,
                      emxArray_real_T *Kel, emxArray_real_T *dof_i,
                      emxArray_real_T *dof_j, emxArray_real_T *ROT, real_T
                      break_iter_data[], int32_T break_iter_size[1])
{
  int32_T i26;
  int32_T i;
  int32_T c_t3_el_in0_axial_breaks_size_i;
  int32_T b_i;
  b_struct_T expl_temp;
  emxArray_real_T *t4_el_in0_flex_Du;
  emxArray_real_T *t4_el_in0_flex_D;
  emxArray_struct5_T *t4_el_in0_nodes;
  emxArray_real_T *t4_el_in0_axial_k_coefs;
  emxArray_real_T *t4_el_in0_axial_k_breaks;
  emxArray_real_T *t4_el_in0_axial_coefs;
  b_struct_T r2;
  emxArray_real_T *r3;
  emxArray_real_T *r4;
  emxArray_real_T *r5;
  real_T d1;
  real_T dv24[12];
  real_T dv25[144];
  real_T dv26[12];
  real_T dv27[12];
  int32_T t4_el_size[2];
  int32_T c_i;
  int32_T i27;
  char_T t4_el_data[20];
  real_T t4_el_in_nodes_ij[6];
  real_T t4_el_in_orient_ij[3];
  real_T t4_el_in0_break;
  real_T t4_el_in0_mat[2];
  real_T t4_el_in0_geom[5];
  char_T t4_el_in0_axial_form[2];
  int32_T c_t4_el_in0_axial_breaks_size_i;
  real_T t4_el_in0_axial_breaks_data[500];
  real_T t4_el_in0_axial_pieces;
  real_T t4_el_in0_axial_order;
  real_T t4_el_in0_axial_dim;
  char_T t4_el_in0_axial_k_form[2];
  real_T t4_el_in0_axial_k_pieces;
  real_T t4_el_in0_axial_k_order;
  real_T t4_el_in0_axial_k_dim;
  real_T t4_el_in0_eps0;
  real_T t4_el_in0_K0[36];
  real_T t4_el_in0_p;
  real_T t4_el_in0_r;
  int32_T t4_el_in0_alpha_size_idx_0;
  int32_T t4_el_in0_alpha_size_idx_1;
  real_T t4_el_in0_alpha_data[100];
  real_T t4_el_in0_beta;
  int32_T t4_el_in0_eps_size_idx_0;
  real_T t4_el_in0_eps_data[10];
  int32_T t4_el_in0_f_size_idx_0;
  real_T t4_el_in0_f_data[10];
  real_T t4_el_in0_propsLH[5];
  real_T t4_el_in0_D0[6];
  real_T t4_el_in0_P0[6];
  real_T t4_el_in0_n;
  real_T t4_el_in0_flex_break;
  real_T t4_el_in0_flex_K[25];
  real_T t4_el_in0_flex_Q[5];
  int32_T t4_el_in0_flex_f_size_idx_2;
  real_T t4_el_in0_flex_f_data[500];
  int32_T t4_el_in0_flex_d_size_idx_1;
  real_T t4_el_in0_flex_d_data[100];
  int32_T t4_el_in0_flex_e_size_idx_0;
  int32_T t4_el_in0_flex_e_size_idx_1;
  real_T t4_el_in0_flex_e_data[400];
  boolean_T t4_el_in0_state_it;
  real_T t4_el_in0_el;
  real_T b_U_input[48];
  int32_T d_i;
  emxArray_real_T *t2_axial_coefs;
  emxArray_real_T *t2_axial_k_breaks;
  emxArray_real_T *t2_axial_k_coefs;
  emxArray_struct5_T *t2_nodes;
  emxArray_real_T *t2_flex_D;
  emxArray_real_T *t2_flex_Du;
  emxArray_real_T *r6;
  emxArray_real_T *r7;
  emxArray_real_T *r8;
  emxArray_real_T *t3_el_in0_axial_coefs;
  emxArray_real_T *t3_el_in0_axial_k_breaks;
  emxArray_real_T *t3_el_in0_axial_k_coefs;
  emxArray_struct5_T *t3_el_in0_nodes;
  emxArray_real_T *t3_el_in0_flex_D;
  emxArray_real_T *t3_el_in0_flex_Du;
  b_struct_T b_expl_temp;
  b_struct_T c_expl_temp;
  int32_T t3_el_size[2];
  int32_T i28;
  char_T t3_el_data[20];
  real_T t3_el_in_nodes_ij[6];
  real_T t3_el_in_orient_ij[3];
  real_T t3_el_in0_break;
  real_T t3_el_in0_mat[2];
  real_T t3_el_in0_geom[5];
  char_T t3_el_in0_axial_form[2];
  real_T t3_el_in0_axial_breaks_data[500];
  real_T t3_el_in0_axial_pieces;
  real_T t3_el_in0_axial_order;
  real_T t3_el_in0_axial_dim;
  char_T t3_el_in0_axial_k_form[2];
  real_T t3_el_in0_axial_k_pieces;
  real_T t3_el_in0_axial_k_order;
  real_T t3_el_in0_axial_k_dim;
  real_T t3_el_in0_eps0;
  real_T t3_el_in0_K0[36];
  real_T t3_el_in0_p;
  real_T t3_el_in0_r;
  int32_T t3_el_in0_alpha_size_idx_0;
  int32_T t3_el_in0_alpha_size_idx_1;
  real_T t3_el_in0_alpha_data[100];
  real_T t3_el_in0_beta;
  int32_T t3_el_in0_eps_size_idx_0;
  real_T t3_el_in0_eps_data[10];
  int32_T t3_el_in0_f_size_idx_0;
  real_T t3_el_in0_f_data[10];
  real_T t3_el_in0_propsLH[5];
  real_T t3_el_in0_D0[6];
  real_T t3_el_in0_P0[6];
  real_T t3_el_in0_n;
  real_T t3_el_in0_flex_break;
  real_T t3_el_in0_flex_K[25];
  real_T t3_el_in0_flex_Q[5];
  int32_T t3_el_in0_flex_f_size_idx_2;
  real_T t3_el_in0_flex_f_data[500];
  int32_T t3_el_in0_flex_d_size_idx_1;
  real_T t3_el_in0_flex_d_data[100];
  int32_T t3_el_in0_flex_e_size_idx_0;
  int32_T t3_el_in0_flex_e_size_idx_1;
  real_T t3_el_in0_flex_e_data[400];
  boolean_T t3_el_in0_state_it;
  real_T t3_el_in0_el;
  real_T c_U_input[48];
  real_T d2;
  real_T dv28[12];
  real_T dv29[144];
  real_T dv30[12];
  real_T dv31[12];
  real_T t2_axial_breaks_data[500];
  real_T t2_K0[36];
  real_T t2_alpha_data[100];
  real_T t2_eps_data[10];
  real_T t2_f_data[10];
  real_T t2_flex_K[25];
  real_T t2_flex_f_data[500];
  real_T t2_flex_d_data[100];
  real_T t2_flex_e_data[400];
  jmp_buf * volatile emlrtJBStack;
  boolean_T emlrtHadParallelError = false;
  jmp_buf emlrtJBEnviron;
  emlrtHeapReferenceStackEnterFcnR2012b(aTLS);

  /*  Preallocate for parfor loop */
  i26 = fint_i->size[0] * fint_i->size[1];
  fint_i->size[0] = 12;
  fint_i->size[1] = EL->size[0];
  emxEnsureCapacity((emxArray__common *)fint_i, i26, (int32_T)sizeof(real_T));
  i = 12 * EL->size[0];
  for (i26 = 0; i26 < i; i26++) {
    fint_i->data[i26] = 0.0;
  }

  i26 = Fint_i->size[0] * Fint_i->size[1];
  Fint_i->size[0] = 12;
  Fint_i->size[1] = EL->size[0];
  emxEnsureCapacity((emxArray__common *)Fint_i, i26, (int32_T)sizeof(real_T));
  i = 12 * EL->size[0];
  for (i26 = 0; i26 < i; i26++) {
    Fint_i->data[i26] = 0.0;
  }

  break_iter_size[0] = EL->size[0];
  i = EL->size[0];
  for (i26 = 0; i26 < i; i26++) {
    break_iter_data[i26] = 0.0;
  }

  i26 = dof_i->size[0] * dof_i->size[1];
  dof_i->size[0] = 144;
  dof_i->size[1] = EL->size[0];
  emxEnsureCapacity((emxArray__common *)dof_i, i26, (int32_T)sizeof(real_T));
  i = 144 * EL->size[0];
  for (i26 = 0; i26 < i; i26++) {
    dof_i->data[i26] = 0.0;
  }

  i26 = dof_j->size[0] * dof_j->size[1];
  dof_j->size[0] = 144;
  dof_j->size[1] = EL->size[0];
  emxEnsureCapacity((emxArray__common *)dof_j, i26, (int32_T)sizeof(real_T));
  i = 144 * EL->size[0];
  for (i26 = 0; i26 < i; i26++) {
    dof_j->data[i26] = 0.0;
  }

  i26 = Kel->size[0] * Kel->size[1];
  Kel->size[0] = 144;
  Kel->size[1] = EL->size[0];
  emxEnsureCapacity((emxArray__common *)Kel, i26, (int32_T)sizeof(real_T));
  i = 144 * EL->size[0];
  for (i26 = 0; i26 < i; i26++) {
    Kel->data[i26] = 0.0;
  }

  i26 = dof_Fint->size[0] * dof_Fint->size[1];
  dof_Fint->size[0] = 12;
  dof_Fint->size[1] = EL->size[0];
  emxEnsureCapacity((emxArray__common *)dof_Fint, i26, (int32_T)sizeof(real_T));
  i = 12 * EL->size[0];
  for (i26 = 0; i26 < i; i26++) {
    dof_Fint->data[i26] = 0.0;
  }

  i26 = ROT->size[0] * ROT->size[1];
  ROT->size[0] = EL->size[0];
  ROT->size[1] = 12;
  emxEnsureCapacity((emxArray__common *)ROT, i26, (int32_T)sizeof(real_T));
  i = EL->size[0] * 12;
  for (i26 = 0; i26 < i; i26++) {
    ROT->data[i26] = 0.0;
  }

  /*  Colums 1:3 = roti, 4:6 = rotj, 7:9 = DELTA_roti, 10:12 = DELTA_rotj */
  if (par) {
    i26 = EL->size[0];
    c_t3_el_in0_axial_breaks_size_i = i26 - 1;
    emlrtEnterParallelRegion(aTLS, omp_in_parallel());
    emlrtPushJmpBuf(aTLS, &emlrtJBStack);

#pragma omp parallel \
 num_threads(emlrtAllocRegionTLSs(aTLS, omp_in_parallel(), omp_get_max_threads(), omp_get_num_procs())) \
 private(expl_temp,t4_el_in0_flex_Du,t4_el_in0_flex_D,t4_el_in0_nodes,t4_el_in0_axial_k_coefs,t4_el_in0_axial_k_breaks,t4_el_in0_axial_coefs,r2,r3,r4,r5,d1,dv24,dv25,dv26,dv27,c_i,i27,t4_el_in0_break,c_t4_el_in0_axial_breaks_size_i,t4_el_in0_axial_pieces,t4_el_in0_axial_order,t4_el_in0_axial_dim,t4_el_in0_axial_k_pieces,t4_el_in0_axial_k_order,t4_el_in0_axial_k_dim,t4_el_in0_eps0,t4_el_in0_p,t4_el_in0_r,t4_el_in0_alpha_size_idx_0,t4_el_in0_alpha_size_idx_1,t4_el_in0_beta,t4_el_in0_eps_size_idx_0,t4_el_in0_f_size_idx_0,t4_el_in0_n,t4_el_in0_flex_break,t4_el_in0_flex_f_size_idx_2,t4_el_in0_flex_d_size_idx_1,t4_el_in0_flex_e_size_idx_0,t4_el_in0_flex_e_size_idx_1,t4_el_in0_state_it,t4_el_in0_el,emlrtJBEnviron) \
 firstprivate(aTLS,t4_el_size,t4_el_data,t4_el_in_nodes_ij,t4_el_in_orient_ij,t4_el_in0_mat,t4_el_in0_geom,t4_el_in0_axial_form,t4_el_in0_axial_breaks_data,t4_el_in0_axial_k_form,t4_el_in0_K0,t4_el_in0_alpha_data,t4_el_in0_eps_data,t4_el_in0_f_data,t4_el_in0_propsLH,t4_el_in0_D0,t4_el_in0_P0,t4_el_in0_flex_K,t4_el_in0_flex_Q,t4_el_in0_flex_f_data,t4_el_in0_flex_d_data,t4_el_in0_flex_e_data,emlrtHadParallelError,b_U_input)

    {
      aTLS = emlrtAllocTLS(aTLS, omp_get_thread_num());
      emlrtSetJmpBuf(aTLS, &emlrtJBEnviron);
      if (setjmp(emlrtJBEnviron) == 0) {
        emxInitStruct_struct_T(aTLS, &expl_temp, true);
        emxInit_real_T(aTLS, &t4_el_in0_flex_Du, 2, true);
        emxInit_real_T(aTLS, &t4_el_in0_flex_D, 2, true);
        emxInit_struct5_T(aTLS, &t4_el_in0_nodes, 2, true);
        emxInit_real_T(aTLS, &t4_el_in0_axial_k_coefs, 2, true);
        emxInit_real_T(aTLS, &t4_el_in0_axial_k_breaks, 2, true);
        emxInit_real_T(aTLS, &t4_el_in0_axial_coefs, 2, true);
        emxInitStruct_struct_T(aTLS, &r2, true);
        emxInit_real_T2(aTLS, &r3, 1, true);
        emxInit_real_T2(aTLS, &r4, 1, true);
        emxInit_real_T2(aTLS, &r5, 1, true);
      } else {
        emlrtHadParallelError = true;
      }

#pragma omp for nowait

      for (b_i = 0; b_i <= c_t3_el_in0_axial_breaks_size_i; b_i++) {
        if (emlrtHadParallelError)
          continue;
        if (setjmp(emlrtJBEnviron) == 0) {
          t4_el_size[0] = 1;
          t4_el_size[1] = EL->data[b_i].el.size[1];
          c_i = EL->data[b_i].el.size[0] * EL->data[b_i].el.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_data[i27] = EL->data[b_i].el.data[i27];
          }

          for (i27 = 0; i27 < 6; i27++) {
            t4_el_in_nodes_ij[i27] = EL->data[b_i].el_in.nodes_ij[i27];
          }

          for (i27 = 0; i27 < 3; i27++) {
            t4_el_in_orient_ij[i27] = EL->data[b_i].el_in.orient_ij[i27];
          }

          t4_el_in0_break = EL->data[b_i].el_in0.b_break;
          for (i27 = 0; i27 < 2; i27++) {
            t4_el_in0_mat[i27] = EL->data[b_i].el_in0.mat[i27];
          }

          for (i27 = 0; i27 < 5; i27++) {
            t4_el_in0_geom[i27] = EL->data[b_i].el_in0.geom[i27];
          }

          for (i27 = 0; i27 < 2; i27++) {
            t4_el_in0_axial_form[i27] = EL->data[b_i].el_in0.axial.form[i27];
          }

          c_t4_el_in0_axial_breaks_size_i = EL->data[b_i].
            el_in0.axial.breaks.size[1];
          c_i = EL->data[b_i].el_in0.axial.breaks.size[0] * EL->data[b_i].
            el_in0.axial.breaks.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_axial_breaks_data[i27] = EL->data[b_i].
              el_in0.axial.breaks.data[i27];
          }

          i27 = t4_el_in0_axial_coefs->size[0] * t4_el_in0_axial_coefs->size[1];
          t4_el_in0_axial_coefs->size[0] = EL->data[b_i]
            .el_in0.axial.coefs->size[0];
          t4_el_in0_axial_coefs->size[1] = EL->data[b_i]
            .el_in0.axial.coefs->size[1];
          emxEnsureCapacity((emxArray__common *)t4_el_in0_axial_coefs, i27,
                            (int32_T)sizeof(real_T));
          c_i = EL->data[b_i].el_in0.axial.coefs->size[0] * EL->data[b_i].
            el_in0.axial.coefs->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_axial_coefs->data[i27] = EL->data[b_i].
              el_in0.axial.coefs->data[i27];
          }

          t4_el_in0_axial_pieces = EL->data[b_i].el_in0.axial.pieces;
          t4_el_in0_axial_order = EL->data[b_i].el_in0.axial.order;
          t4_el_in0_axial_dim = EL->data[b_i].el_in0.axial.dim;
          for (i27 = 0; i27 < 2; i27++) {
            t4_el_in0_axial_k_form[i27] = EL->data[b_i].el_in0.axial_k.form[i27];
          }

          i27 = t4_el_in0_axial_k_breaks->size[0] *
            t4_el_in0_axial_k_breaks->size[1];
          t4_el_in0_axial_k_breaks->size[0] = EL->data[b_i].
            el_in0.axial_k.breaks->size[0];
          t4_el_in0_axial_k_breaks->size[1] = EL->data[b_i].
            el_in0.axial_k.breaks->size[1];
          emxEnsureCapacity((emxArray__common *)t4_el_in0_axial_k_breaks, i27,
                            (int32_T)sizeof(real_T));
          c_i = EL->data[b_i].el_in0.axial_k.breaks->size[0] * EL->data[b_i].
            el_in0.axial_k.breaks->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_axial_k_breaks->data[i27] = EL->data[b_i].
              el_in0.axial_k.breaks->data[i27];
          }

          i27 = t4_el_in0_axial_k_coefs->size[0] * t4_el_in0_axial_k_coefs->
            size[1];
          t4_el_in0_axial_k_coefs->size[0] = EL->data[b_i].
            el_in0.axial_k.coefs->size[0];
          t4_el_in0_axial_k_coefs->size[1] = EL->data[b_i].
            el_in0.axial_k.coefs->size[1];
          emxEnsureCapacity((emxArray__common *)t4_el_in0_axial_k_coefs, i27,
                            (int32_T)sizeof(real_T));
          c_i = EL->data[b_i].el_in0.axial_k.coefs->size[0] * EL->data[b_i].
            el_in0.axial_k.coefs->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_axial_k_coefs->data[i27] = EL->data[b_i].
              el_in0.axial_k.coefs->data[i27];
          }

          t4_el_in0_axial_k_pieces = EL->data[b_i].el_in0.axial_k.pieces;
          t4_el_in0_axial_k_order = EL->data[b_i].el_in0.axial_k.order;
          t4_el_in0_axial_k_dim = EL->data[b_i].el_in0.axial_k.dim;
          t4_el_in0_eps0 = EL->data[b_i].el_in0.eps0;
          for (i27 = 0; i27 < 36; i27++) {
            t4_el_in0_K0[i27] = EL->data[b_i].el_in0.K0[i27];
          }

          t4_el_in0_p = EL->data[b_i].el_in0.p;
          t4_el_in0_r = EL->data[b_i].el_in0.r;
          t4_el_in0_alpha_size_idx_0 = EL->data[b_i].el_in0.alpha.size[0];
          t4_el_in0_alpha_size_idx_1 = EL->data[b_i].el_in0.alpha.size[1];
          c_i = EL->data[b_i].el_in0.alpha.size[0] * EL->data[b_i].
            el_in0.alpha.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_alpha_data[i27] = EL->data[b_i].el_in0.alpha.data[i27];
          }

          t4_el_in0_beta = EL->data[b_i].el_in0.beta;
          t4_el_in0_eps_size_idx_0 = EL->data[b_i].el_in0.eps.size[0];
          c_i = EL->data[b_i].el_in0.eps.size[0] * EL->data[b_i]
            .el_in0.eps.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_eps_data[i27] = EL->data[b_i].el_in0.eps.data[i27];
          }

          t4_el_in0_f_size_idx_0 = EL->data[b_i].el_in0.f.size[0];
          c_i = EL->data[b_i].el_in0.f.size[0] * EL->data[b_i].el_in0.f.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_f_data[i27] = EL->data[b_i].el_in0.f.data[i27];
          }

          i27 = t4_el_in0_nodes->size[0] * t4_el_in0_nodes->size[1];
          t4_el_in0_nodes->size[0] = 1;
          t4_el_in0_nodes->size[1] = EL->data[b_i].el_in0.nodes->size[1];
          emxEnsureCapacity_struct5_T(t4_el_in0_nodes, i27);
          c_i = EL->data[b_i].el_in0.nodes->size[0] * EL->data[b_i].
            el_in0.nodes->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_nodes->data[i27] = EL->data[b_i].el_in0.nodes->data[i27];
          }

          for (i27 = 0; i27 < 5; i27++) {
            t4_el_in0_propsLH[i27] = EL->data[b_i].el_in0.propsLH[i27];
          }

          for (i27 = 0; i27 < 6; i27++) {
            t4_el_in0_D0[i27] = EL->data[b_i].el_in0.D0[i27];
            t4_el_in0_P0[i27] = EL->data[b_i].el_in0.P0[i27];
          }

          t4_el_in0_n = EL->data[b_i].el_in0.n;
          t4_el_in0_flex_break = EL->data[b_i].el_in0.flex.b_break;
          for (i27 = 0; i27 < 25; i27++) {
            t4_el_in0_flex_K[i27] = EL->data[b_i].el_in0.flex.K[i27];
          }

          i27 = t4_el_in0_flex_D->size[0] * t4_el_in0_flex_D->size[1];
          t4_el_in0_flex_D->size[0] = 5;
          t4_el_in0_flex_D->size[1] = EL->data[b_i].el_in0.flex.D.size[1];
          emxEnsureCapacity((emxArray__common *)t4_el_in0_flex_D, i27, (int32_T)
                            sizeof(real_T));
          c_i = EL->data[b_i].el_in0.flex.D.size[0] * EL->data[b_i].
            el_in0.flex.D.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_flex_D->data[i27] = EL->data[b_i].el_in0.flex.D.data[i27];
          }

          i27 = t4_el_in0_flex_Du->size[0] * t4_el_in0_flex_Du->size[1];
          t4_el_in0_flex_Du->size[0] = 5;
          t4_el_in0_flex_Du->size[1] = EL->data[b_i].el_in0.flex.Du.size[1];
          emxEnsureCapacity((emxArray__common *)t4_el_in0_flex_Du, i27, (int32_T)
                            sizeof(real_T));
          c_i = EL->data[b_i].el_in0.flex.Du.size[0] * EL->data[b_i].
            el_in0.flex.Du.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_flex_Du->data[i27] = EL->data[b_i].el_in0.flex.Du.data[i27];
          }

          for (i27 = 0; i27 < 5; i27++) {
            t4_el_in0_flex_Q[i27] = EL->data[b_i].el_in0.flex.Q[i27];
          }

          t4_el_in0_flex_f_size_idx_2 = EL->data[b_i].el_in0.flex.f.size[2];
          c_i = EL->data[b_i].el_in0.flex.f.size[0] * EL->data[b_i].
            el_in0.flex.f.size[1] * EL->data[b_i].el_in0.flex.f.size[2];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_flex_f_data[i27] = EL->data[b_i].el_in0.flex.f.data[i27];
          }

          t4_el_in0_flex_d_size_idx_1 = EL->data[b_i].el_in0.flex.d.size[1];
          c_i = EL->data[b_i].el_in0.flex.d.size[0] * EL->data[b_i].
            el_in0.flex.d.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_flex_d_data[i27] = EL->data[b_i].el_in0.flex.d.data[i27];
          }

          t4_el_in0_flex_e_size_idx_0 = EL->data[b_i].el_in0.flex.e.size[0];
          t4_el_in0_flex_e_size_idx_1 = EL->data[b_i].el_in0.flex.e.size[1];
          c_i = EL->data[b_i].el_in0.flex.e.size[0] * EL->data[b_i].
            el_in0.flex.e.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            t4_el_in0_flex_e_data[i27] = EL->data[b_i].el_in0.flex.e.data[i27];
          }

          t4_el_in0_state_it = EL->data[b_i].el_in0.state_it;
          t4_el_in0_el = EL->data[b_i].el_in0.el;
          expl_temp.el = t4_el_in0_el;
          expl_temp.state_it = t4_el_in0_state_it;
          expl_temp.flex.b_break = t4_el_in0_flex_break;
          memcpy(&expl_temp.flex.K[0], &t4_el_in0_flex_K[0], 25U * sizeof(real_T));
          i27 = expl_temp.flex.D->size[0] * expl_temp.flex.D->size[1];
          expl_temp.flex.D->size[0] = 5;
          expl_temp.flex.D->size[1] = t4_el_in0_flex_D->size[1];
          emxEnsureCapacity((emxArray__common *)expl_temp.flex.D, i27, (int32_T)
                            sizeof(real_T));
          c_i = t4_el_in0_flex_D->size[0] * t4_el_in0_flex_D->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.flex.D->data[i27] = t4_el_in0_flex_D->data[i27];
          }

          i27 = expl_temp.flex.Du->size[0] * expl_temp.flex.Du->size[1];
          expl_temp.flex.Du->size[0] = 5;
          expl_temp.flex.Du->size[1] = t4_el_in0_flex_Du->size[1];
          emxEnsureCapacity((emxArray__common *)expl_temp.flex.Du, i27, (int32_T)
                            sizeof(real_T));
          c_i = t4_el_in0_flex_Du->size[0] * t4_el_in0_flex_Du->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.flex.Du->data[i27] = t4_el_in0_flex_Du->data[i27];
          }

          for (c_i = 0; c_i < 5; c_i++) {
            expl_temp.flex.Q[c_i] = t4_el_in0_flex_Q[c_i];
          }

          expl_temp.flex.f.size[0] = 5;
          expl_temp.flex.f.size[1] = 5;
          expl_temp.flex.f.size[2] = t4_el_in0_flex_f_size_idx_2;
          c_i = 25 * t4_el_in0_flex_f_size_idx_2;
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.flex.f.data[i27] = t4_el_in0_flex_f_data[i27];
          }

          expl_temp.flex.d.size[0] = 5;
          expl_temp.flex.d.size[1] = t4_el_in0_flex_d_size_idx_1;
          c_i = 5 * t4_el_in0_flex_d_size_idx_1;
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.flex.d.data[i27] = t4_el_in0_flex_d_data[i27];
          }

          expl_temp.flex.e.size[0] = t4_el_in0_flex_e_size_idx_0;
          expl_temp.flex.e.size[1] = t4_el_in0_flex_e_size_idx_1;
          c_i = t4_el_in0_flex_e_size_idx_0 * t4_el_in0_flex_e_size_idx_1;
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.flex.e.data[i27] = t4_el_in0_flex_e_data[i27];
          }

          expl_temp.n = t4_el_in0_n;
          for (c_i = 0; c_i < 6; c_i++) {
            expl_temp.P0[c_i] = t4_el_in0_P0[c_i];
          }

          for (c_i = 0; c_i < 6; c_i++) {
            expl_temp.D0[c_i] = t4_el_in0_D0[c_i];
          }

          for (c_i = 0; c_i < 5; c_i++) {
            expl_temp.propsLH[c_i] = t4_el_in0_propsLH[c_i];
          }

          i27 = expl_temp.nodes->size[0] * expl_temp.nodes->size[1];
          expl_temp.nodes->size[0] = 1;
          expl_temp.nodes->size[1] = t4_el_in0_nodes->size[1];
          emxEnsureCapacity_struct5_T(expl_temp.nodes, i27);
          c_i = t4_el_in0_nodes->size[0] * t4_el_in0_nodes->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.nodes->data[i27] = t4_el_in0_nodes->data[i27];
          }

          expl_temp.f.size[0] = t4_el_in0_f_size_idx_0;
          expl_temp.f.size[1] = 2;
          c_i = t4_el_in0_f_size_idx_0 << 1;
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.f.data[i27] = t4_el_in0_f_data[i27];
          }

          expl_temp.eps.size[0] = t4_el_in0_eps_size_idx_0;
          expl_temp.eps.size[1] = 2;
          c_i = t4_el_in0_eps_size_idx_0 << 1;
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.eps.data[i27] = t4_el_in0_eps_data[i27];
          }

          expl_temp.beta = t4_el_in0_beta;
          expl_temp.alpha.size[0] = t4_el_in0_alpha_size_idx_0;
          expl_temp.alpha.size[1] = t4_el_in0_alpha_size_idx_1;
          c_i = t4_el_in0_alpha_size_idx_0 * t4_el_in0_alpha_size_idx_1;
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.alpha.data[i27] = t4_el_in0_alpha_data[i27];
          }

          expl_temp.r = t4_el_in0_r;
          expl_temp.p = t4_el_in0_p;
          memcpy(&expl_temp.K0[0], &t4_el_in0_K0[0], 36U * sizeof(real_T));
          expl_temp.eps0 = t4_el_in0_eps0;
          for (i27 = 0; i27 < 2; i27++) {
            expl_temp.axial_k.form[i27] = t4_el_in0_axial_k_form[i27];
          }

          i27 = expl_temp.axial_k.breaks->size[0] *
            expl_temp.axial_k.breaks->size[1];
          expl_temp.axial_k.breaks->size[0] = t4_el_in0_axial_k_breaks->size[0];
          expl_temp.axial_k.breaks->size[1] = t4_el_in0_axial_k_breaks->size[1];
          emxEnsureCapacity((emxArray__common *)expl_temp.axial_k.breaks, i27,
                            (int32_T)sizeof(real_T));
          c_i = t4_el_in0_axial_k_breaks->size[0] *
            t4_el_in0_axial_k_breaks->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.axial_k.breaks->data[i27] = t4_el_in0_axial_k_breaks->
              data[i27];
          }

          i27 = expl_temp.axial_k.coefs->size[0] * expl_temp.axial_k.coefs->
            size[1];
          expl_temp.axial_k.coefs->size[0] = t4_el_in0_axial_k_coefs->size[0];
          expl_temp.axial_k.coefs->size[1] = t4_el_in0_axial_k_coefs->size[1];
          emxEnsureCapacity((emxArray__common *)expl_temp.axial_k.coefs, i27,
                            (int32_T)sizeof(real_T));
          c_i = t4_el_in0_axial_k_coefs->size[0] * t4_el_in0_axial_k_coefs->
            size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.axial_k.coefs->data[i27] = t4_el_in0_axial_k_coefs->
              data[i27];
          }

          expl_temp.axial_k.pieces = t4_el_in0_axial_k_pieces;
          expl_temp.axial_k.order = t4_el_in0_axial_k_order;
          expl_temp.axial_k.dim = t4_el_in0_axial_k_dim;
          for (i27 = 0; i27 < 2; i27++) {
            expl_temp.axial.form[i27] = t4_el_in0_axial_form[i27];
          }

          expl_temp.axial.breaks.size[0] = 1;
          expl_temp.axial.breaks.size[1] = c_t4_el_in0_axial_breaks_size_i;
          for (i27 = 0; i27 < c_t4_el_in0_axial_breaks_size_i; i27++) {
            expl_temp.axial.breaks.data[i27] = t4_el_in0_axial_breaks_data[i27];
          }

          i27 = expl_temp.axial.coefs->size[0] * expl_temp.axial.coefs->size[1];
          expl_temp.axial.coefs->size[0] = t4_el_in0_axial_coefs->size[0];
          expl_temp.axial.coefs->size[1] = t4_el_in0_axial_coefs->size[1];
          emxEnsureCapacity((emxArray__common *)expl_temp.axial.coefs, i27,
                            (int32_T)sizeof(real_T));
          c_i = t4_el_in0_axial_coefs->size[0] * t4_el_in0_axial_coefs->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            expl_temp.axial.coefs->data[i27] = t4_el_in0_axial_coefs->data[i27];
          }

          expl_temp.axial.pieces = t4_el_in0_axial_pieces;
          expl_temp.axial.order = t4_el_in0_axial_order;
          expl_temp.axial.dim = t4_el_in0_axial_dim;
          for (i27 = 0; i27 < 5; i27++) {
            expl_temp.geom[i27] = t4_el_in0_geom[i27];
          }

          for (i27 = 0; i27 < 2; i27++) {
            expl_temp.mat[i27] = t4_el_in0_mat[i27];
          }

          expl_temp.b_break = t4_el_in0_break;
          for (i27 = 0; i27 < 2; i27++) {
            t4_el_in0_mat[i27] = con_data[b_i + con_size[0] * i27];
          }

          for (i27 = 0; i27 < 4; i27++) {
            for (c_i = 0; c_i < 12; c_i++) {
              b_U_input[c_i + 12 * i27] = U_input->data[(b_i + U_input->size[0] *
                c_i) + U_input->size[0] * U_input->size[1] * i27];
            }
          }

          assemble_body(aTLS, t4_el_in0_mat, t4_el_data, t4_el_size,
                        t4_el_in_nodes_ij, t4_el_in_orient_ij, &expl_temp,
                        b_U_input, &r2, dv27, dv26, r3, dv25, r4, r5, dv24, &d1);
          EL->data[b_i].el_in0.b_break = r2.b_break;
          for (i27 = 0; i27 < 2; i27++) {
            EL->data[b_i].el_in0.mat[i27] = r2.mat[i27];
          }

          for (i27 = 0; i27 < 5; i27++) {
            EL->data[b_i].el_in0.geom[i27] = r2.geom[i27];
          }

          for (i27 = 0; i27 < 2; i27++) {
            EL->data[b_i].el_in0.axial.form[i27] = r2.axial.form[i27];
          }

          EL->data[b_i].el_in0.axial.breaks.size[0] = 1;
          EL->data[b_i].el_in0.axial.breaks.size[1] = r2.axial.breaks.size[1];
          c_i = r2.axial.breaks.size[0] * r2.axial.breaks.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.axial.breaks.data[i27] =
              r2.axial.breaks.data[i27];
          }

          i27 = EL->data[b_i].el_in0.axial.coefs->size[0] * EL->data[b_i].
            el_in0.axial.coefs->size[1];
          EL->data[b_i].el_in0.axial.coefs->size[0] = r2.axial.coefs->size[0];
          EL->data[b_i].el_in0.axial.coefs->size[1] = r2.axial.coefs->size[1];
          emxEnsureCapacity((emxArray__common *)EL->data[b_i].el_in0.axial.coefs,
                            i27, (int32_T)sizeof(real_T));
          c_i = r2.axial.coefs->size[0] * r2.axial.coefs->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.axial.coefs->data[i27] = r2.axial.coefs->
              data[i27];
          }

          EL->data[b_i].el_in0.axial.pieces = r2.axial.pieces;
          EL->data[b_i].el_in0.axial.order = r2.axial.order;
          EL->data[b_i].el_in0.axial.dim = r2.axial.dim;
          for (i27 = 0; i27 < 2; i27++) {
            EL->data[b_i].el_in0.axial_k.form[i27] = r2.axial_k.form[i27];
          }

          i27 = EL->data[b_i].el_in0.axial_k.breaks->size[0] * EL->data[b_i].
            el_in0.axial_k.breaks->size[1];
          EL->data[b_i].el_in0.axial_k.breaks->size[0] = r2.axial_k.breaks->
            size[0];
          EL->data[b_i].el_in0.axial_k.breaks->size[1] = r2.axial_k.breaks->
            size[1];
          emxEnsureCapacity((emxArray__common *)EL->data[b_i].
                            el_in0.axial_k.breaks, i27, (int32_T)sizeof(real_T));
          c_i = r2.axial_k.breaks->size[0] * r2.axial_k.breaks->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.axial_k.breaks->data[i27] =
              r2.axial_k.breaks->data[i27];
          }

          i27 = EL->data[b_i].el_in0.axial_k.coefs->size[0] * EL->data[b_i].
            el_in0.axial_k.coefs->size[1];
          EL->data[b_i].el_in0.axial_k.coefs->size[0] = r2.axial_k.coefs->size[0];
          EL->data[b_i].el_in0.axial_k.coefs->size[1] = r2.axial_k.coefs->size[1];
          emxEnsureCapacity((emxArray__common *)EL->data[b_i].
                            el_in0.axial_k.coefs, i27, (int32_T)sizeof(real_T));
          c_i = r2.axial_k.coefs->size[0] * r2.axial_k.coefs->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.axial_k.coefs->data[i27] =
              r2.axial_k.coefs->data[i27];
          }

          EL->data[b_i].el_in0.axial_k.pieces = r2.axial_k.pieces;
          EL->data[b_i].el_in0.axial_k.order = r2.axial_k.order;
          EL->data[b_i].el_in0.axial_k.dim = r2.axial_k.dim;
          EL->data[b_i].el_in0.eps0 = r2.eps0;
          for (i27 = 0; i27 < 36; i27++) {
            EL->data[b_i].el_in0.K0[i27] = r2.K0[i27];
          }

          EL->data[b_i].el_in0.p = r2.p;
          EL->data[b_i].el_in0.r = r2.r;
          EL->data[b_i].el_in0.alpha.size[0] = r2.alpha.size[0];
          EL->data[b_i].el_in0.alpha.size[1] = r2.alpha.size[1];
          c_i = r2.alpha.size[0] * r2.alpha.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.alpha.data[i27] = r2.alpha.data[i27];
          }

          EL->data[b_i].el_in0.beta = r2.beta;
          EL->data[b_i].el_in0.eps.size[0] = r2.eps.size[0];
          EL->data[b_i].el_in0.eps.size[1] = 2;
          c_i = r2.eps.size[0] * r2.eps.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.eps.data[i27] = r2.eps.data[i27];
          }

          EL->data[b_i].el_in0.f.size[0] = r2.f.size[0];
          EL->data[b_i].el_in0.f.size[1] = 2;
          c_i = r2.f.size[0] * r2.f.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.f.data[i27] = r2.f.data[i27];
          }

          i27 = EL->data[b_i].el_in0.nodes->size[0] * EL->data[b_i].
            el_in0.nodes->size[1];
          EL->data[b_i].el_in0.nodes->size[0] = 1;
          EL->data[b_i].el_in0.nodes->size[1] = r2.nodes->size[1];
          emxEnsureCapacity_struct5_T(EL->data[b_i].el_in0.nodes, i27);
          c_i = r2.nodes->size[0] * r2.nodes->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.nodes->data[i27] = r2.nodes->data[i27];
          }

          for (i27 = 0; i27 < 5; i27++) {
            EL->data[b_i].el_in0.propsLH[i27] = r2.propsLH[i27];
          }

          for (i27 = 0; i27 < 6; i27++) {
            EL->data[b_i].el_in0.D0[i27] = r2.D0[i27];
          }

          for (i27 = 0; i27 < 6; i27++) {
            EL->data[b_i].el_in0.P0[i27] = r2.P0[i27];
          }

          EL->data[b_i].el_in0.n = r2.n;
          EL->data[b_i].el_in0.flex.b_break = r2.flex.b_break;
          for (i27 = 0; i27 < 25; i27++) {
            EL->data[b_i].el_in0.flex.K[i27] = r2.flex.K[i27];
          }

          EL->data[b_i].el_in0.flex.D.size[0] = 5;
          EL->data[b_i].el_in0.flex.D.size[1] = r2.flex.D->size[1];
          c_i = r2.flex.D->size[0] * r2.flex.D->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.flex.D.data[i27] = r2.flex.D->data[i27];
          }

          EL->data[b_i].el_in0.flex.Du.size[0] = 5;
          EL->data[b_i].el_in0.flex.Du.size[1] = r2.flex.Du->size[1];
          c_i = r2.flex.Du->size[0] * r2.flex.Du->size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.flex.Du.data[i27] = r2.flex.Du->data[i27];
          }

          for (i27 = 0; i27 < 5; i27++) {
            EL->data[b_i].el_in0.flex.Q[i27] = r2.flex.Q[i27];
          }

          EL->data[b_i].el_in0.flex.f.size[0] = 5;
          EL->data[b_i].el_in0.flex.f.size[1] = 5;
          EL->data[b_i].el_in0.flex.f.size[2] = r2.flex.f.size[2];
          c_i = r2.flex.f.size[0] * r2.flex.f.size[1] * r2.flex.f.size[2];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.flex.f.data[i27] = r2.flex.f.data[i27];
          }

          EL->data[b_i].el_in0.flex.d.size[0] = 5;
          EL->data[b_i].el_in0.flex.d.size[1] = r2.flex.d.size[1];
          c_i = r2.flex.d.size[0] * r2.flex.d.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.flex.d.data[i27] = r2.flex.d.data[i27];
          }

          EL->data[b_i].el_in0.flex.e.size[0] = r2.flex.e.size[0];
          EL->data[b_i].el_in0.flex.e.size[1] = r2.flex.e.size[1];
          c_i = r2.flex.e.size[0] * r2.flex.e.size[1];
          for (i27 = 0; i27 < c_i; i27++) {
            EL->data[b_i].el_in0.flex.e.data[i27] = r2.flex.e.data[i27];
          }

          EL->data[b_i].el_in0.state_it = r2.state_it;
          EL->data[b_i].el_in0.el = r2.el;
          for (i27 = 0; i27 < 12; i27++) {
            fint_i->data[i27 + fint_i->size[0] * b_i] = dv27[i27];
          }

          for (i27 = 0; i27 < 12; i27++) {
            Fint_i->data[i27 + Fint_i->size[0] * b_i] = dv26[i27];
          }

          for (i27 = 0; i27 < 12; i27++) {
            dof_Fint->data[i27 + dof_Fint->size[0] * b_i] = r3->data[i27];
          }

          for (i27 = 0; i27 < 144; i27++) {
            Kel->data[i27 + Kel->size[0] * b_i] = dv25[i27];
          }

          for (i27 = 0; i27 < 144; i27++) {
            dof_i->data[i27 + dof_i->size[0] * b_i] = r4->data[i27];
          }

          for (i27 = 0; i27 < 144; i27++) {
            dof_j->data[i27 + dof_j->size[0] * b_i] = r5->data[i27];
          }

          for (i27 = 0; i27 < 12; i27++) {
            ROT->data[b_i + ROT->size[0] * i27] = dv24[i27];
          }

          break_iter_data[b_i] = d1;
        } else {
          emlrtHadParallelError = true;
        }
      }

      if (!emlrtHadParallelError) {
        emlrtHeapReferenceStackLeaveScope(aTLS, 11);
        emxFree_real_T(&r5);
        emxFree_real_T(&r4);
        emxFree_real_T(&r3);
        emxFreeStruct_struct_T(&r2);
        emxFree_real_T(&t4_el_in0_axial_coefs);
        emxFree_real_T(&t4_el_in0_axial_k_breaks);
        emxFree_real_T(&t4_el_in0_axial_k_coefs);
        emxFree_struct5_T(&t4_el_in0_nodes);
        emxFree_real_T(&t4_el_in0_flex_D);
        emxFree_real_T(&t4_el_in0_flex_Du);
        emxFreeStruct_struct_T(&expl_temp);
      }
    }

    emlrtPopJmpBuf(aTLS, &emlrtJBStack);
    emlrtExitParallelRegion(aTLS, omp_in_parallel());
  } else {
    i26 = EL->size[0];
    d_i = 0;
    emxInit_real_T(aTLS, &t2_axial_coefs, 2, true);
    emxInit_real_T(aTLS, &t2_axial_k_breaks, 2, true);
    emxInit_real_T(aTLS, &t2_axial_k_coefs, 2, true);
    emxInit_struct5_T(aTLS, &t2_nodes, 2, true);
    emxInit_real_T(aTLS, &t2_flex_D, 2, true);
    emxInit_real_T(aTLS, &t2_flex_Du, 2, true);
    emxInit_real_T2(aTLS, &r6, 1, true);
    emxInit_real_T2(aTLS, &r7, 1, true);
    emxInit_real_T2(aTLS, &r8, 1, true);
    emxInit_real_T(aTLS, &t3_el_in0_axial_coefs, 2, true);
    emxInit_real_T(aTLS, &t3_el_in0_axial_k_breaks, 2, true);
    emxInit_real_T(aTLS, &t3_el_in0_axial_k_coefs, 2, true);
    emxInit_struct5_T(aTLS, &t3_el_in0_nodes, 2, true);
    emxInit_real_T(aTLS, &t3_el_in0_flex_D, 2, true);
    emxInit_real_T(aTLS, &t3_el_in0_flex_Du, 2, true);
    emxInitStruct_struct_T(aTLS, &b_expl_temp, true);
    emxInitStruct_struct_T(aTLS, &c_expl_temp, true);
    while (d_i <= i26 - 1) {
      t3_el_size[0] = 1;
      t3_el_size[1] = EL->data[d_i].el.size[1];
      i = EL->data[d_i].el.size[0] * EL->data[d_i].el.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_data[i28] = EL->data[d_i].el.data[i28];
      }

      for (i28 = 0; i28 < 6; i28++) {
        t3_el_in_nodes_ij[i28] = EL->data[d_i].el_in.nodes_ij[i28];
      }

      for (i28 = 0; i28 < 3; i28++) {
        t3_el_in_orient_ij[i28] = EL->data[d_i].el_in.orient_ij[i28];
      }

      t3_el_in0_break = EL->data[d_i].el_in0.b_break;
      for (i28 = 0; i28 < 2; i28++) {
        t3_el_in0_mat[i28] = EL->data[d_i].el_in0.mat[i28];
      }

      for (i28 = 0; i28 < 5; i28++) {
        t3_el_in0_geom[i28] = EL->data[d_i].el_in0.geom[i28];
      }

      for (i28 = 0; i28 < 2; i28++) {
        t3_el_in0_axial_form[i28] = EL->data[d_i].el_in0.axial.form[i28];
      }

      c_t3_el_in0_axial_breaks_size_i = EL->data[d_i].el_in0.axial.breaks.size[1];
      i = EL->data[d_i].el_in0.axial.breaks.size[0] * EL->data[d_i].
        el_in0.axial.breaks.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_axial_breaks_data[i28] = EL->data[d_i].
          el_in0.axial.breaks.data[i28];
      }

      i28 = t3_el_in0_axial_coefs->size[0] * t3_el_in0_axial_coefs->size[1];
      t3_el_in0_axial_coefs->size[0] = EL->data[d_i].el_in0.axial.coefs->size[0];
      t3_el_in0_axial_coefs->size[1] = EL->data[d_i].el_in0.axial.coefs->size[1];
      emxEnsureCapacity((emxArray__common *)t3_el_in0_axial_coefs, i28, (int32_T)
                        sizeof(real_T));
      i = EL->data[d_i].el_in0.axial.coefs->size[0] * EL->data[d_i].
        el_in0.axial.coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_axial_coefs->data[i28] = EL->data[d_i]
          .el_in0.axial.coefs->data[i28];
      }

      t3_el_in0_axial_pieces = EL->data[d_i].el_in0.axial.pieces;
      t3_el_in0_axial_order = EL->data[d_i].el_in0.axial.order;
      t3_el_in0_axial_dim = EL->data[d_i].el_in0.axial.dim;
      for (i28 = 0; i28 < 2; i28++) {
        t3_el_in0_axial_k_form[i28] = EL->data[d_i].el_in0.axial_k.form[i28];
      }

      i28 = t3_el_in0_axial_k_breaks->size[0] * t3_el_in0_axial_k_breaks->size[1];
      t3_el_in0_axial_k_breaks->size[0] = EL->data[d_i]
        .el_in0.axial_k.breaks->size[0];
      t3_el_in0_axial_k_breaks->size[1] = EL->data[d_i]
        .el_in0.axial_k.breaks->size[1];
      emxEnsureCapacity((emxArray__common *)t3_el_in0_axial_k_breaks, i28,
                        (int32_T)sizeof(real_T));
      i = EL->data[d_i].el_in0.axial_k.breaks->size[0] * EL->data[d_i].
        el_in0.axial_k.breaks->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_axial_k_breaks->data[i28] = EL->data[d_i].
          el_in0.axial_k.breaks->data[i28];
      }

      i28 = t3_el_in0_axial_k_coefs->size[0] * t3_el_in0_axial_k_coefs->size[1];
      t3_el_in0_axial_k_coefs->size[0] = EL->data[d_i]
        .el_in0.axial_k.coefs->size[0];
      t3_el_in0_axial_k_coefs->size[1] = EL->data[d_i]
        .el_in0.axial_k.coefs->size[1];
      emxEnsureCapacity((emxArray__common *)t3_el_in0_axial_k_coefs, i28,
                        (int32_T)sizeof(real_T));
      i = EL->data[d_i].el_in0.axial_k.coefs->size[0] * EL->data[d_i].
        el_in0.axial_k.coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_axial_k_coefs->data[i28] = EL->data[d_i].
          el_in0.axial_k.coefs->data[i28];
      }

      t3_el_in0_axial_k_pieces = EL->data[d_i].el_in0.axial_k.pieces;
      t3_el_in0_axial_k_order = EL->data[d_i].el_in0.axial_k.order;
      t3_el_in0_axial_k_dim = EL->data[d_i].el_in0.axial_k.dim;
      t3_el_in0_eps0 = EL->data[d_i].el_in0.eps0;
      for (i28 = 0; i28 < 36; i28++) {
        t3_el_in0_K0[i28] = EL->data[d_i].el_in0.K0[i28];
      }

      t3_el_in0_p = EL->data[d_i].el_in0.p;
      t3_el_in0_r = EL->data[d_i].el_in0.r;
      t3_el_in0_alpha_size_idx_0 = EL->data[d_i].el_in0.alpha.size[0];
      t3_el_in0_alpha_size_idx_1 = EL->data[d_i].el_in0.alpha.size[1];
      i = EL->data[d_i].el_in0.alpha.size[0] * EL->data[d_i].el_in0.alpha.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_alpha_data[i28] = EL->data[d_i].el_in0.alpha.data[i28];
      }

      t3_el_in0_beta = EL->data[d_i].el_in0.beta;
      t3_el_in0_eps_size_idx_0 = EL->data[d_i].el_in0.eps.size[0];
      i = EL->data[d_i].el_in0.eps.size[0] * EL->data[d_i].el_in0.eps.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_eps_data[i28] = EL->data[d_i].el_in0.eps.data[i28];
      }

      t3_el_in0_f_size_idx_0 = EL->data[d_i].el_in0.f.size[0];
      i = EL->data[d_i].el_in0.f.size[0] * EL->data[d_i].el_in0.f.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_f_data[i28] = EL->data[d_i].el_in0.f.data[i28];
      }

      i28 = t3_el_in0_nodes->size[0] * t3_el_in0_nodes->size[1];
      t3_el_in0_nodes->size[0] = 1;
      t3_el_in0_nodes->size[1] = EL->data[d_i].el_in0.nodes->size[1];
      emxEnsureCapacity_struct5_T(t3_el_in0_nodes, i28);
      i = EL->data[d_i].el_in0.nodes->size[0] * EL->data[d_i].el_in0.nodes->
        size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_nodes->data[i28] = EL->data[d_i].el_in0.nodes->data[i28];
      }

      for (i28 = 0; i28 < 5; i28++) {
        t3_el_in0_propsLH[i28] = EL->data[d_i].el_in0.propsLH[i28];
      }

      for (i28 = 0; i28 < 6; i28++) {
        t3_el_in0_D0[i28] = EL->data[d_i].el_in0.D0[i28];
        t3_el_in0_P0[i28] = EL->data[d_i].el_in0.P0[i28];
      }

      t3_el_in0_n = EL->data[d_i].el_in0.n;
      t3_el_in0_flex_break = EL->data[d_i].el_in0.flex.b_break;
      for (i28 = 0; i28 < 25; i28++) {
        t3_el_in0_flex_K[i28] = EL->data[d_i].el_in0.flex.K[i28];
      }

      i28 = t3_el_in0_flex_D->size[0] * t3_el_in0_flex_D->size[1];
      t3_el_in0_flex_D->size[0] = 5;
      t3_el_in0_flex_D->size[1] = EL->data[d_i].el_in0.flex.D.size[1];
      emxEnsureCapacity((emxArray__common *)t3_el_in0_flex_D, i28, (int32_T)
                        sizeof(real_T));
      i = EL->data[d_i].el_in0.flex.D.size[0] * EL->data[d_i]
        .el_in0.flex.D.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_flex_D->data[i28] = EL->data[d_i].el_in0.flex.D.data[i28];
      }

      i28 = t3_el_in0_flex_Du->size[0] * t3_el_in0_flex_Du->size[1];
      t3_el_in0_flex_Du->size[0] = 5;
      t3_el_in0_flex_Du->size[1] = EL->data[d_i].el_in0.flex.Du.size[1];
      emxEnsureCapacity((emxArray__common *)t3_el_in0_flex_Du, i28, (int32_T)
                        sizeof(real_T));
      i = EL->data[d_i].el_in0.flex.Du.size[0] * EL->data[d_i].
        el_in0.flex.Du.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_flex_Du->data[i28] = EL->data[d_i].el_in0.flex.Du.data[i28];
      }

      for (i28 = 0; i28 < 5; i28++) {
        t3_el_in0_flex_Q[i28] = EL->data[d_i].el_in0.flex.Q[i28];
      }

      t3_el_in0_flex_f_size_idx_2 = EL->data[d_i].el_in0.flex.f.size[2];
      i = EL->data[d_i].el_in0.flex.f.size[0] * EL->data[d_i]
        .el_in0.flex.f.size[1] * EL->data[d_i].el_in0.flex.f.size[2];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_flex_f_data[i28] = EL->data[d_i].el_in0.flex.f.data[i28];
      }

      t3_el_in0_flex_d_size_idx_1 = EL->data[d_i].el_in0.flex.d.size[1];
      i = EL->data[d_i].el_in0.flex.d.size[0] * EL->data[d_i]
        .el_in0.flex.d.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_flex_d_data[i28] = EL->data[d_i].el_in0.flex.d.data[i28];
      }

      t3_el_in0_flex_e_size_idx_0 = EL->data[d_i].el_in0.flex.e.size[0];
      t3_el_in0_flex_e_size_idx_1 = EL->data[d_i].el_in0.flex.e.size[1];
      i = EL->data[d_i].el_in0.flex.e.size[0] * EL->data[d_i]
        .el_in0.flex.e.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t3_el_in0_flex_e_data[i28] = EL->data[d_i].el_in0.flex.e.data[i28];
      }

      t3_el_in0_state_it = EL->data[d_i].el_in0.state_it;
      t3_el_in0_el = EL->data[d_i].el_in0.el;
      c_expl_temp.el = t3_el_in0_el;
      c_expl_temp.state_it = t3_el_in0_state_it;
      c_expl_temp.flex.b_break = t3_el_in0_flex_break;
      memcpy(&c_expl_temp.flex.K[0], &t3_el_in0_flex_K[0], 25U * sizeof(real_T));
      i28 = c_expl_temp.flex.D->size[0] * c_expl_temp.flex.D->size[1];
      c_expl_temp.flex.D->size[0] = 5;
      c_expl_temp.flex.D->size[1] = t3_el_in0_flex_D->size[1];
      emxEnsureCapacity((emxArray__common *)c_expl_temp.flex.D, i28, (int32_T)
                        sizeof(real_T));
      i = t3_el_in0_flex_D->size[0] * t3_el_in0_flex_D->size[1];
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.flex.D->data[i28] = t3_el_in0_flex_D->data[i28];
      }

      i28 = c_expl_temp.flex.Du->size[0] * c_expl_temp.flex.Du->size[1];
      c_expl_temp.flex.Du->size[0] = 5;
      c_expl_temp.flex.Du->size[1] = t3_el_in0_flex_Du->size[1];
      emxEnsureCapacity((emxArray__common *)c_expl_temp.flex.Du, i28, (int32_T)
                        sizeof(real_T));
      i = t3_el_in0_flex_Du->size[0] * t3_el_in0_flex_Du->size[1];
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.flex.Du->data[i28] = t3_el_in0_flex_Du->data[i28];
      }

      for (i = 0; i < 5; i++) {
        c_expl_temp.flex.Q[i] = t3_el_in0_flex_Q[i];
      }

      c_expl_temp.flex.f.size[0] = 5;
      c_expl_temp.flex.f.size[1] = 5;
      c_expl_temp.flex.f.size[2] = t3_el_in0_flex_f_size_idx_2;
      i = 25 * t3_el_in0_flex_f_size_idx_2;
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.flex.f.data[i28] = t3_el_in0_flex_f_data[i28];
      }

      c_expl_temp.flex.d.size[0] = 5;
      c_expl_temp.flex.d.size[1] = t3_el_in0_flex_d_size_idx_1;
      i = 5 * t3_el_in0_flex_d_size_idx_1;
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.flex.d.data[i28] = t3_el_in0_flex_d_data[i28];
      }

      c_expl_temp.flex.e.size[0] = t3_el_in0_flex_e_size_idx_0;
      c_expl_temp.flex.e.size[1] = t3_el_in0_flex_e_size_idx_1;
      i = t3_el_in0_flex_e_size_idx_0 * t3_el_in0_flex_e_size_idx_1;
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.flex.e.data[i28] = t3_el_in0_flex_e_data[i28];
      }

      c_expl_temp.n = t3_el_in0_n;
      for (i = 0; i < 6; i++) {
        c_expl_temp.P0[i] = t3_el_in0_P0[i];
      }

      for (i = 0; i < 6; i++) {
        c_expl_temp.D0[i] = t3_el_in0_D0[i];
      }

      for (i = 0; i < 5; i++) {
        c_expl_temp.propsLH[i] = t3_el_in0_propsLH[i];
      }

      i28 = c_expl_temp.nodes->size[0] * c_expl_temp.nodes->size[1];
      c_expl_temp.nodes->size[0] = 1;
      c_expl_temp.nodes->size[1] = t3_el_in0_nodes->size[1];
      emxEnsureCapacity_struct5_T(c_expl_temp.nodes, i28);
      i = t3_el_in0_nodes->size[0] * t3_el_in0_nodes->size[1];
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.nodes->data[i28] = t3_el_in0_nodes->data[i28];
      }

      c_expl_temp.f.size[0] = t3_el_in0_f_size_idx_0;
      c_expl_temp.f.size[1] = 2;
      i = t3_el_in0_f_size_idx_0 << 1;
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.f.data[i28] = t3_el_in0_f_data[i28];
      }

      c_expl_temp.eps.size[0] = t3_el_in0_eps_size_idx_0;
      c_expl_temp.eps.size[1] = 2;
      i = t3_el_in0_eps_size_idx_0 << 1;
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.eps.data[i28] = t3_el_in0_eps_data[i28];
      }

      c_expl_temp.beta = t3_el_in0_beta;
      c_expl_temp.alpha.size[0] = t3_el_in0_alpha_size_idx_0;
      c_expl_temp.alpha.size[1] = t3_el_in0_alpha_size_idx_1;
      i = t3_el_in0_alpha_size_idx_0 * t3_el_in0_alpha_size_idx_1;
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.alpha.data[i28] = t3_el_in0_alpha_data[i28];
      }

      c_expl_temp.r = t3_el_in0_r;
      c_expl_temp.p = t3_el_in0_p;
      memcpy(&c_expl_temp.K0[0], &t3_el_in0_K0[0], 36U * sizeof(real_T));
      c_expl_temp.eps0 = t3_el_in0_eps0;
      for (i28 = 0; i28 < 2; i28++) {
        c_expl_temp.axial_k.form[i28] = t3_el_in0_axial_k_form[i28];
      }

      i28 = c_expl_temp.axial_k.breaks->size[0] *
        c_expl_temp.axial_k.breaks->size[1];
      c_expl_temp.axial_k.breaks->size[0] = t3_el_in0_axial_k_breaks->size[0];
      c_expl_temp.axial_k.breaks->size[1] = t3_el_in0_axial_k_breaks->size[1];
      emxEnsureCapacity((emxArray__common *)c_expl_temp.axial_k.breaks, i28,
                        (int32_T)sizeof(real_T));
      i = t3_el_in0_axial_k_breaks->size[0] * t3_el_in0_axial_k_breaks->size[1];
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.axial_k.breaks->data[i28] = t3_el_in0_axial_k_breaks->
          data[i28];
      }

      i28 = c_expl_temp.axial_k.coefs->size[0] * c_expl_temp.axial_k.coefs->
        size[1];
      c_expl_temp.axial_k.coefs->size[0] = t3_el_in0_axial_k_coefs->size[0];
      c_expl_temp.axial_k.coefs->size[1] = t3_el_in0_axial_k_coefs->size[1];
      emxEnsureCapacity((emxArray__common *)c_expl_temp.axial_k.coefs, i28,
                        (int32_T)sizeof(real_T));
      i = t3_el_in0_axial_k_coefs->size[0] * t3_el_in0_axial_k_coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.axial_k.coefs->data[i28] = t3_el_in0_axial_k_coefs->data[i28];
      }

      c_expl_temp.axial_k.pieces = t3_el_in0_axial_k_pieces;
      c_expl_temp.axial_k.order = t3_el_in0_axial_k_order;
      c_expl_temp.axial_k.dim = t3_el_in0_axial_k_dim;
      for (i28 = 0; i28 < 2; i28++) {
        c_expl_temp.axial.form[i28] = t3_el_in0_axial_form[i28];
      }

      c_expl_temp.axial.breaks.size[0] = 1;
      c_expl_temp.axial.breaks.size[1] = c_t3_el_in0_axial_breaks_size_i;
      for (i28 = 0; i28 < c_t3_el_in0_axial_breaks_size_i; i28++) {
        c_expl_temp.axial.breaks.data[i28] = t3_el_in0_axial_breaks_data[i28];
      }

      i28 = c_expl_temp.axial.coefs->size[0] * c_expl_temp.axial.coefs->size[1];
      c_expl_temp.axial.coefs->size[0] = t3_el_in0_axial_coefs->size[0];
      c_expl_temp.axial.coefs->size[1] = t3_el_in0_axial_coefs->size[1];
      emxEnsureCapacity((emxArray__common *)c_expl_temp.axial.coefs, i28,
                        (int32_T)sizeof(real_T));
      i = t3_el_in0_axial_coefs->size[0] * t3_el_in0_axial_coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        c_expl_temp.axial.coefs->data[i28] = t3_el_in0_axial_coefs->data[i28];
      }

      c_expl_temp.axial.pieces = t3_el_in0_axial_pieces;
      c_expl_temp.axial.order = t3_el_in0_axial_order;
      c_expl_temp.axial.dim = t3_el_in0_axial_dim;
      for (i28 = 0; i28 < 5; i28++) {
        c_expl_temp.geom[i28] = t3_el_in0_geom[i28];
      }

      for (i28 = 0; i28 < 2; i28++) {
        c_expl_temp.mat[i28] = t3_el_in0_mat[i28];
      }

      c_expl_temp.b_break = t3_el_in0_break;
      for (i28 = 0; i28 < 2; i28++) {
        t3_el_in0_mat[i28] = con_data[d_i + con_size[0] * i28];
      }

      for (i28 = 0; i28 < 4; i28++) {
        for (c_t3_el_in0_axial_breaks_size_i = 0;
             c_t3_el_in0_axial_breaks_size_i < 12;
             c_t3_el_in0_axial_breaks_size_i++) {
          c_U_input[c_t3_el_in0_axial_breaks_size_i + 12 * i28] = U_input->data
            [(d_i + U_input->size[0] * c_t3_el_in0_axial_breaks_size_i) +
            U_input->size[0] * U_input->size[1] * i28];
        }
      }

      assemble_body(aTLS, t3_el_in0_mat, t3_el_data, t3_el_size,
                    t3_el_in_nodes_ij, t3_el_in_orient_ij, &c_expl_temp,
                    c_U_input, &b_expl_temp, dv31, dv30, r6, dv29, r7, r8, dv28,
                    &d2);
      t3_el_in0_break = b_expl_temp.b_break;
      for (i28 = 0; i28 < 2; i28++) {
        t3_el_in0_mat[i28] = b_expl_temp.mat[i28];
      }

      for (i28 = 0; i28 < 5; i28++) {
        t3_el_in0_geom[i28] = b_expl_temp.geom[i28];
      }

      for (i28 = 0; i28 < 2; i28++) {
        t3_el_in0_axial_form[i28] = b_expl_temp.axial.form[i28];
      }

      t3_el_in0_f_size_idx_0 = b_expl_temp.axial.breaks.size[1];
      i = b_expl_temp.axial.breaks.size[0] * b_expl_temp.axial.breaks.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_axial_breaks_data[i28] = b_expl_temp.axial.breaks.data[i28];
      }

      i28 = t2_axial_coefs->size[0] * t2_axial_coefs->size[1];
      t2_axial_coefs->size[0] = b_expl_temp.axial.coefs->size[0];
      t2_axial_coefs->size[1] = b_expl_temp.axial.coefs->size[1];
      emxEnsureCapacity((emxArray__common *)t2_axial_coefs, i28, (int32_T)sizeof
                        (real_T));
      i = b_expl_temp.axial.coefs->size[0] * b_expl_temp.axial.coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_axial_coefs->data[i28] = b_expl_temp.axial.coefs->data[i28];
      }

      t3_el_in0_axial_pieces = b_expl_temp.axial.pieces;
      t3_el_in0_axial_order = b_expl_temp.axial.order;
      t3_el_in0_axial_dim = b_expl_temp.axial.dim;
      for (i28 = 0; i28 < 2; i28++) {
        t3_el_in0_axial_k_form[i28] = b_expl_temp.axial_k.form[i28];
      }

      i28 = t2_axial_k_breaks->size[0] * t2_axial_k_breaks->size[1];
      t2_axial_k_breaks->size[0] = b_expl_temp.axial_k.breaks->size[0];
      t2_axial_k_breaks->size[1] = b_expl_temp.axial_k.breaks->size[1];
      emxEnsureCapacity((emxArray__common *)t2_axial_k_breaks, i28, (int32_T)
                        sizeof(real_T));
      i = b_expl_temp.axial_k.breaks->size[0] * b_expl_temp.axial_k.breaks->
        size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_axial_k_breaks->data[i28] = b_expl_temp.axial_k.breaks->data[i28];
      }

      i28 = t2_axial_k_coefs->size[0] * t2_axial_k_coefs->size[1];
      t2_axial_k_coefs->size[0] = b_expl_temp.axial_k.coefs->size[0];
      t2_axial_k_coefs->size[1] = b_expl_temp.axial_k.coefs->size[1];
      emxEnsureCapacity((emxArray__common *)t2_axial_k_coefs, i28, (int32_T)
                        sizeof(real_T));
      i = b_expl_temp.axial_k.coefs->size[0] * b_expl_temp.axial_k.coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_axial_k_coefs->data[i28] = b_expl_temp.axial_k.coefs->data[i28];
      }

      t3_el_in0_axial_k_pieces = b_expl_temp.axial_k.pieces;
      t3_el_in0_axial_k_order = b_expl_temp.axial_k.order;
      t3_el_in0_axial_k_dim = b_expl_temp.axial_k.dim;
      t3_el_in0_eps0 = b_expl_temp.eps0;
      for (i28 = 0; i28 < 36; i28++) {
        t2_K0[i28] = b_expl_temp.K0[i28];
      }

      t3_el_in0_p = b_expl_temp.p;
      t3_el_in0_r = b_expl_temp.r;
      t3_el_in0_flex_f_size_idx_2 = b_expl_temp.alpha.size[0];
      t3_el_in0_flex_d_size_idx_1 = b_expl_temp.alpha.size[1];
      i = b_expl_temp.alpha.size[0] * b_expl_temp.alpha.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_alpha_data[i28] = b_expl_temp.alpha.data[i28];
      }

      t3_el_in0_beta = b_expl_temp.beta;
      t3_el_in0_flex_e_size_idx_0 = b_expl_temp.eps.size[0];
      i = b_expl_temp.eps.size[0] * b_expl_temp.eps.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_eps_data[i28] = b_expl_temp.eps.data[i28];
      }

      t3_el_in0_flex_e_size_idx_1 = b_expl_temp.f.size[0];
      i = b_expl_temp.f.size[0] * b_expl_temp.f.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_f_data[i28] = b_expl_temp.f.data[i28];
      }

      i28 = t2_nodes->size[0] * t2_nodes->size[1];
      t2_nodes->size[0] = 1;
      t2_nodes->size[1] = b_expl_temp.nodes->size[1];
      emxEnsureCapacity_struct5_T(t2_nodes, i28);
      i = b_expl_temp.nodes->size[0] * b_expl_temp.nodes->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_nodes->data[i28] = b_expl_temp.nodes->data[i28];
      }

      for (i = 0; i < 5; i++) {
        t3_el_in0_propsLH[i] = b_expl_temp.propsLH[i];
      }

      for (i = 0; i < 6; i++) {
        t3_el_in_nodes_ij[i] = b_expl_temp.D0[i];
      }

      for (i = 0; i < 6; i++) {
        t3_el_in0_D0[i] = b_expl_temp.P0[i];
      }

      t3_el_in0_n = b_expl_temp.n;
      t3_el_in0_flex_break = b_expl_temp.flex.b_break;
      for (i28 = 0; i28 < 25; i28++) {
        t2_flex_K[i28] = b_expl_temp.flex.K[i28];
      }

      i28 = t2_flex_D->size[0] * t2_flex_D->size[1];
      t2_flex_D->size[0] = 5;
      t2_flex_D->size[1] = b_expl_temp.flex.D->size[1];
      emxEnsureCapacity((emxArray__common *)t2_flex_D, i28, (int32_T)sizeof
                        (real_T));
      i = b_expl_temp.flex.D->size[0] * b_expl_temp.flex.D->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_flex_D->data[i28] = b_expl_temp.flex.D->data[i28];
      }

      i28 = t2_flex_Du->size[0] * t2_flex_Du->size[1];
      t2_flex_Du->size[0] = 5;
      t2_flex_Du->size[1] = b_expl_temp.flex.Du->size[1];
      emxEnsureCapacity((emxArray__common *)t2_flex_Du, i28, (int32_T)sizeof
                        (real_T));
      i = b_expl_temp.flex.Du->size[0] * b_expl_temp.flex.Du->size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_flex_Du->data[i28] = b_expl_temp.flex.Du->data[i28];
      }

      for (i = 0; i < 5; i++) {
        t3_el_in0_flex_Q[i] = b_expl_temp.flex.Q[i];
      }

      c_t3_el_in0_axial_breaks_size_i = b_expl_temp.flex.f.size[2];
      i = b_expl_temp.flex.f.size[0] * b_expl_temp.flex.f.size[1] *
        b_expl_temp.flex.f.size[2];
      for (i28 = 0; i28 < i; i28++) {
        t2_flex_f_data[i28] = b_expl_temp.flex.f.data[i28];
      }

      t3_el_in0_alpha_size_idx_0 = b_expl_temp.flex.d.size[1];
      i = b_expl_temp.flex.d.size[0] * b_expl_temp.flex.d.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_flex_d_data[i28] = b_expl_temp.flex.d.data[i28];
      }

      t3_el_in0_alpha_size_idx_1 = b_expl_temp.flex.e.size[0];
      t3_el_in0_eps_size_idx_0 = b_expl_temp.flex.e.size[1];
      i = b_expl_temp.flex.e.size[0] * b_expl_temp.flex.e.size[1];
      for (i28 = 0; i28 < i; i28++) {
        t2_flex_e_data[i28] = b_expl_temp.flex.e.data[i28];
      }

      t3_el_in0_state_it = b_expl_temp.state_it;
      t3_el_in0_el = b_expl_temp.el;
      EL->data[d_i].el_in0.b_break = t3_el_in0_break;
      for (i28 = 0; i28 < 2; i28++) {
        EL->data[d_i].el_in0.mat[i28] = t3_el_in0_mat[i28];
      }

      for (i28 = 0; i28 < 5; i28++) {
        EL->data[d_i].el_in0.geom[i28] = t3_el_in0_geom[i28];
      }

      for (i28 = 0; i28 < 2; i28++) {
        EL->data[d_i].el_in0.axial.form[i28] = t3_el_in0_axial_form[i28];
      }

      EL->data[d_i].el_in0.axial.breaks.size[0] = 1;
      EL->data[d_i].el_in0.axial.breaks.size[1] = t3_el_in0_f_size_idx_0;
      for (i28 = 0; i28 < t3_el_in0_f_size_idx_0; i28++) {
        EL->data[d_i].el_in0.axial.breaks.data[i28] = t2_axial_breaks_data[i28];
      }

      i28 = EL->data[d_i].el_in0.axial.coefs->size[0] * EL->data[d_i].
        el_in0.axial.coefs->size[1];
      EL->data[d_i].el_in0.axial.coefs->size[0] = t2_axial_coefs->size[0];
      EL->data[d_i].el_in0.axial.coefs->size[1] = t2_axial_coefs->size[1];
      emxEnsureCapacity((emxArray__common *)EL->data[d_i].el_in0.axial.coefs,
                        i28, (int32_T)sizeof(real_T));
      i = t2_axial_coefs->size[0] * t2_axial_coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.axial.coefs->data[i28] = t2_axial_coefs->data[i28];
      }

      EL->data[d_i].el_in0.axial.pieces = t3_el_in0_axial_pieces;
      EL->data[d_i].el_in0.axial.order = t3_el_in0_axial_order;
      EL->data[d_i].el_in0.axial.dim = t3_el_in0_axial_dim;
      for (i28 = 0; i28 < 2; i28++) {
        EL->data[d_i].el_in0.axial_k.form[i28] = t3_el_in0_axial_k_form[i28];
      }

      i28 = EL->data[d_i].el_in0.axial_k.breaks->size[0] * EL->data[d_i].
        el_in0.axial_k.breaks->size[1];
      EL->data[d_i].el_in0.axial_k.breaks->size[0] = t2_axial_k_breaks->size[0];
      EL->data[d_i].el_in0.axial_k.breaks->size[1] = t2_axial_k_breaks->size[1];
      emxEnsureCapacity((emxArray__common *)EL->data[d_i].el_in0.axial_k.breaks,
                        i28, (int32_T)sizeof(real_T));
      i = t2_axial_k_breaks->size[0] * t2_axial_k_breaks->size[1];
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.axial_k.breaks->data[i28] = t2_axial_k_breaks->
          data[i28];
      }

      i28 = EL->data[d_i].el_in0.axial_k.coefs->size[0] * EL->data[d_i].
        el_in0.axial_k.coefs->size[1];
      EL->data[d_i].el_in0.axial_k.coefs->size[0] = t2_axial_k_coefs->size[0];
      EL->data[d_i].el_in0.axial_k.coefs->size[1] = t2_axial_k_coefs->size[1];
      emxEnsureCapacity((emxArray__common *)EL->data[d_i].el_in0.axial_k.coefs,
                        i28, (int32_T)sizeof(real_T));
      i = t2_axial_k_coefs->size[0] * t2_axial_k_coefs->size[1];
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.axial_k.coefs->data[i28] = t2_axial_k_coefs->
          data[i28];
      }

      EL->data[d_i].el_in0.axial_k.pieces = t3_el_in0_axial_k_pieces;
      EL->data[d_i].el_in0.axial_k.order = t3_el_in0_axial_k_order;
      EL->data[d_i].el_in0.axial_k.dim = t3_el_in0_axial_k_dim;
      EL->data[d_i].el_in0.eps0 = t3_el_in0_eps0;
      memcpy(&EL->data[d_i].el_in0.K0[0], &t2_K0[0], 36U * sizeof(real_T));
      EL->data[d_i].el_in0.p = t3_el_in0_p;
      EL->data[d_i].el_in0.r = t3_el_in0_r;
      EL->data[d_i].el_in0.alpha.size[0] = t3_el_in0_flex_f_size_idx_2;
      EL->data[d_i].el_in0.alpha.size[1] = t3_el_in0_flex_d_size_idx_1;
      i = t3_el_in0_flex_f_size_idx_2 * t3_el_in0_flex_d_size_idx_1;
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.alpha.data[i28] = t2_alpha_data[i28];
      }

      EL->data[d_i].el_in0.beta = t3_el_in0_beta;
      EL->data[d_i].el_in0.eps.size[0] = t3_el_in0_flex_e_size_idx_0;
      EL->data[d_i].el_in0.eps.size[1] = 2;
      i = t3_el_in0_flex_e_size_idx_0 << 1;
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.eps.data[i28] = t2_eps_data[i28];
      }

      EL->data[d_i].el_in0.f.size[0] = t3_el_in0_flex_e_size_idx_1;
      EL->data[d_i].el_in0.f.size[1] = 2;
      i = t3_el_in0_flex_e_size_idx_1 << 1;
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.f.data[i28] = t2_f_data[i28];
      }

      i28 = EL->data[d_i].el_in0.nodes->size[0] * EL->data[d_i]
        .el_in0.nodes->size[1];
      EL->data[d_i].el_in0.nodes->size[0] = 1;
      EL->data[d_i].el_in0.nodes->size[1] = t2_nodes->size[1];
      emxEnsureCapacity_struct5_T(EL->data[d_i].el_in0.nodes, i28);
      i = t2_nodes->size[0] * t2_nodes->size[1];
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.nodes->data[i28] = t2_nodes->data[i28];
      }

      for (i28 = 0; i28 < 5; i28++) {
        EL->data[d_i].el_in0.propsLH[i28] = t3_el_in0_propsLH[i28];
      }

      for (i28 = 0; i28 < 6; i28++) {
        EL->data[d_i].el_in0.D0[i28] = t3_el_in_nodes_ij[i28];
        EL->data[d_i].el_in0.P0[i28] = t3_el_in0_D0[i28];
      }

      EL->data[d_i].el_in0.n = t3_el_in0_n;
      EL->data[d_i].el_in0.flex.b_break = t3_el_in0_flex_break;
      memcpy(&EL->data[d_i].el_in0.flex.K[0], &t2_flex_K[0], 25U * sizeof(real_T));
      EL->data[d_i].el_in0.flex.D.size[0] = 5;
      EL->data[d_i].el_in0.flex.D.size[1] = t2_flex_D->size[1];
      i = t2_flex_D->size[0] * t2_flex_D->size[1];
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.flex.D.data[i28] = t2_flex_D->data[i28];
      }

      EL->data[d_i].el_in0.flex.Du.size[0] = 5;
      EL->data[d_i].el_in0.flex.Du.size[1] = t2_flex_Du->size[1];
      i = t2_flex_Du->size[0] * t2_flex_Du->size[1];
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.flex.Du.data[i28] = t2_flex_Du->data[i28];
      }

      for (i28 = 0; i28 < 5; i28++) {
        EL->data[d_i].el_in0.flex.Q[i28] = t3_el_in0_flex_Q[i28];
      }

      EL->data[d_i].el_in0.flex.f.size[0] = 5;
      EL->data[d_i].el_in0.flex.f.size[1] = 5;
      EL->data[d_i].el_in0.flex.f.size[2] = c_t3_el_in0_axial_breaks_size_i;
      i = 25 * c_t3_el_in0_axial_breaks_size_i;
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.flex.f.data[i28] = t2_flex_f_data[i28];
      }

      EL->data[d_i].el_in0.flex.d.size[0] = 5;
      EL->data[d_i].el_in0.flex.d.size[1] = t3_el_in0_alpha_size_idx_0;
      i = 5 * t3_el_in0_alpha_size_idx_0;
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.flex.d.data[i28] = t2_flex_d_data[i28];
      }

      EL->data[d_i].el_in0.flex.e.size[0] = t3_el_in0_alpha_size_idx_1;
      EL->data[d_i].el_in0.flex.e.size[1] = t3_el_in0_eps_size_idx_0;
      i = t3_el_in0_alpha_size_idx_1 * t3_el_in0_eps_size_idx_0;
      for (i28 = 0; i28 < i; i28++) {
        EL->data[d_i].el_in0.flex.e.data[i28] = t2_flex_e_data[i28];
      }

      EL->data[d_i].el_in0.state_it = t3_el_in0_state_it;
      EL->data[d_i].el_in0.el = t3_el_in0_el;
      for (i28 = 0; i28 < 12; i28++) {
        fint_i->data[i28 + fint_i->size[0] * d_i] = dv31[i28];
      }

      for (i28 = 0; i28 < 12; i28++) {
        Fint_i->data[i28 + Fint_i->size[0] * d_i] = dv30[i28];
      }

      for (i28 = 0; i28 < 12; i28++) {
        dof_Fint->data[i28 + dof_Fint->size[0] * d_i] = r6->data[i28];
      }

      for (i28 = 0; i28 < 144; i28++) {
        Kel->data[i28 + Kel->size[0] * d_i] = dv29[i28];
      }

      for (i28 = 0; i28 < 144; i28++) {
        dof_i->data[i28 + dof_i->size[0] * d_i] = r7->data[i28];
      }

      for (i28 = 0; i28 < 144; i28++) {
        dof_j->data[i28 + dof_j->size[0] * d_i] = r8->data[i28];
      }

      for (i28 = 0; i28 < 12; i28++) {
        ROT->data[d_i + ROT->size[0] * i28] = dv28[i28];
      }

      break_iter_data[d_i] = d2;
      d_i++;
    }

    emxFreeStruct_struct_T(&c_expl_temp);
    emxFreeStruct_struct_T(&b_expl_temp);
    emxFree_real_T(&t3_el_in0_flex_Du);
    emxFree_real_T(&t3_el_in0_flex_D);
    emxFree_struct5_T(&t3_el_in0_nodes);
    emxFree_real_T(&t3_el_in0_axial_k_coefs);
    emxFree_real_T(&t3_el_in0_axial_k_breaks);
    emxFree_real_T(&t3_el_in0_axial_coefs);
    emxFree_real_T(&r8);
    emxFree_real_T(&r7);
    emxFree_real_T(&r6);
    emxFree_real_T(&t2_flex_Du);
    emxFree_real_T(&t2_flex_D);
    emxFree_struct5_T(&t2_nodes);
    emxFree_real_T(&t2_axial_k_coefs);
    emxFree_real_T(&t2_axial_k_breaks);
    emxFree_real_T(&t2_axial_coefs);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(aTLS);
}

/* End of code generation (assemble_prebody.c) */
