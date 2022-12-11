@echo ON

:: Finds stdint.h from msinttypes.
set INCLUDE=%LIBRARY_INC%;%INCLUDE%
set LIB=%LIBRARY_LIB%;%LIB%
set LIBPATH=%LIBRARY_LIB%;%LIBPATH%

cd win

nmake /f Makefile.msc ^
  FOSSIL_DYNAMIC_BUILD=1 ^
  FOSSIL_ENABLE_SSL=1 ^
  FOSSIL_ENABLE_JSON=1 ^
  FOSSIL_ENABLE_TCL=1 ^
  FOSSIL_BUILD_ZLIB=0 ^
  PERLDIR=%PREFIX%\Library\bin
if errorlevel 1 exit 1

md %SCRIPTS% | echo "%SCRIPTS% already exists"
dir

copy fossil.exe %SCRIPTS%\fossil.exe
if errorlevel 1 exit 1
