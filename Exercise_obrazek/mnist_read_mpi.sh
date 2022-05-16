#!/bin/bash
#PBS -N mnist_read_mpi
#PBS -l select=2:mpiprocs=32
#PBS -l walltime=00:25:00
#PBS -q qexp
#PBS -e mnist_read_mpi.e
#PBS -o mnist_read_mpi.o

cd ~/KPMS-IT4I-EX/mpi
pwd

module load R
echo "loaded R"

## prevent warning when fork is used with MPI
export OMPI_MCA_mpi_warn_on_fork=0
export RDMAV_FORK_SAFE=1

## Fix for warnings from libfabric/1.12 bug
module swap libfabric/1.12.1-GCCcore-10.3.0 libfabric/1.13.2-GCCcore-11.2.0 

## mpiprocs = select*ppr
## 128 = ppr*blas*fork
## --args blas fork
time mpirun --map-by ppr:1:node Rscript mnist_read_mpi.R
time mpirun --map-by ppr:2:node Rscript mnist_read_mpi.R
time mpirun --map-by ppr:4:node Rscript mnist_read_mpi.R
time mpirun --map-by ppr:8:node Rscript mnist_read_mpi.R


