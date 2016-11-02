#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

make e1

echo encaja-e1
./encaja-e1
echo cmp Lenna.ppm binLenna1024.ppm
cmp Lenna.ppm binLenna1024.ppm
