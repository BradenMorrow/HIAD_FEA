@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2015b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=interp_fast_mex
set MEX_NAME=interp_fast_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for interp_fast > interp_fast_mex.mki
echo COMPILER=%COMPILER%>> interp_fast_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> interp_fast_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> interp_fast_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> interp_fast_mex.mki
echo LINKER=%LINKER%>> interp_fast_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> interp_fast_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> interp_fast_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> interp_fast_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> interp_fast_mex.mki
echo BORLAND=%BORLAND%>> interp_fast_mex.mki
echo OMPFLAGS= >> interp_fast_mex.mki
echo OMPLINKFLAGS= >> interp_fast_mex.mki
echo EMC_COMPILER=msvc120>> interp_fast_mex.mki
echo EMC_CONFIG=optim>> interp_fast_mex.mki
"C:\Program Files\MATLAB\R2015b\bin\win64\gmake" -B -f interp_fast_mex.mk
