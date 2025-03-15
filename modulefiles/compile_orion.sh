#!/bin/bash
set -eux

module purge
set +x
module use ${HOME_DIR}/jedi-bundle/modulefiles
module load orion.intel
set -x
module list

BUILD_DIR="${HOME_DIR}/build"

cd ${BUILD_DIR}
make -j8
