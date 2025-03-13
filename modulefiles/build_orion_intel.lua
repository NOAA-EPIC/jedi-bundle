whatis([===[Loads libraries needed for building JEDI-bundle on Orion ]===])

prepend_path("MODULEPATH", "/work/noaa/epic/role-epic/spack-stack/orion/spack-stack-1.6.0/envs/unified-env-rocky9/install/modulefiles/Core")
--prepend_path("MODULEPATH", "/work/noaa/epic/role-epic/spack-stack/orion/modulefiles")

load("stack-intel/2021.9.0")
load("stack-intel-oneapi-mpi/2021.9.0")
load("stack-python/3.10.13")
load("cmake/3.23.1")

load("jedi-fv3-env/1.0.0")
load("ewok-env/1.0.0")
load("soca-env/1.0.0")

setenv("CFLAGS","-diag-disable=10441")
setenv("FFLAGS","-diag-disable=10441")

setenv("CMAKE_C_COMPILER","mpiicc")
setenv("CMAKE_CXX_COMPILER","mpiicpc")
setenv("CMAKE_Fortran_COMPILER","mpiifort")
setenv("CMAKE_Platform","orion.intel")
