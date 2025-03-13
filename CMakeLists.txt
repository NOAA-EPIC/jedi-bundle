# (C) Copyright 2024 UCAR
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

# Define bundle
ecbuild_bundle_initialize()

# add the automatically determined parts of the RPATH
# which point to directories outside the build tree to the install RPATH
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH ON)

# when building, already use the install RPATH
set(CMAKE_BUILD_WITH_INSTALL_RPATH ON)

# Use external jedi-cmake
include( $ENV{jedi_cmake_ROOT}/share/jedicmake/Functions/git_functions.cmake )

#ecbuild_bundle( PROJECT eckit    GIT "https://github.com/ecmwf/eckit.git" TAG 1.24.4 )
#ecbuild_bundle( PROJECT fckit    GIT "https://github.com/ecmwf/fckit.git" TAG 0.11.0 )
#ecbuild_bundle( PROJECT atlas    GIT "https://github.com/ecmwf/atlas.git" TAG 0.35.0 )

ecbuild_bundle( PROJECT crtm        GIT "https://github.com/JCSDA/crtm.git"                     TAG bb7adbf )
ecbuild_bundle( PROJECT gsw         GIT "https://github.com/JCSDA-internal/GSW-Fortran.git"     TAG 697cbeb )
ecbuild_bundle( PROJECT bufr-query  GIT "https://github.com/NOAA-EMC/bufr-query"                TAG 97367fc )
ecbuild_bundle( PROJECT oops        GIT "https://github.com/JCSDA/oops.git"                     TAG 215f2de )
ecbuild_bundle( PROJECT vader       GIT "https://github.com/JCSDA/vader.git"                    TAG 27bb498 )
ecbuild_bundle( PROJECT saber       GIT "https://github.com/JCSDA/saber.git"                    TAG 379cc26 )
ecbuild_bundle( PROJECT ioda        GIT "https://github.com/JCSDA/ioda.git"                     TAG 28269a0 )
ecbuild_bundle( PROJECT ufo         GIT "https://github.com/JCSDA/ufo.git"                      TAG 5ec987f )
ecbuild_bundle( PROJECT fv3         GIT "https://github.com/JCSDA/GFDL_atmos_cubed_sphere.git"  TAG ab25dc0 )
ecbuild_bundle( PROJECT femps       GIT "https://github.com/JCSDA/femps.git"                    TAG 4f12677 )
ecbuild_bundle( PROJECT fv3-jedi-lm GIT "https://github.com/JCSDA/fv3-jedi-linearmodel.git"     TAG 5994c38 )
ecbuild_bundle( PROJECT fv3-jedi    GIT "https://github.com/JCSDA/fv3-jedi.git"                 TAG 9ca9320 )
ecbuild_bundle( PROJECT soca        GIT "https://github.com/JCSDA-internal/soca.git"            TAG bdd7828 )
ecbuild_bundle( PROJECT iodaconv    GIT "https://github.com/JCSDA-internal/ioda-converters.git" TAG cdab772 )

ecbuild_bundle_finalize()

