#!/bin/bash
set -eux

HOME_DIR="/work/noaa/epic/UFS_Land-DA_v2.1"
JEDI_DIR="${HOME_DIR}/jedi_v8_ic_orion"
BUILD_DIR="${JEDI_DIR}/build"

module purge
set +x
module use ${JEDI_DIR}
module load build_orion_intel
set -x
module list

cd ${BUILD_DIR}
make update
make -j8
