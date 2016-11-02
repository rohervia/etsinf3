#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

make -s e3

echo -ne encaja-e3\t\t
./encaja-e3
