#!/bin/bash
#SBATCH -J hello-pace
#SBATCH -A gts-mhale30
#SBATCH -q inferno
#SBATCH -N 1 --ntasks-per-node=4
#SBATCH --mem-per-cpu=4G
#SBATCH --partition=cpu-gnr
#SBATCH --constraint=graniterapids
#SBATCH -t 01:00:00
#SBATCH -o %x-%j.out

cd /storage/home/hcoda1/3/hrao43/r-mhale30-0/demo

module load anaconda3

python hello.py
