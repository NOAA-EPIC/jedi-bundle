# (C) Copyright 2025 UCAR
#

cmake_minimum_required( VERSION 3.14 FATAL_ERROR )

find_package( ecbuild 3.6 REQUIRED HINTS ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/../ecbuild)

project( jedi-bundle VERSION 8.0.0 LANGUAGES C CXX Fortran )

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include( ecbuild_bundle )

# Default release mode
set( ECBUILD_DEFAULT_BUILD_TYPE Release )

# Enable OpenMP and MPI
set( ENABLE_MPI ON CACHE BOOL "Compile with MPI" )
set( ENABLE_OMP ON CACHE BOOL "Compile with OpenMP" )

# Stop search as soon as Python satisfying version constraints is found.
set( Python3_FIND_STRATEGY LOCATION )

# Depend path for non-ecbuild packages
set(DEPEND_LIB_ROOT ${CMAKE_CURRENT_BINARY_DIR}/Depends)
list(APPEND CMAKE_PREFIX_PATH ${DEPEND_LIB_ROOT})

# Library path for non-ecbuild packages
link_directories(${CMAKE_CURRENT_BINARY_DIR}/lib)

include( GNUInstallDirs )
if(APPLE)
  list( APPEND CMAKE_INSTALL_RPATH $ENV{llvm_openmp_ROOT}/lib )
endif()

# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)

# when building, already use the install RPATH
set(CMAKE_BUILD_WITH_INSTALL_RPATH ON)

# Define bundle
ecbuild_bundle_initialize()

# Use external jedi-cmake
include( $ENV{jedi_cmake_ROOT}/share/jedicmake/Functions/git_functions.cmake )

#ecbuild_bundle( PROJECT eckit    GIT "https://github.com/ecmwf/eckit.git" TAG 1.24.4 )
#ecbuild_bundle( PROJECT fckit    GIT "https://github.com/ecmwf/fckit.git" TAG 0.11.0 )
#ecbuild_bundle( PROJECT atlas    GIT "https://github.com/ecmwf/atlas.git" TAG 0.35.0 )

option(BUILD_GSIBEC "Build GSIbec" ON)
if(BUILD_GSIBEC)
  ecbuild_bundle( PROJECT gsibec   GIT "https://github.com/geos-esm/GSIbec" TAG 1.2.1 )
endif()

ecbuild_bundle( PROJECT gsw             GIT "https://github.com/JCSDA-internal/GSW-Fortran.git"     TAG 697cbeb )
ecbuild_bundle( PROJECT oops            GIT "https://github.com/JCSDA/oops.git"                     TAG bb22419 )

ecbuild_bundle( PROJECT jedi-model-data GIT "https://github.com/jcsda-internal/jedi-model-data.git" TAG c3c19b0 )
ecbuild_bundle( PROJECT vader           GIT "https://github.com/JCSDA/vader.git"                    TAG 699fcb8 )
ecbuild_bundle( PROJECT saber           GIT "https://github.com/JCSDA/saber.git"                    TAG e8239b2 )

ecbuild_bundle( PROJECT crtm            GIT "https://github.com/JCSDA/crtm.git"                     TAG e477c08 )

option(ENABLE_IODA_DATA "Obtain ioda test data from ioda-data repository (vs tarball)" ON)
ecbuild_bundle( PROJECT ioda-data GIT "https://github.com/jcsda-internal/ioda-data.git"  BRANCH develop UPDATE )
ecbuild_bundle( PROJECT ioda      GIT "https://github.com/JCSDA/ioda.git"                TAG b31101a )

option(ENABLE_UFO_DATA "Obtain ufo test data from ufo-data repository (vs tarball)" ON)
ecbuild_bundle( PROJECT ufo-data GIT "https://github.com/jcsda-internal/ufo-data.git"    BRANCH develop UPDATE )
ecbuild_bundle( PROJECT ufo      GIT "https://github.com/JCSDA/ufo.git"                  TAG 73ba0b8 )

# Build IODA converters if requested
option(BUILD_IODA_CONVERTERS "Build IODA Converters" ON)
if(BUILD_IODA_CONVERTERS)
  ecbuild_bundle( PROJECT iodaconv GIT "https://github.com/JCSDA-internal/ioda-converters.git" TAG 7153965 )
endif()

ecbuild_bundle( PROJECT femps       GIT "https://github.com/jcsda/femps.git"                    BRANCH develop UPDATE )
ecbuild_bundle( PROJECT fv3-jedi-lm GIT "https://github.com/JCSDA/fv3-jedi-linearmodel.git"     TAG 5994c38 )

option(ENABLE_FV3_JEDI_DATA "Obtain fv3-jedi test data from fv3-jedi-data repository (vs tarball)" ON)
ecbuild_bundle( PROJECT fv3-jedi-data  GIT "https://github.com/jcsda-internal/fv3-jedi-data.git"   TAG 60d1ced )
ecbuild_bundle( PROJECT fv3-jedi       GIT "https://github.com/JCSDA/fv3-jedi.git"                 TAG aa629af )

ecbuild_bundle( PROJECT soca           GIT "https://github.com/JCSDA/soca.git"                     TAG bb7b1e1 RECURSIVE )

# Build GDAS utils
ecbuild_bundle( PROJECT gdas-utils SOURCE "./sorc/gdas-utils" )

ecbuild_bundle_finalize()

