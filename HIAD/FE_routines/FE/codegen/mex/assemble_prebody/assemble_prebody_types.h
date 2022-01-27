/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * assemble_prebody_types.h
 *
 * Code generation for function 'assemble_prebody'
 *
 */

#ifndef __ASSEMBLE_PREBODY_TYPES_H__
#define __ASSEMBLE_PREBODY_TYPES_H__

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T_5x2
#define struct_emxArray_real_T_5x2

struct emxArray_real_T_5x2
{
  real_T data[10];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_real_T_5x2*/

#ifndef typedef_emxArray_real_T_5x2
#define typedef_emxArray_real_T_5x2

typedef struct emxArray_real_T_5x2 emxArray_real_T_5x2;

#endif                                 /*typedef_emxArray_real_T_5x2*/

#ifndef struct_emxArray_real_T_5x20
#define struct_emxArray_real_T_5x20

struct emxArray_real_T_5x20
{
  real_T data[100];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_real_T_5x20*/

#ifndef typedef_emxArray_real_T_5x20
#define typedef_emxArray_real_T_5x20

typedef struct emxArray_real_T_5x20 emxArray_real_T_5x20;

#endif                                 /*typedef_emxArray_real_T_5x20*/

#ifndef struct_emxArray_real_T_1000x2
#define struct_emxArray_real_T_1000x2

struct emxArray_real_T_1000x2
{
  real_T data[2000];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_real_T_1000x2*/

#ifndef typedef_emxArray_real_T_1000x2
#define typedef_emxArray_real_T_1000x2

typedef struct emxArray_real_T_1000x2 emxArray_real_T_1000x2;

#endif                                 /*typedef_emxArray_real_T_1000x2*/

#ifndef typedef_struct6_T
#define typedef_struct6_T

typedef struct {
  emxArray_real_T_1000x2 axial;
} struct6_T;

#endif                                 /*typedef_struct6_T*/

#ifndef struct_emxArray_struct6_T_1x5
#define struct_emxArray_struct6_T_1x5

struct emxArray_struct6_T_1x5
{
  struct6_T data[5];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_struct6_T_1x5*/

#ifndef typedef_emxArray_struct6_T_1x5
#define typedef_emxArray_struct6_T_1x5

typedef struct emxArray_struct6_T_1x5 emxArray_struct6_T_1x5;

#endif                                 /*typedef_emxArray_struct6_T_1x5*/

#ifndef typedef_struct5_T
#define typedef_struct5_T

typedef struct {
  emxArray_struct6_T_1x5 cords;
} struct5_T;

#endif                                 /*typedef_struct5_T*/

#ifndef struct_emxArray_struct5_T
#define struct_emxArray_struct5_T

struct emxArray_struct5_T
{
  struct5_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_struct5_T*/

#ifndef typedef_emxArray_struct5_T
#define typedef_emxArray_struct5_T

typedef struct emxArray_struct5_T emxArray_struct5_T;

#endif                                 /*typedef_emxArray_struct5_T*/

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef struct_emxArray_real_T_1x500
#define struct_emxArray_real_T_1x500

struct emxArray_real_T_1x500
{
  real_T data[500];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_real_T_1x500*/

#ifndef typedef_emxArray_real_T_1x500
#define typedef_emxArray_real_T_1x500

typedef struct emxArray_real_T_1x500 emxArray_real_T_1x500;

#endif                                 /*typedef_emxArray_real_T_1x500*/

#ifndef typedef_struct3_T
#define typedef_struct3_T

typedef struct {
  char_T form[2];
  emxArray_real_T_1x500 breaks;
  emxArray_real_T *coefs;
  real_T pieces;
  real_T order;
  real_T dim;
} struct3_T;

#endif                                 /*typedef_struct3_T*/

#ifndef typedef_struct4_T
#define typedef_struct4_T

typedef struct {
  char_T form[2];
  emxArray_real_T *breaks;
  emxArray_real_T *coefs;
  real_T pieces;
  real_T order;
  real_T dim;
} struct4_T;

#endif                                 /*typedef_struct4_T*/

#ifndef struct_emxArray_real_T_20x20
#define struct_emxArray_real_T_20x20

struct emxArray_real_T_20x20
{
  real_T data[400];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_real_T_20x20*/

#ifndef typedef_emxArray_real_T_20x20
#define typedef_emxArray_real_T_20x20

typedef struct emxArray_real_T_20x20 emxArray_real_T_20x20;

#endif                                 /*typedef_emxArray_real_T_20x20*/

#ifndef struct_emxArray_real_T_5x5x20
#define struct_emxArray_real_T_5x5x20

struct emxArray_real_T_5x5x20
{
  real_T data[500];
  int32_T size[3];
};

#endif                                 /*struct_emxArray_real_T_5x5x20*/

#ifndef typedef_emxArray_real_T_5x5x20
#define typedef_emxArray_real_T_5x5x20

typedef struct emxArray_real_T_5x5x20 emxArray_real_T_5x5x20;

#endif                                 /*typedef_emxArray_real_T_5x5x20*/

#ifndef struct_sSvI19C2FP91p1B9De8D4mG
#define struct_sSvI19C2FP91p1B9De8D4mG

struct sSvI19C2FP91p1B9De8D4mG
{
  real_T b_break;
  real_T K[25];
  emxArray_real_T *D;
  emxArray_real_T *Du;
  real_T Q[5];
  emxArray_real_T_5x5x20 f;
  emxArray_real_T_5x20 d;
  emxArray_real_T_20x20 e;
};

#endif                                 /*struct_sSvI19C2FP91p1B9De8D4mG*/

#ifndef typedef_struct_T
#define typedef_struct_T

typedef struct sSvI19C2FP91p1B9De8D4mG struct_T;

#endif                                 /*typedef_struct_T*/

#ifndef struct_seKG98uHXAYyrMveAy8cXNB
#define struct_seKG98uHXAYyrMveAy8cXNB

struct seKG98uHXAYyrMveAy8cXNB
{
  real_T b_break;
  real_T mat[2];
  real_T geom[5];
  struct3_T axial;
  struct4_T axial_k;
  real_T eps0;
  real_T K0[36];
  real_T p;
  real_T r;
  emxArray_real_T_5x20 alpha;
  real_T beta;
  emxArray_real_T_5x2 eps;
  emxArray_real_T_5x2 f;
  emxArray_struct5_T *nodes;
  real_T propsLH[5];
  real_T D0[6];
  real_T P0[6];
  real_T n;
  struct_T flex;
  boolean_T state_it;
  real_T el;
};

#endif                                 /*struct_seKG98uHXAYyrMveAy8cXNB*/

#ifndef typedef_b_struct_T
#define typedef_b_struct_T

typedef struct seKG98uHXAYyrMveAy8cXNB b_struct_T;

#endif                                 /*typedef_b_struct_T*/

#ifndef struct_emxArray__common
#define struct_emxArray__common

struct emxArray__common
{
  void *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray__common*/

#ifndef typedef_emxArray__common
#define typedef_emxArray__common

typedef struct emxArray__common emxArray__common;

#endif                                 /*typedef_emxArray__common*/

#ifndef struct_emxArray_char_T_1x20
#define struct_emxArray_char_T_1x20

struct emxArray_char_T_1x20
{
  char_T data[20];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_char_T_1x20*/

#ifndef typedef_emxArray_char_T_1x20
#define typedef_emxArray_char_T_1x20

typedef struct emxArray_char_T_1x20 emxArray_char_T_1x20;

#endif                                 /*typedef_emxArray_char_T_1x20*/

#ifndef typedef_struct1_T
#define typedef_struct1_T

typedef struct {
  real_T nodes_ij[6];
  real_T orient_ij[3];
} struct1_T;

#endif                                 /*typedef_struct1_T*/

#ifndef typedef_struct7_T
#define typedef_struct7_T

typedef struct {
  real_T b_break;
  real_T K[25];
  emxArray_real_T_5x20 D;
  emxArray_real_T_5x20 Du;
  real_T Q[5];
  emxArray_real_T_5x5x20 f;
  emxArray_real_T_5x20 d;
  emxArray_real_T_20x20 e;
} struct7_T;

#endif                                 /*typedef_struct7_T*/

#ifndef typedef_struct2_T
#define typedef_struct2_T

typedef struct {
  real_T b_break;
  real_T mat[2];
  real_T geom[5];
  struct3_T axial;
  struct4_T axial_k;
  real_T eps0;
  real_T K0[36];
  real_T p;
  real_T r;
  emxArray_real_T_5x20 alpha;
  real_T beta;
  emxArray_real_T_5x2 eps;
  emxArray_real_T_5x2 f;
  emxArray_struct5_T *nodes;
  real_T propsLH[5];
  real_T D0[6];
  real_T P0[6];
  real_T n;
  struct7_T flex;
  boolean_T state_it;
  real_T el;
} struct2_T;

#endif                                 /*typedef_struct2_T*/

#ifndef typedef_struct0_T
#define typedef_struct0_T

typedef struct {
  emxArray_char_T_1x20 el;
  struct1_T el_in;
  struct2_T el_in0;
} struct0_T;

#endif                                 /*typedef_struct0_T*/

#ifndef struct_emxArray_struct0_T
#define struct_emxArray_struct0_T

struct emxArray_struct0_T
{
  struct0_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_struct0_T*/

#ifndef typedef_emxArray_struct0_T
#define typedef_emxArray_struct0_T

typedef struct emxArray_struct0_T emxArray_struct0_T;

#endif                                 /*typedef_emxArray_struct0_T*/
#endif

/* End of code generation (assemble_prebody_types.h) */
