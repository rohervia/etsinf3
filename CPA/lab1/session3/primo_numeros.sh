#!/bin/bash
#PBS -l nodes=1,walltime=00:05:00
#PBS -q cpa
#PBS -d .

args="OMP_NUM_THREADS=32"

time ./primo_numeros_seq
time ./primo_numeros_par
