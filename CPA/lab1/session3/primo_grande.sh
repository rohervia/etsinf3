#!/bin/bash
#PBS -l nodes=1,walltime=00:05:00
#PBS -q cpa
#PBS -d .

make primo_grande

time ./primo_grande_seq
time ./primo_grande_par
