#!/bin/bash

#SBATCH --gpus=1
#SBATCH --partition=stamps-b,mcordgpu-b,livi-b
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=4
#SBATCH --mem=32gb
#SBATCH --time=0-2:00:00
#SBATCH --job-name=python-shape-e

# Adjust the resource requests above to your needs.
# Example of loading modules, CUDA and Python from CCEnv:

# modules for CCEnv Python
module load CCEnv
module load arch/avx512 StdEnv/2023
module load cuda/12.2 cudnn/9.2.1.18
module load python/3.11.5 scipy-stack/2024a

# activate the existing virtualenv with Torch, Shap-e
source shapee/bin/activate

# actually run the code/model
python shap-e-test.py

echo "Job finished with exit code $? at: `date`"
# end of the script

