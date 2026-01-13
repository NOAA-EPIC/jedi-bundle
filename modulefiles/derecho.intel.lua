help([[
Load environment for JEDI-bundle with Intel compilers and MPI.
]])

prepend_path("MODULEPATH", '/glade/work/epicufsrt/contrib/spack-stack/derecho/spack-stack-1.9.3/envs/ue-oneapi-2024.2.1/install/modulefiles/Core')

load("stack-oneapi/2024.2.1")
load("stack-python/3.11.7")
load("stack-cray-mpich/8.1.29")
load("jedi-mpas-env/1.0.0")
load("jedi-fv3-env/1.0.0")
load("soca-env/1.0.0")

cmake_ver=os.getenv("cmake_ver") or "3.27.9"
load(pathJoin("cmake", cmake_ver))

ecbuild_ver=os.getenv("ecbuild_ver") or "3.7.2"
load(pathJoin("ecbuild", ecbuild_ver))

--setenv("CC", "mpicc")
--setenv("CXX", "mpicxx")
--setenv("FC", "mpif90")
--setenv("I_MPI_CC", "icx")
--setenv("I_MPI_CXX", "icpx")
--setenv("I_MPI_F90", "ifx")
--setenv("CMAKE_Platform", "derecho.intel")
