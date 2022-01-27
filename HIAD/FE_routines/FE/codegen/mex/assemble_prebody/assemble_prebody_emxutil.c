/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_prebody_emxutil.c
 *
 * Code generation for function 'assemble_prebody_emxutil'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "assemble_prebody.h"
#include "assemble_prebody_emxutil.h"
#include "assemble_prebody_data.h"

/* Function Declarations */
static void emxCopyMatrix_char_T(char_T dst[2], const char_T src[2]);
static void emxCopyMatrix_real_T(real_T dst[2], const real_T src[2]);
static void emxCopyMatrix_real_T1(real_T dst[5], const real_T src[5]);
static void emxCopyMatrix_real_T2(real_T dst[36], const real_T src[36]);
static void emxCopyMatrix_real_T3(real_T dst[5], const real_T src[5]);
static void emxCopyMatrix_real_T4(real_T dst[6], const real_T src[6]);
static void emxCopyMatrix_real_T5(real_T dst[25], const real_T src[25]);
static void emxCopyStruct_struct3_T(struct3_T *dst, const struct3_T *src);
static void emxCopyStruct_struct4_T(struct4_T *dst, const struct4_T *src);
static void emxCopy_real_T(emxArray_real_T **dst, emxArray_real_T * const *src);
static void emxCopy_real_T_1x500(emxArray_real_T_1x500 *dst, const
  emxArray_real_T_1x500 *src);
static void emxCopy_real_T_20x20(emxArray_real_T_20x20 *dst, const
  emxArray_real_T_20x20 *src);
static void emxCopy_real_T_5x2(emxArray_real_T_5x2 *dst, const
  emxArray_real_T_5x2 *src);
static void emxCopy_real_T_5x20(emxArray_real_T_5x20 *dst, const
  emxArray_real_T_5x20 *src);
static void emxCopy_real_T_5x5x20(emxArray_real_T_5x5x20 *dst, const
  emxArray_real_T_5x5x20 *src);
static void emxCopy_struct5_T(emxArray_struct5_T **dst, emxArray_struct5_T *
  const *src);
static void emxExpand_struct0_T(emxArray_struct0_T *emxArray, int32_T fromIndex,
  int32_T toIndex);
static void emxExpand_struct5_T(emxArray_struct5_T *emxArray, int32_T fromIndex,
  int32_T toIndex);
static void emxFreeStruct_struct0_T(struct0_T *pStruct);
static void emxFreeStruct_struct2_T(struct2_T *pStruct);
static void emxFreeStruct_struct3_T(struct3_T *pStruct);
static void emxFreeStruct_struct4_T(struct4_T *pStruct);
static void emxInitStruct_struct0_T(struct0_T *pStruct, boolean_T doPush);
static void emxInitStruct_struct2_T(struct2_T *pStruct, boolean_T doPush);
static void emxInitStruct_struct3_T(emlrtCTX aTLS, struct3_T *pStruct, boolean_T
  doPush);
static void emxInitStruct_struct4_T(emlrtCTX aTLS, struct4_T *pStruct, boolean_T
  doPush);
static void emxInitStruct_struct5_T(struct5_T *pStruct);
static void emxInitStruct_struct7_T(struct7_T *pStruct);
static void emxInit_struct6_T_1x5(emxArray_struct6_T_1x5 *pEmxArray);
static void emxTrim_struct0_T(emxArray_struct0_T *emxArray, int32_T fromIndex,
  int32_T toIndex);

/* Function Definitions */
static void emxCopyMatrix_char_T(char_T dst[2], const char_T src[2])
{
  int32_T i;
  for (i = 0; i < 2; i++) {
    dst[i] = src[i];
  }
}

static void emxCopyMatrix_real_T(real_T dst[2], const real_T src[2])
{
  int32_T i;
  for (i = 0; i < 2; i++) {
    dst[i] = src[i];
  }
}

static void emxCopyMatrix_real_T1(real_T dst[5], const real_T src[5])
{
  int32_T i;
  for (i = 0; i < 5; i++) {
    dst[i] = src[i];
  }
}

static void emxCopyMatrix_real_T2(real_T dst[36], const real_T src[36])
{
  int32_T i;
  for (i = 0; i < 36; i++) {
    dst[i] = src[i];
  }
}

static void emxCopyMatrix_real_T3(real_T dst[5], const real_T src[5])
{
  int32_T i;
  for (i = 0; i < 5; i++) {
    dst[i] = src[i];
  }
}

static void emxCopyMatrix_real_T4(real_T dst[6], const real_T src[6])
{
  int32_T i;
  for (i = 0; i < 6; i++) {
    dst[i] = src[i];
  }
}

static void emxCopyMatrix_real_T5(real_T dst[25], const real_T src[25])
{
  int32_T i;
  for (i = 0; i < 25; i++) {
    dst[i] = src[i];
  }
}

static void emxCopyStruct_struct3_T(struct3_T *dst, const struct3_T *src)
{
  emxCopyMatrix_char_T(dst->form, src->form);
  emxCopy_real_T_1x500(&dst->breaks, &src->breaks);
  emxCopy_real_T(&dst->coefs, &src->coefs);
  dst->pieces = src->pieces;
  dst->order = src->order;
  dst->dim = src->dim;
}

static void emxCopyStruct_struct4_T(struct4_T *dst, const struct4_T *src)
{
  emxCopyMatrix_char_T(dst->form, src->form);
  emxCopy_real_T(&dst->breaks, &src->breaks);
  emxCopy_real_T(&dst->coefs, &src->coefs);
  dst->pieces = src->pieces;
  dst->order = src->order;
  dst->dim = src->dim;
}

static void emxCopy_real_T(emxArray_real_T **dst, emxArray_real_T * const *src)
{
  int32_T numElDst;
  int32_T numElSrc;
  int32_T i;
  numElDst = 1;
  numElSrc = 1;
  for (i = 0; i < (*dst)->numDimensions; i++) {
    numElDst *= (*dst)->size[i];
    numElSrc *= (*src)->size[i];
  }

  for (i = 0; i < (*dst)->numDimensions; i++) {
    (*dst)->size[i] = (*src)->size[i];
  }

  emxEnsureCapacity((emxArray__common *)*dst, numElDst, (int32_T)sizeof(real_T));
  for (i = 0; i < numElSrc; i++) {
    (*dst)->data[i] = (*src)->data[i];
  }
}

static void emxCopy_real_T_1x500(emxArray_real_T_1x500 *dst, const
  emxArray_real_T_1x500 *src)
{
  int32_T numElSrc;
  int32_T i;
  numElSrc = 1;
  for (i = 0; i < 2; i++) {
    numElSrc *= src->size[i];
  }

  for (i = 0; i < 2; i++) {
    dst->size[i] = src->size[i];
  }

  for (i = 0; i < numElSrc; i++) {
    dst->data[i] = src->data[i];
  }
}

static void emxCopy_real_T_20x20(emxArray_real_T_20x20 *dst, const
  emxArray_real_T_20x20 *src)
{
  int32_T numElSrc;
  int32_T i;
  numElSrc = 1;
  for (i = 0; i < 2; i++) {
    numElSrc *= src->size[i];
  }

  for (i = 0; i < 2; i++) {
    dst->size[i] = src->size[i];
  }

  for (i = 0; i < numElSrc; i++) {
    dst->data[i] = src->data[i];
  }
}

static void emxCopy_real_T_5x2(emxArray_real_T_5x2 *dst, const
  emxArray_real_T_5x2 *src)
{
  int32_T numElSrc;
  int32_T i;
  numElSrc = 1;
  for (i = 0; i < 2; i++) {
    numElSrc *= src->size[i];
  }

  for (i = 0; i < 2; i++) {
    dst->size[i] = src->size[i];
  }

  for (i = 0; i < numElSrc; i++) {
    dst->data[i] = src->data[i];
  }
}

static void emxCopy_real_T_5x20(emxArray_real_T_5x20 *dst, const
  emxArray_real_T_5x20 *src)
{
  int32_T numElSrc;
  int32_T i;
  numElSrc = 1;
  for (i = 0; i < 2; i++) {
    numElSrc *= src->size[i];
  }

  for (i = 0; i < 2; i++) {
    dst->size[i] = src->size[i];
  }

  for (i = 0; i < numElSrc; i++) {
    dst->data[i] = src->data[i];
  }
}

static void emxCopy_real_T_5x5x20(emxArray_real_T_5x5x20 *dst, const
  emxArray_real_T_5x5x20 *src)
{
  int32_T numElSrc;
  int32_T i;
  numElSrc = 1;
  for (i = 0; i < 3; i++) {
    numElSrc *= src->size[i];
  }

  for (i = 0; i < 3; i++) {
    dst->size[i] = src->size[i];
  }

  for (i = 0; i < numElSrc; i++) {
    dst->data[i] = src->data[i];
  }
}

static void emxCopy_struct5_T(emxArray_struct5_T **dst, emxArray_struct5_T *
  const *src)
{
  int32_T numElDst;
  int32_T numElSrc;
  int32_T i;
  numElDst = 1;
  numElSrc = 1;
  for (i = 0; i < (*dst)->numDimensions; i++) {
    numElDst *= (*dst)->size[i];
    numElSrc *= (*src)->size[i];
  }

  for (i = 0; i < (*dst)->numDimensions; i++) {
    (*dst)->size[i] = (*src)->size[i];
  }

  emxEnsureCapacity_struct5_T(*dst, numElDst);
  for (i = 0; i < numElSrc; i++) {
    (*dst)->data[i] = (*src)->data[i];
  }
}

static void emxExpand_struct0_T(emxArray_struct0_T *emxArray, int32_T fromIndex,
  int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxInitStruct_struct0_T(&emxArray->data[i], false);
  }
}

static void emxExpand_struct5_T(emxArray_struct5_T *emxArray, int32_T fromIndex,
  int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxInitStruct_struct5_T(&emxArray->data[i]);
  }
}

static void emxFreeStruct_struct0_T(struct0_T *pStruct)
{
  emxFreeStruct_struct2_T(&pStruct->el_in0);
}

static void emxFreeStruct_struct2_T(struct2_T *pStruct)
{
  emxFreeStruct_struct3_T(&pStruct->axial);
  emxFreeStruct_struct4_T(&pStruct->axial_k);
  emxFree_struct5_T(&pStruct->nodes);
}

static void emxFreeStruct_struct3_T(struct3_T *pStruct)
{
  emxFree_real_T(&pStruct->coefs);
}

static void emxFreeStruct_struct4_T(struct4_T *pStruct)
{
  emxFree_real_T(&pStruct->breaks);
  emxFree_real_T(&pStruct->coefs);
}

static void emxInitStruct_struct0_T(struct0_T *pStruct, boolean_T doPush)
{
  pStruct->el.size[0] = 0;
  pStruct->el.size[1] = 0;
  emxInitStruct_struct2_T(&pStruct->el_in0, doPush);
}

static void emxInitStruct_struct2_T(struct2_T *pStruct, boolean_T doPush)
{
  emxInitStruct_struct3_T(emlrtRootTLSGlobal, &pStruct->axial, doPush);
  emxInitStruct_struct4_T(emlrtRootTLSGlobal, &pStruct->axial_k, doPush);
  pStruct->alpha.size[0] = 0;
  pStruct->alpha.size[1] = 0;
  pStruct->eps.size[0] = 0;
  pStruct->eps.size[1] = 0;
  pStruct->f.size[0] = 0;
  pStruct->f.size[1] = 0;
  emxInit_struct5_T(emlrtRootTLSGlobal, &pStruct->nodes, 2, doPush);
  emxInitStruct_struct7_T(&pStruct->flex);
}

static void emxInitStruct_struct3_T(emlrtCTX aTLS, struct3_T *pStruct, boolean_T
  doPush)
{
  pStruct->breaks.size[0] = 0;
  pStruct->breaks.size[1] = 0;
  emxInit_real_T(aTLS, &pStruct->coefs, 2, doPush);
}

static void emxInitStruct_struct4_T(emlrtCTX aTLS, struct4_T *pStruct, boolean_T
  doPush)
{
  emxInit_real_T(aTLS, &pStruct->breaks, 2, doPush);
  emxInit_real_T(aTLS, &pStruct->coefs, 2, doPush);
}

static void emxInitStruct_struct5_T(struct5_T *pStruct)
{
  emxInit_struct6_T_1x5(&pStruct->cords);
}

static void emxInitStruct_struct7_T(struct7_T *pStruct)
{
  pStruct->D.size[0] = 0;
  pStruct->D.size[1] = 0;
  pStruct->Du.size[0] = 0;
  pStruct->Du.size[1] = 0;
  pStruct->f.size[0] = 0;
  pStruct->f.size[1] = 0;
  pStruct->f.size[2] = 0;
  pStruct->d.size[0] = 0;
  pStruct->d.size[1] = 0;
  pStruct->e.size[0] = 0;
  pStruct->e.size[1] = 0;
}

static void emxInit_struct6_T_1x5(emxArray_struct6_T_1x5 *pEmxArray)
{
  int32_T i;
  for (i = 0; i < 2; i++) {
    pEmxArray->size[i] = 0;
  }
}

static void emxTrim_struct0_T(emxArray_struct0_T *emxArray, int32_T fromIndex,
  int32_T toIndex)
{
  int32_T i;
  for (i = fromIndex; i < toIndex; i++) {
    emxFreeStruct_struct0_T(&emxArray->data[i]);
  }
}

void emxCopyStruct_struct_T(b_struct_T *dst, const b_struct_T *src)
{
  dst->b_break = src->b_break;
  emxCopyMatrix_real_T(dst->mat, src->mat);
  emxCopyMatrix_real_T1(dst->geom, src->geom);
  emxCopyStruct_struct3_T(&dst->axial, &src->axial);
  emxCopyStruct_struct4_T(&dst->axial_k, &src->axial_k);
  dst->eps0 = src->eps0;
  emxCopyMatrix_real_T2(dst->K0, src->K0);
  dst->p = src->p;
  dst->r = src->r;
  emxCopy_real_T_5x20(&dst->alpha, &src->alpha);
  dst->beta = src->beta;
  emxCopy_real_T_5x2(&dst->eps, &src->eps);
  emxCopy_real_T_5x2(&dst->f, &src->f);
  emxCopy_struct5_T(&dst->nodes, &src->nodes);
  emxCopyMatrix_real_T3(dst->propsLH, src->propsLH);
  emxCopyMatrix_real_T4(dst->D0, src->D0);
  emxCopyMatrix_real_T4(dst->P0, src->P0);
  dst->n = src->n;
  emxCopyStruct_struct_T1(&dst->flex, &src->flex);
  dst->state_it = src->state_it;
  dst->el = src->el;
}

void emxCopyStruct_struct_T1(struct_T *dst, const struct_T *src)
{
  dst->b_break = src->b_break;
  emxCopyMatrix_real_T5(dst->K, src->K);
  emxCopy_real_T(&dst->D, &src->D);
  emxCopy_real_T(&dst->Du, &src->Du);
  emxCopyMatrix_real_T3(dst->Q, src->Q);
  emxCopy_real_T_5x5x20(&dst->f, &src->f);
  emxCopy_real_T_5x20(&dst->d, &src->d);
  emxCopy_real_T_20x20(&dst->e, &src->e);
}

void emxEnsureCapacity(emxArray__common *emxArray, int32_T oldNumel, int32_T
  elementSize)
{
  int32_T newNumel;
  int32_T i;
  void *newData;
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }

  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }

    while (i < newNumel) {
      i <<= 1;
    }

    newData = emlrtCallocMex((uint32_T)i, (uint32_T)elementSize);
    if (emxArray->data != NULL) {
      memcpy(newData, emxArray->data, (uint32_T)(elementSize * oldNumel));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

void emxEnsureCapacity_struct0_T(emxArray_struct0_T *emxArray, int32_T oldNumel)
{
  int32_T elementSize;
  int32_T newNumel;
  int32_T i;
  void *newData;
  elementSize = (int32_T)sizeof(struct0_T);
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }

  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }

    while (i < newNumel) {
      i <<= 1;
    }

    newData = emlrtCallocMex((uint32_T)i, (uint32_T)elementSize);
    if (emxArray->data != NULL) {
      memcpy(newData, (void *)emxArray->data, (uint32_T)(elementSize * oldNumel));
      if (emxArray->canFreeData) {
        emlrtFreeMex((void *)emxArray->data);
      }
    }

    emxArray->data = (struct0_T *)newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }

  if (oldNumel > newNumel) {
    emxTrim_struct0_T(emxArray, newNumel, oldNumel);
  } else {
    if (oldNumel < newNumel) {
      emxExpand_struct0_T(emxArray, oldNumel, newNumel);
    }
  }
}

void emxEnsureCapacity_struct5_T(emxArray_struct5_T *emxArray, int32_T oldNumel)
{
  int32_T elementSize;
  int32_T newNumel;
  int32_T i;
  void *newData;
  elementSize = (int32_T)sizeof(struct5_T);
  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }

  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }

    while (i < newNumel) {
      i <<= 1;
    }

    newData = emlrtCallocMex((uint32_T)i, (uint32_T)elementSize);
    if (emxArray->data != NULL) {
      memcpy(newData, (void *)emxArray->data, (uint32_T)(elementSize * oldNumel));
      if (emxArray->canFreeData) {
        emlrtFreeMex((void *)emxArray->data);
      }
    }

    emxArray->data = (struct5_T *)newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }

  if (oldNumel > newNumel) {
    emxExpand_struct5_T(emxArray, oldNumel, newNumel);
  }
}

void emxFreeStruct_struct_T(b_struct_T *pStruct)
{
  emxFreeStruct_struct3_T(&pStruct->axial);
  emxFreeStruct_struct4_T(&pStruct->axial_k);
  emxFree_struct5_T(&pStruct->nodes);
  emxFreeStruct_struct_T1(&pStruct->flex);
}

void emxFreeStruct_struct_T1(struct_T *pStruct)
{
  emxFree_real_T(&pStruct->D);
  emxFree_real_T(&pStruct->Du);
}

void emxFree_real_T(emxArray_real_T **pEmxArray)
{
  if (*pEmxArray != (emxArray_real_T *)NULL) {
    if (((*pEmxArray)->data != (real_T *)NULL) && (*pEmxArray)->canFreeData) {
      emlrtFreeMex((void *)(*pEmxArray)->data);
    }

    emlrtFreeMex((void *)(*pEmxArray)->size);
    emlrtFreeMex((void *)*pEmxArray);
    *pEmxArray = (emxArray_real_T *)NULL;
  }
}

void emxFree_struct0_T(emxArray_struct0_T **pEmxArray)
{
  int32_T numEl;
  int32_T i;
  if (*pEmxArray != (emxArray_struct0_T *)NULL) {
    if ((*pEmxArray)->data != (struct0_T *)NULL) {
      numEl = 1;
      for (i = 0; i < (*pEmxArray)->numDimensions; i++) {
        numEl *= (*pEmxArray)->size[i];
      }

      for (i = 0; i < numEl; i++) {
        emxFreeStruct_struct0_T(&(*pEmxArray)->data[i]);
      }

      if ((*pEmxArray)->canFreeData) {
        emlrtFreeMex((void *)(*pEmxArray)->data);
      }
    }

    emlrtFreeMex((void *)(*pEmxArray)->size);
    emlrtFreeMex((void *)*pEmxArray);
    *pEmxArray = (emxArray_struct0_T *)NULL;
  }
}

void emxFree_struct5_T(emxArray_struct5_T **pEmxArray)
{
  if (*pEmxArray != (emxArray_struct5_T *)NULL) {
    if (((*pEmxArray)->data != (struct5_T *)NULL) && (*pEmxArray)->canFreeData)
    {
      emlrtFreeMex((void *)(*pEmxArray)->data);
    }

    emlrtFreeMex((void *)(*pEmxArray)->size);
    emlrtFreeMex((void *)*pEmxArray);
    *pEmxArray = (emxArray_struct5_T *)NULL;
  }
}

void emxInitStruct_struct_T(emlrtCTX aTLS, b_struct_T *pStruct, boolean_T doPush)
{
  emxInitStruct_struct3_T(aTLS, &pStruct->axial, doPush);
  emxInitStruct_struct4_T(aTLS, &pStruct->axial_k, doPush);
  pStruct->alpha.size[0] = 0;
  pStruct->alpha.size[1] = 0;
  pStruct->eps.size[0] = 0;
  pStruct->eps.size[1] = 0;
  pStruct->f.size[0] = 0;
  pStruct->f.size[1] = 0;
  emxInit_struct5_T(aTLS, &pStruct->nodes, 2, doPush);
  emxInitStruct_struct_T1(aTLS, &pStruct->flex, doPush);
}

void emxInitStruct_struct_T1(emlrtCTX aTLS, struct_T *pStruct, boolean_T doPush)
{
  emxInit_real_T(aTLS, &pStruct->D, 2, doPush);
  emxInit_real_T(aTLS, &pStruct->Du, 2, doPush);
  pStruct->f.size[0] = 0;
  pStruct->f.size[1] = 0;
  pStruct->f.size[2] = 0;
  pStruct->d.size[0] = 0;
  pStruct->d.size[1] = 0;
  pStruct->e.size[0] = 0;
  pStruct->e.size[1] = 0;
}

void emxInit_real_T(emlrtCTX aTLS, emxArray_real_T **pEmxArray, int32_T
                    numDimensions, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_real_T *)emlrtMallocMex(sizeof(emxArray_real_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(aTLS, (void *)pEmxArray, (void (*)(void *))
      emxFree_real_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (real_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex((uint32_T)(sizeof(int32_T)
    * numDimensions));
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_real_T1(emlrtCTX aTLS, emxArray_real_T **pEmxArray, int32_T
                     numDimensions, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_real_T *)emlrtMallocMex(sizeof(emxArray_real_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(aTLS, (void *)pEmxArray, (void (*)(void *))
      emxFree_real_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (real_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex((uint32_T)(sizeof(int32_T)
    * numDimensions));
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_real_T2(emlrtCTX aTLS, emxArray_real_T **pEmxArray, int32_T
                     numDimensions, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_real_T *)emlrtMallocMex(sizeof(emxArray_real_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(aTLS, (void *)pEmxArray, (void (*)(void *))
      emxFree_real_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (real_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex((uint32_T)(sizeof(int32_T)
    * numDimensions));
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_struct0_T(emxArray_struct0_T **pEmxArray, int32_T numDimensions,
  boolean_T doPush)
{
  emxArray_struct0_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_struct0_T *)emlrtMallocMex(sizeof(emxArray_struct0_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(emlrtRootTLSGlobal, (void *)pEmxArray,
      (void (*)(void *))emxFree_struct0_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (struct0_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex((uint32_T)(sizeof(int32_T)
    * numDimensions));
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void emxInit_struct5_T(emlrtCTX aTLS, emxArray_struct5_T **pEmxArray, int32_T
  numDimensions, boolean_T doPush)
{
  emxArray_struct5_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_struct5_T *)emlrtMallocMex(sizeof(emxArray_struct5_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(aTLS, (void *)pEmxArray, (void (*)(void *))
      emxFree_struct5_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (struct5_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex((uint32_T)(sizeof(int32_T)
    * numDimensions));
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

/* End of code generation (assemble_prebody_emxutil.c) */
