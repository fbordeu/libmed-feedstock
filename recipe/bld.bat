REM Remove dot from PY_VER for use in library name
set MY_PY_VER=%PY_VER:.=%

mkdir build
cd build

cmake -G "Ninja" ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D "CMAKE_PREFIX_PATH:FILEPATH=%PREFIX%" ^
      -D "CMAKE_INSTALL_PREFIX:FILEPATH=%PREFIX%" ^
      -D "HDF5_ROOT_DIR:FILEPATH=%LIBRARY_PREFIX%" ^
      -D MEDFILE_INSTALL_DOC=OFF ^
      -D MEDFILE_BUILD_PYTHON=ON ^
      -D "PYTHON_EXECUTABLE:FILEPATH=%PYTHON%" ^
      -D "PYTHON_INCLUDE_DIR:PATH=%PREFIX%\include" ^
      -D "PYTHON_LIBRARY:FILEPATH=%PREFIX%\libs\python%MY_PY_VER%.lib" ^
      -D PYTHON_INCLUDE_DIR:FILEPATH=%PREFIX%\include -S . -B build

if errorlevel 1 exit 1
cmake --build .\build --config Release
if errorlevel 1 exit 1
cmake --install .\build
REM ninja test
REM if errorlevel 1 exit 1

move %LIBRARY_PREFIX%\lib\medC.dll %LIBRARY_PREFIX%\bin
move %LIBRARY_PREFIX%\lib\medimport.dll %LIBRARY_PREFIX%\bin
