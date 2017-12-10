#!/bin/bash -l
#SBATCH --partition=medium
#SBATCH --job-name=gflow
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kingda16@wfu.edu
#SBATCH --account=generalGrp
#SBATCH --nodes=2
#SBATCH --tasks-per-node=8
#SBATCH --mem=4gb
#SBATCH --time=0-23:40:00



cd /deac/generalGrp/gemmerGrp/DAK/code/2d
module load matlab-2017a
use-student-matlab -r "gflow2d(0,0.1,100,4000,0.01,seedgen(100,'trig',3,4),'34')"
use-student-matlab -r "gflow2d(0,0.2,100,4000,0.01,seedgen(100,'trig',3,4),'34')"
use-student-matlab -r "gflow2d(0,0.05,100,4000,0.01,seedgen(100,'trig',3,4),'34')"
use-student-matlab -r "gflow2d(0.1,0.1,100,4000,0.01,seedgen(100,'trig',3,4),'34')"
use-student-matlab -r "gflow2d(0,0.2,100,4000,0.01,seedgen(100,'trig',3,4),'34')"
use-student-matlab -r "gflow2d(0,0.05,100,4000,0.01,seedgen(100,'trig',3,4),'34')"

