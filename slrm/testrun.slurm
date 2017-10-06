#!/bin/bash -l
#SBATCH --partition=medium
#SBATCH --job-name=test01
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kingda16@wfu.edu
#SBATCH --account=generalGrp
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH --mem=4gb
#SBATCH --time=0-00:30:00

use-student-matlab -r /deac/generalGrp/gemmerGrp/DAK/code/Opt2D
