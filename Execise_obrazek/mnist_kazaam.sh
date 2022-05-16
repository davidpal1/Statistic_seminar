#!/bin/bash
#PBS -N mnist_kazaam
#PBS -l select=1:mpiprocs=32
#PBS -l walltime=00:25:00
#PBS -q qexp
#PBS -e mnist_kazaam.e
#PBS -o mnist_kazaam.o

cd ~/KPMS-IT4I-EX/mpi
pwd

module load R
echo "loaded R"

## prevent warning when fork is used with MPI
export OMPI_MCA_mpi_warn_on_fork=0
export RDMAV_FORK_SAFE=1

## Fix for warnings from libfabric/1.12 bug
module swap libfabric/1.12.1-GCCcore-10.3.0 libfabric/1.13.2-GCCcore-11.2.0 

time mpirun --map-by ppr:16:node Rscript mnist_kazaam.R --args 1 16


