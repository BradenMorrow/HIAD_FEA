@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=assemble_prebody_mex
set MEX_NAME=assemble_prebody_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for assemble_prebody > assemble_prebody_mex.mki
echo COMPILER=%COMPILER%>> assemble_prebody_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> assemble_prebody_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> assemble_prebody_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> assemble_prebody_mex.mki
echo LINKER=%LINKER%>> assemble_prebody_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> assemble_prebody_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> assemble_prebody_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> assemble_prebody_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> assemble_prebody_mex.mki
echo BORLAND=%BORLAND%>> assemble_prebody_mex.mki
echo OMPFLAGS=/openmp >> assemble_prebody_mex.mki
echo OMPLINKFLAGS=/nodefaultlib:vcomp /LIBPATH:"C:\PROGRA~1\MATLAB\R2015b\bin\win64" >> assemble_prebody_mex.mki
echo EMC_COMPILER=msvc120>> assemble_prebody_mex.mki
echo EMC_CONFIG=optim>> assemble_prebody_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f assemble_prebody_mex.mk
