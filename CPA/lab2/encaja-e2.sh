#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

make -s e2

echo -ne encaja-e2-pJ\t\t
./encaja-e2-pJ

echo -ne encaja-e2-pX\t\t
./encaja-e2-pX
