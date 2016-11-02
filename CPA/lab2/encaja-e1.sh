#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

make -s e1

echo -ne encaja-e1\t\t
./encaja-e1
