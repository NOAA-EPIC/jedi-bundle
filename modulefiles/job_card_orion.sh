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

/work/noaa/epic/UFS_Land-DA_v2.1/jedi_v8_ic_orion/module_build/compile_orion.sh
