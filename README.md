# PACE_tutorial_CORE_Lab

Getting-started materials for CORE Lab members using Georgia Tech's **PACE** (Partnership for an Advanced Computing Environment) cluster.

## Contents

- `PACE discussion.pptx` — slide deck covering PACE accounts, Phoenix cluster basics, storage, and the Slurm workflow.
- `ros2_humble_on_pace_complete_guide.pdf` — step-by-step guide for running ROS 2 Humble on PACE (container-based setup).
- `demo_script/` — minimal, working Slurm examples:
  - `hello.py` — "Hello CORE Lab!" sanity-check script.
  - `demo_cpu.sbatch` — single-node CPU job on the `cpu-gnr` (Granite Rapids) partition.
  - `train.py` — small PyTorch MLP trained on `sklearn` digits; takes `lr` and a task id as CLI args.
  - `demo_gpu.sbatch` — GPU job **array** (1–10) on `gpu-rtx6000` that sweeps 10 learning rates over `train.py`.

## Quick start

1. Log in to PACE: `ssh <gt-username>@login-phoenix.pace.gatech.edu`
2. Copy the demo scripts into your project storage (e.g. `~/scratch/demo/` or your lab allocation directory).
3. Edit the `#SBATCH -A`, working directory, and conda environment lines in the `.sbatch` files to match your account and setup.
4. Submit a job:
   ```bash
   sbatch demo_cpu.sbatch        # CPU hello-world
   sbatch demo_gpu.sbatch        # GPU array job (LR sweep)
   ```
5. Check status / output:
   ```bash
   squeue -u $USER
   cat <jobname>-<jobid>.out
   ```

## Prerequisites

- An active PACE account and a charge account (the demos use `gts-mhale30` — replace with your own).
- For the GPU demo: a conda environment named `torch-env` with `torch` and `scikit-learn` installed. Create one with:
  ```bash
  module load anaconda3
  conda create -n torch-env python=3.11 pytorch scikit-learn -c pytorch -c conda-forge
  ```

## References

- PACE documentation: <https://docs.pace.gatech.edu/>
- Slurm quick reference: <https://slurm.schedmd.com/pdfs/summary.pdf>
