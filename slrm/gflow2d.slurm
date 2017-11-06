#!/bin/bash -l
#SBATCH --partition=medium
#SBATCH --job-name=gflow1
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kingda16@wfu.edu
#SBATCH --account=generalGrp
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH --mem=4gb
#SBATCH --time=0-23:30:00



cd /deac/generalGrp/gemmerGrp/DAK/code/2d
module load matlab-2017a
use-student-matlab -r gflow2d
