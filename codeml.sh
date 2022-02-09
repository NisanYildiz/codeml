#!/bin/bash -l
#SBATCH -p chimp
#SBATCH -n 1
#SBATCH -t 1-00:00:00
#SBATCH -J codeml
#SBATCH -o slurm-%j-%N-%u.out
#SBATCH -e slurm-%J-%N-%u.err

codeml=/usr/local/sw/paml4.9e/bin/codeml
controlDir=/mnt/NEOGENE1/home/${username}/codeml
controlfile=${controlDir}/codeml-M1278.ctl

$codeml $controlfile
