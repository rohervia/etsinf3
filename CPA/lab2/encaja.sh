#!/bin/bash
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -d .

echo encaja-seq
./encaja-seq
echo cmp Lenna.ppm binLenna1024.ppm
cmp Lenna.ppm binLenna1024.ppm
echo -e \n\nencaja-par1
./encaja-par1
echo cmp Lenna.ppm binLenna1024.ppm
cmp Lenna.ppm binLenna1024.ppm
echo -e \n\nencaja-par2
./encaja-par2
echo cmp Lenna.ppm binLenna1024.ppm
cmp Lenna.ppm binLenna1024.ppm
echo -e \n
