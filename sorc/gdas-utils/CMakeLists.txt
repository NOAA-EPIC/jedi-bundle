<<<<<<< HEAD
################################################################################
# GDAS-UTILS
################################################################################

cmake_minimum_required( VERSION 3.12 )
project( gdas-utils VERSION 0.0.1 LANGUAGES C CXX )

find_package( ecbuild 3.3.2 REQUIRED )
include( ecbuild_system NO_POLICY_SCOPE )
ecbuild_declare_project()

list( APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake )

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_FORTRAN_STANDARD 08)
set(CMAKE_FORTRAN_STANDARD_REQUIRED ON)
set(CMAKE_FORTRAN_EXTENSIONS OFF)

find_package(NetCDF REQUIRED COMPONENTS CXX)
find_package(oops REQUIRED)
find_package(atlas REQUIRED)
find_package(soca REQUIRED)
find_package(fv3jedi REQUIRED)

add_subdirectory(soca)
add_subdirectory(ioda_example)
add_subdirectory(fv3jedi)
add_subdirectory(chem)
add_subdirectory(land)
