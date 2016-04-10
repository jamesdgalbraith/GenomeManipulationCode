#!/bin/bash

# Invoked by:
#
# sbatch censor.sh
#

#SBATCH -p batch
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --time=1-00:00
#SBATCH --mem=32GB

# Notification configuration
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=james.galbraith@adelaide.edu.au

module load bioperl/1.6.924
module load censor/4.2.29
module load wu-blast/2.0

censor -bprm cpus=8 -lib repbaselibrary.ref your_fasta_file.fasta