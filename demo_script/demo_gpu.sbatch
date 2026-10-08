#!/bin/bash
#SBATCH -J demo-gpu
#SBATCH -A gts-mhale30
#SBATCH -q inferno
#SBATCH -p gpu-rtx6000
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH -t 00:10:00
#SBATCH --array=1-10
#SBATCH -o logs/%x-%A_%a.out

module load anaconda3
eval "$(conda shell.bash hook)"
conda activate torch-env

# Each array task picks its own learning rate
LRS=(0.0001 0.0003 0.001 0.003 0.01 0.03 0.1 0.3 0.5 1.0)
LR=${LRS[$SLURM_ARRAY_TASK_ID-1]}

python train.py $LR $SLURM_ARRAY_TASK_ID