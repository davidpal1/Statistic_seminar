#!/bin/bash
#PBS -N mnist_rsvd
#PBS -l select=1:mpiprocs=32
#PBS -l walltime=00:15:00
#PBS -q qexp
#PBS -e mnist_rsvd.e
#PBS -o mnist_rsvd.o

cd ~/Statistic_seminar/Exercise_obrazek
pwd

module load R
echo "loaded R"

## prevent warning when fork is used with MPI
export OMPI_MCA_mpi_warn_on_fork=0
export RDMAV_FORK_SAFE=1
## Fix for warnings from libfabric/1.12 bug
module swap libfabric/1.12.1-GCCcore-10.3.0 libfabric/1.13.2-GCCcore


## --args blas fork
echo -e "\n>>>>>>>> read and pbdML rsvd" >&2
time mpirun --map-by ppr:1:node Rscript mnist_rsvd.R

echo -e "\n>>>>>>>> read and pbdML rsvd" >&2
time mpirun --map-by ppr:2:node Rscript mnist_rsvd.R

echo -e "\n>>>>>>>> read and pbdML rsvd" >&2
time mpirun --map-by ppr:4:node Rscript mnist_rsvd.R

echo -e "\n>>>>>>>> read and pbdML rsvd" >&2
time mpirun --map-by ppr:8:node Rscript mnist_rsvd.R

echo -e "\n>>>>>>>> read and pbdML rsvd" >&2
time mpirun --map-by ppr:16:node Rscript mnist_rsvd.R

echo -e "\n>>>>>>>> read and pbdML rsvd" >&2
time mpirun --map-by ppr:32:node Rscript mnist_rsvd.R