# (C) Copyright 2024 UCAR
#

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

find_package( ecbuild 3.5 REQUIRED HINTS ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/../ecbuild)

project( jedi-bundle VERSION 8.0.0 LANGUAGES C CXX Fortran )

# Build type.
if(NOT CMAKE_BUILD_TYPE MATCHES "^(Debug|Release|RelWithDebInfo|MinSizeRel)$")
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE
      "Release"
      CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
                                               "MinSizeRel" "RelWithDebInfo")
endif()

# Find dependencies.
find_package(Python3 REQUIRED COMPONENTS Interpreter)

include( ecbuild_bundle )

# Enable OpenMP and MPI
set( ENABLE_MPI ON CACHE BOOL "Compile with MPI" )

# Depend path for non-ecbuild packages
set(DEPEND_LIB_ROOT ${CMAKE_CURRENT_BINARY_DIR}/Depends)
list(APPEND CMAKE_PREFIX_PATH ${DEPEND_LIB_ROOT})

# Library path for non-ecbuild packages
link_directories(${CMAKE_CURRENT_BINARY_DIR}/lib)

include( GNUInstallDirs )
if(APPLE)
  list( APPEND CMAKE_INSTALL_RPATH $ENV{llvm_openmp_ROOT}/lib )
endif()
list( APPEND CMAKE_INSTALL_RPATH ${CMAKE_CURRENT_BINARY_DIR}/fv3 )

# Define bundle
ecbuild_bundle_initialize()

# jedi-cmake
ecbuild_bundle( PROJECT jedicmake GIT "https://github.com/JCSDA/jedi-cmake.git" TAG 36fc99b RECURSIVE )
include( jedicmake/cmake/Functions/git_functions.cmake )

# ECMWF libraries
option("BUNDLE_SKIP_ECKIT" "Don't build eckit" "ON" ) # Skip eckit build unless user passes -DBUNDLE_SKIP_ECKIT=OFF
option("BUNDLE_SKIP_FCKIT" "Don't build fckit" "ON") # Skip fckit build unless user passes -DBUNDLE_SKIP_FCKIT=OFF
option("BUNDLE_SKIP_ATLAS" "Don't build atlas" "ON") # Skip atlas build unless user passes -DBUNDLE_SKIP_ATLAS=OFF

# turn off optional OOPS toy models
option( ENABLE_LORENZ95_MODEL "Build LORENZ95 toy model" OFF )
option( ENABLE_QG_MODEL "Build QG toy model" OFF )

ecbuild_bundle( PROJECT eckit GIT "https://github.com/ecmwf/eckit.git" TAG 1.16.0 )
ecbuild_bundle( PROJECT fckit GIT "https://github.com/ecmwf/fckit.git" TAG 0.9.2 )
ecbuild_bundle( PROJECT atlas GIT "https://github.com/ecmwf/atlas.git" TAG 0.35.0 )

ecbuild_bundle( PROJECT crtm        GIT "https://github.com/JCSDA/crtm.git"                     TAG e477c08 )
ecbuild_bundle( PROJECT gsw         GIT "https://github.com/JCSDA-internal/GSW-Fortran.git"     TAG 697cbeb )
ecbuild_bundle( PROJECT bufr-query  GIT "https://github.com/NOAA-EMC/bufr-query"                TAG 0595878 )
ecbuild_bundle( PROJECT oops        GIT "https://github.com/JCSDA/oops.git"                     TAG 26ccd9c )
ecbuild_bundle( PROJECT vader       GIT "https://github.com/JCSDA/vader.git"                    TAG 70a77f7 )
ecbuild_bundle( PROJECT saber       GIT "https://github.com/JCSDA/saber.git"                    TAG 3fc234c )
option(ENABLE_IODA_DATA "Obtain ioda test data from ioda-data repository (vs tarball)" ON)
ecbuild_bundle( PROJECT ioda-data   GIT "https://github.com/jcsda-internal/ioda-data.git"       BRANCH develop UPDATE )
ecbuild_bundle( PROJECT ioda        GIT "https://github.com/JCSDA/ioda.git"                     TAG c4505cf )
option(ENABLE_UFO_DATA "Obtain ufo test data from ufo-data repository (vs tarball)" ON)
ecbuild_bundle( PROJECT ufo-data    GIT "https://github.com/jcsda-internal/ufo-data.git"        BRANCH develop UPDATE )
ecbuild_bundle( PROJECT ufo         GIT "https://github.com/JCSDA/ufo.git"                      TAG c879fcf )
include(fv3-interface.cmake)
ecbuild_bundle( PROJECT fv3         GIT "https://github.com/JCSDA/GFDL_atmos_cubed_sphere.git"  TAG ab25dc0 )
ecbuild_bundle( PROJECT femps       GIT "https://github.com/JCSDA/femps.git"                    TAG 4f12677 )
ecbuild_bundle( PROJECT fv3-jedi-lm GIT "https://github.com/JCSDA/fv3-jedi-linearmodel.git"     TAG 5994c38 )
option(ENABLE_FV3_JEDI_DATA "Obtain fv3-jedi test data from fv3-jedi-data repository (vs tarball)" ON)
ecbuild_bundle( PROJECT fv3-jedi-data  GIT "https://github.com/jcsda-internal/fv3-jedi-data.git"  BRANCH develop UPDATE )
ecbuild_bundle( PROJECT fv3-jedi    GIT "https://github.com/JCSDA/fv3-jedi.git"                 TAG b792c39 )
#ecbuild_bundle( PROJECT soca        GIT "https://github.com/JCSDA-internal/soca.git"            TAG bdd7828 )
ecbuild_bundle( PROJECT iodaconv    GIT "https://github.com/JCSDA-internal/ioda-converters.git" TAG e5dce25 )

ecbuild_bundle_finalize()

