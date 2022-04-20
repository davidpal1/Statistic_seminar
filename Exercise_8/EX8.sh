#!/bin/bash
#PBS -N mnist_svd_mv
#PBS -l select=1:ncpus=128,walltime=00:50:00
#PBS -q qexp
#PBS -e mnist_svd_mv.e
#PBS -o mnist_svd_mv.o

cd ~/Statistic_seminar/Exercise_8
pwd

module load R
echo "loaded R"
module swap libfabric/1.12.1-GCCcore-10.3.0 libfabric/1.13.2-GCCcore-11.2.0

time Rscript mnist_svd_mv.R


