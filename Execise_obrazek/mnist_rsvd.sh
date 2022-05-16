#!/bin/bash
#PBS -N mnist_rsvd
#PBS -l select=1:ncpus=128,walltime=00:50:00
#PBS -q qexp
#PBS -e mnist_rsvd.e
#PBS -o mnist_rsvd.o

cd ~/KPMS-IT4I-EX/mpi
pwd

module load R
echo "loaded R"

## --args blas fork
time Rscript mnist_svd_cv.R --args 4 32
