#!/bin/bash
export CLICOLOR_FORCE=1

export FCFLAGS="-fdefault-integer-8 ${FCFLAGS}"
export FFLAGS="-fdefault-integer-8 ${FFLAGS}"
export CXXFLAGS="-std=gnu++98 ${CXXFLAGS}"

echo "PYTHON=${PYTHON}"
echo "PY_VER=${PY_VER}"
echo "SP_DIR=${SP_DIR}"
echo "STDLIB_DIR=${STDLIB_DIR}"

#if [[ "$mpi" == "nompi" ]]; then
  export F77=${FC}
  echo "Compiling for Sequential MPI=$mpi"
#else
#  echo "Compiling for MPI=$mpi"
#  export OPAL_PREFIX=$PREFIX
#  export CC=mpicc
#  export CXX=mpicxx
#  export FC=mpif90
#  export F77=mpif77
#  export F90=mpif90
#fi

opts=("--with-swig=yes" )

if [[ "${PKG_DEBUG}" == "True" ]]; then
    echo "Debugging Enabled"
    # Set compiler flags for debugging, for instance
    export CFLAGS="-g -O0 ${CFLAGS}"
    export CXXFLAGS="-g -O0 ${CXXFLAGS}"
    export FCFLAGS="-g -O0 ${FCFLAGS}"
    opts+=( "--enable-mesgerr" )
    # Additional debug build steps
else
    echo "Debugging Disabled"
    # Set compiler flags for production
    opts+=( "--disable-mesgerr" )
    # Additional production build steps
fi

chmod +x ./configure
./configure "${opts[@]}" --prefix="$PREFIX" --with-hdf5="$PREFIX"
make
make install

rm -rf "${PREFIX}/share/doc/med"