REM Remove dot from PY_VER for use in library name
set MY_PY_VER=%PY_VER:.=%

cmake -G "Ninja" ^
      -Wno-dev ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D "CMAKE_PREFIX_PATH:FILEPATH=%PREFIX%" ^
      -D "CMAKE_INSTALL_PREFIX:FILEPATH=%PREFIX%" ^
      -D "HDF5_ROOT_DIR:FILEPATH=%LIBRARY_PREFIX%" ^
      -D MEDFILE_INSTALL_DOC=OFF ^
      -D MEDFILE_BUILD_PYTHON=ON ^
      -D "PYTHON_LIBRARY:FILEPATH=%PREFIX%\libs\python%MY_PY_VER%.lib" ^
      -D "PYTHON_INCLUDE_DIR:FILEPATH=%PREFIX%\include" -S . -B build

if errorlevel 1 exit 1
cmake --build .\build --config Release
if errorlevel 1 exit 1
cmake --install .\build

DEL /q %PREFIX%\bin\mdump %PREFIX%\bin\xmdump
COPY /y %PREFIX%\bin\mdump4 %PREFIX%\bin\mdump
COPY /y %PREFIX%\bin\xmdump4 %PREFIX%\bin\xmdump
XCOPY /s /e /y %PREFIX%\lib\python%PY_VER%\site-packages\med %SP_DIR%


REM ninja test
REM if errorlevel 1 exit 1

REM move %LIBRARY_PREFIX%\lib\medC.dll %LIBRARY_PREFIX%\bin
REM move %LIBRARY_PREFIX%\lib\medimport.dll %LIBRARY_PREFIX%\bin
