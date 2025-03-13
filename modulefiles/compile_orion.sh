#!/bin/bash
set -eux

HOME_DIR="/work/noaa/epic/UFS_Land-DA_v2.1"
JEDI_DIR="${HOME_DIR}/jedi_bundle/modulefiles"
BUILD_DIR="${HOME_DIR}/build"

module purge
set +x
module use ${JEDI_DIR}
module load build_orion_intel
set -x
module list

cd ${BUILD_DIR}
make update
make -j8
