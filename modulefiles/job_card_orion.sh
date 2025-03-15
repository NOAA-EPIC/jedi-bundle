#!/bin/sh
#SBATCH -e build.err
#SBATCH -o build.out
#SBATCH --account=epic
#SBATCH --qos=batch
#SBATCH --partition=orion
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --time=02:00:00
#SBATCH --job-name="build_jedi"

export HOME_DIR="/work/noaa/epic/UFS_Land-DA_v2.1/jedi_bundle_orion"
sh ${HOME_DIR}/jedi-bundle/modulefiles/compile_orion.sh
