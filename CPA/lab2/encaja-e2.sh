#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

make e2

echo ./encaja-e2-pJ
./encaja-e2-pJ
echo cmp Lenna.ppm binLenna1024.ppm
cmp Lenna.ppm binLenna1024.ppm

echo ''

echo ./encaja-e2-pX
./encaja-e2-pX
echo cmp Lenna.ppm binLenna1024.ppm
cmp Lenna.ppm binLenna1024.ppm
echo ''
