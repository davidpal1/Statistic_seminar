#!/bin/bash
#PBS -N rf
#PBS -l select=1:ncpus=128,walltime=00:05:00
#PBS -q qexp
#PBS -e rfp.e
#PBS -o rfp.o

cd ~/Statistic_seminar/Exercise_4
pwd

module load R
echo "loaded R"


time Rscript EX4pokus.r 32
time Rscript EX4pokus.r 64
time Rscript EX4pokus.r 128
