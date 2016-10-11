#!/bin/bash
#PBS -l nodes=1,walltime=00:05:00
#PBS -q cpa
#PBS -d .

args="OMP_NUM_THREADS=32"

time ./primo_grande_seq
# time ./primo_grande_par
