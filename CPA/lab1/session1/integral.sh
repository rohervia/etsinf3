#!/bin/bash
#PBS -l nodes=1,walltime=00:05:00
#PBS -q cpa
#PBS -d .

./integral-seq 1 1000000000
OMP_NUM_THREADS=32 ./integral-par 1 1000000000

