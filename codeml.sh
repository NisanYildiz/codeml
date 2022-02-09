#!/bin/bash -l
#SBATCH -p chimp
#SBATCH -n 1
#SBATCH -t 1-00:00:00
#SBATCH -J codeml
#SBATCH -o slurm-%j-%N-%u.out
#SBATCH -e slurm-%J-%N-%u.err

username=yourNEOGENEusername
codeml=/usr/local/sw/paml4.9e/bin/codeml
controlfile=/mnt/NEOGENE1/home/${username}/codeml/codeml-M1278.ctl

$codeml $controlfile
