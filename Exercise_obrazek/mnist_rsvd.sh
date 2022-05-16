#!/bin/bash
#PBS -N mnist_rsvd
#PBS -l select=1:ncpus=128,walltime=00:15:00
#PBS -q qexp
#PBS -e mnist_rsvd.e
#PBS -o mnist_rsvd.o

cd ~/Statistic_seminar/Exercise_obrazek
pwd

module load R
echo "loaded R"

## --args blas fork
time Rscript mnist_rsvd.R --args 4 8
time Rscript mnist_rsvd.R --args 4 16
time Rscript mnist_rsvd.R --args 4 32
time Rscript mnist_rsvd.R --args 4 64
time Rscript mnist_rsvd.R --args 4 128

time mpirun --map-by ppr:8:node Rscript mnist_rsvd.R

