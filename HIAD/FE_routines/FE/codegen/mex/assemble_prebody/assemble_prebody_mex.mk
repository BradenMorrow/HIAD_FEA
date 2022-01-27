START_DIR = C:\Users\ZECHAR~1.PAL\Desktop\Repos\1115_N~1\HIAD_FE\FE_ROU~1\FE

MATLAB_ROOT = C:\PROGRA~1\MATLAB\R2015b
MAKEFILE = assemble_prebody_mex.mk

include assemble_prebody_mex.mki


SRC_FILES =  \
	assemble_prebody_mexutil.c \
	assemble_prebody_data.c \
	assemble_prebody_initialize.c \
	assemble_prebody_terminate.c \
	assemble_prebody.c \
	assemble_body.c \
	abs.c \
	el3.c \
	mpower.c \
	power.c \
	sqrt.c \
	norm.c \
	cross.c \
	get_quat_R.c \
	get_quat_PHI.c \
	quat_prod.c \
	get_PHI_quat.c \
	asin.c \
	get_R_PHI.c \
	get_S.c \
	eye.c \
	normcfast.c \
	sum.c \
	get_KL_P_flex_shear_iter.c \
	cosd.c \
	sind.c \
	get_GL.c \
	interp1.c \
	diag.c \
	mldivide.c \
	get_KL_P_flex_shear_noniter.c \
	interp1qr.c \
	histc.c \
	get_L.c \
	get_G.c \
	el2.c \
	k1.c \
	el1.c \
	T_beam_3d.c \
	ppval_fast.c \
	el4.c \
	_coder_assemble_prebody_info.c \
	_coder_assemble_prebody_api.c \
	_coder_assemble_prebody_mex.c \
	assemble_prebody_emxutil.c

MEX_FILE_NAME_WO_EXT = assemble_prebody_mex
MEX_FILE_NAME = $(MEX_FILE_NAME_WO_EXT).mexw64
TARGET = $(MEX_FILE_NAME)

SYS_LIBS = 


#
#====================================================================
# gmake makefile fragment for building MEX functions using MSVC
# Copyright 2007-2013 The MathWorks, Inc.
#====================================================================
#
SHELL = cmd
OBJEXT = obj
CC = $(COMPILER)
LD = $(LINKER)
.SUFFIXES: .$(OBJEXT)

OBJLISTC = $(SRC_FILES:.c=.$(OBJEXT))
OBJLIST  = $(OBJLISTC:.cpp=.$(OBJEXT))

ifneq (,$(findstring $(EMC_COMPILER),msvc80 msvc90 msvc100 msvc100free msvc110 msvc120 msvcsdk))
  TARGETMT = $(TARGET).manifest
  MEX = $(TARGETMT)
  STRICTFP = /fp:strict
else
  MEX = $(TARGET)
  STRICTFP = /Op
endif

target: $(MEX)

MATLAB_INCLUDES = /I "$(MATLAB_ROOT)\simulink\include"
MATLAB_INCLUDES+= /I "$(MATLAB_ROOT)\toolbox\shared\simtargets"
SYS_INCLUDE = $(MATLAB_INCLUDES)

# Additional includes

SYS_INCLUDE += /I "$(START_DIR)"
SYS_INCLUDE += /I "$(START_DIR)\codegen\mex\assemble_prebody"
SYS_INCLUDE += /I ".\interface"
SYS_INCLUDE += /I "$(START_DIR)\coro"
SYS_INCLUDE += /I "$(START_DIR)\coro\rotations"
SYS_INCLUDE += /I "$(START_DIR)\el1"
SYS_INCLUDE += /I "$(START_DIR)\el2"
SYS_INCLUDE += /I "$(START_DIR)\el3_flex"
SYS_INCLUDE += /I "$(START_DIR)\el4"
SYS_INCLUDE += /I "C:\Users\zechariah.palmeter\Desktop\Repos\1115_NASA\HIAD_FE\FE_routines\misc_eng\toolbox"
SYS_INCLUDE += /I "$(MATLAB_ROOT)\extern\include"
SYS_INCLUDE += /I "."

DIRECTIVES = $(MEX_FILE_NAME_WO_EXT)_mex.arf
COMP_FLAGS = $(COMPFLAGS) $(OMPFLAGS) -DMX_COMPAT_32
LINK_FLAGS = $(filter-out /export:mexFunction, $(LINKFLAGS))
LINK_FLAGS += /NODEFAULTLIB:LIBCMT
ifeq ($(EMC_CONFIG),optim)
  COMP_FLAGS += $(OPTIMFLAGS) $(STRICTFP)
  LINK_FLAGS += $(LINKOPTIMFLAGS)
else
  COMP_FLAGS += $(DEBUGFLAGS)
  LINK_FLAGS += $(LINKDEBUGFLAGS)
endif
LINK_FLAGS += $(OMPLINKFLAGS)
LINK_FLAGS += /OUT:$(TARGET)
LINK_FLAGS += 

CFLAGS =  $(COMP_FLAGS) $(USER_INCLUDE) $(SYS_INCLUDE)
CPPFLAGS =  $(CFLAGS)

%.$(OBJEXT) : %.c
	$(CC) $(CFLAGS) "$<"

%.$(OBJEXT) : %.cpp
	$(CC) $(CPPFLAGS) "$<"

# Additional sources

%.$(OBJEXT) : $(START_DIR)/%.c
	$(CC) $(CFLAGS) "$<"

%.$(OBJEXT) : $(START_DIR)\codegen\mex\assemble_prebody/%.c
	$(CC) $(CFLAGS) "$<"

%.$(OBJEXT) : interface/%.c
	$(CC) $(CFLAGS) "$<"



%.$(OBJEXT) : $(START_DIR)/%.cpp
	$(CC) $(CPPFLAGS) "$<"

%.$(OBJEXT) : $(START_DIR)\codegen\mex\assemble_prebody/%.cpp
	$(CC) $(CPPFLAGS) "$<"

%.$(OBJEXT) : interface/%.cpp
	$(CC) $(CPPFLAGS) "$<"



$(TARGET): $(OBJLIST) $(MAKEFILE) $(DIRECTIVES)
	$(LD) $(LINK_FLAGS) $(OBJLIST) $(USER_LIBS) $(SYS_LIBS) @$(DIRECTIVES)
	@cmd /C "echo Build completed using compiler $(EMC_COMPILER)"

$(TARGETMT): $(TARGET)
	mt -outputresource:"$(TARGET);2" -manifest "$(TARGET).manifest"

#====================================================================

