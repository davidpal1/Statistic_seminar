#!/bin/bash
#PBS -N rf
#PBS -l select=1:ncpus=128,walltime=00:05:00
#PBS -q qexp
#PBS -e rf.e
#PBS -o rf.o

cd ~/Statistic_seminar/Exercise_4
pwd

module load R
echo "loaded R"

time Rscript rf_serial.r
time Rscript EX4.r 1
time Rscript EX4.r 2
time Rscript EX4.r 4
time Rscript EX4.r 8
time Rscript EX4.r 16
time Rscript EX4.r 32
time Rscript EX4.r 64
time Rscript EX4.r 128
