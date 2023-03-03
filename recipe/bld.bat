mkdir build
cd build

cmake -G "Ninja" ^
      -D CMAKE_BUILD_TYPE=Release ^
      -D CMAKE_PREFIX_PATH:FILEPATH=%PREFIX% ^
      -D CMAKE_INSTALL_PREFIX:FILEPATH=%LIBRARY_PREFIX% ^
      -D HDF5_ROOT_DIR:FILEPATH=%LIBRARY_PREFIX% ^
      -D MEDFILE_INSTALL_DOC=OFF ^
      -D MEDFILE_BUILD_PYTHON=ON ^
      -D PYTHON_LIBRARY:FILEPATH=%PREFIX%\libs ^
      -D PYTHON_INCLUDE_DIR:FILEPATH=%PREFIX%\include ^
      ..

if errorlevel 1 exit 1
ninja install
if errorlevel 1 exit 1
REM ninja test
REM if errorlevel 1 exit 1

move %LIBRARY_PREFIX%\lib\medC.dll %LIBRARY_PREFIX%\bin
move %LIBRARY_PREFIX%\lib\medimport.dll %LIBRARY_PREFIX%\bin
