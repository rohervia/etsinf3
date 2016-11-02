#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

make -s e4

echo -ne encaja-e4-pJ\t\t
./encaja-e4-pJ

echo -ne encaja-e4-pX\t\t
./encaja-e4-pX
