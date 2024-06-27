#!/bin/bash -x

#SBATCH --account=exaww
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16

#SBATCH --output=tgv-%j.out
#SBATCH --error=tgv-%j.out

#SBATCH --time=1:00:00
#SBATCH --partition=devel

#SBATCH --job-name=tgv
#SBATCH --mail-user=bgeihe@uni-koeln.de
#SBATCH --mail-type=all

#SBATCH --disable-turbomode

module purge
module load GCC
module load OpenMPI
module load HDF5/1.14.2


PREFIX=/p/project1/exaww/geihe1/performance-2024-trixi_taylor-green_vortex

JULIA_DEPOT_PATH=${PREFIX}/julia-depot

srun -n "${SLURM_NTASKS}" julia --project=${PREFIX} ${PREFIX}/run.jl

