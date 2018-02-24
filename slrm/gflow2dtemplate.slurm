#!/bin/bash -l
#SBATCH --partition=medium
#SBATCH --job-name=gflow
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=kingda16@wfu.edu
#SBATCH --account=generalGrp
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH --mem=4gb
#SBATCH --time=0-23:40:00



cd /deac/generalGrp/gemmerGrp/DAK/code/2d
module load matlab-2017a
use-student-matlab -r "gflow2d(0.666666666667,0.194,100,50,0.03,seedgen(100,'trig',1,1),'')"
