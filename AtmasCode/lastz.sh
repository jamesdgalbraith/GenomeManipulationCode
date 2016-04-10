#!/bin/bash

# Example usage:
# GenomeSplits GENOME=Falco_cherrug STARTVALUE=1 ENDVALUE=69 sbatch lastz.sh

#SBATCH -p batch
#SBATCH -N 1 
#SBATCH -n 8 
#SBATCH --time=1-00:00 
#SBATCH --mem=32GB 

# Notification configuration 
#SBATCH --mail-type=END                                         
#SBATCH --mail-type=FAIL                                        
#SBATCH --mail-user=james.galbraith@student.adelaide.edu.au 

# Load the necessary modules
module load gnu-parallel/2016-01-23-foss-2015b
module load BEDTools/2.25.0-foss-2015b
# Note: LASTZ and usearch have not been made into a module yet
# For now, copy the LASTZ binary into your home bin
# e.g. cp /apps/software/lastz/1.02.00/bin/lastz ~/bin
# and download usearch then copy into ~/bin

# In Results directory, make a new directory for your genome
cd ~/test_lastz/Results
mkdir -p $GENOME
# Make sub-directory to store CR1/Genome alignment hits
cd $GENOME
mkdir -p Hits
cd Hits

# Align CR1 query seqs to all Genome seqs, using LASTZ
# Note that this currently points to the Split_seqs genome sub-directory
# (which assumes that you've already run split.sh)
seq $STARTVALUE $ENDVALUE | parallel lastz '~/test_lastz/Genomes/'$GENOME'/Split_seqs/seq{}.fa[unmask,multiple] ~/test_lastz/Query/InitialQuery.fa[unmask,multiple] --chain --gapped --coverage=80 --ambiguous=n --ambiguous=iupac --format=general-:name2,start2,end2,score,strand2,size2,name1,start1,end1 > ~/test_lastz/Results/'$GENOME'/Hits/LASTZ_CR1_'$GENOME'_seq{}'

# Make sure you are in the right directory
cd ~/test_lastz/Results/$GENOME/Hits

# Remove all files that are empty
find -size  0 -print0 | xargs -0 rm

# Concatenate all hit files into one file
cat LASTZ_CR1_"$GENOME"_seq* > LASTZ_CR1_"$GENOME"_AllSeqs

# Rearrange columns to put the concatenated file in BED-like form (for BEDTools) 
awk '{print $7 "\t" $8 "\t" $9 "\t" $1 "\t" "1" "\t" $5}' LASTZ_CR1_"$GENOME"_AllSeqs >> BedFormat_CR1_"$GENOME"_AllSeqs

# Sort by chr/scaffold and then by start position in ascending order 
bedtools sort -i BedFormat_CR1_"$GENOME"_AllSeqs > Sorted_CR1_"$GENOME"_AllSeqs

# Merge nested or overlapping intervals
bedtools merge -s -i Sorted_CR1_"$GENOME"_AllSeqs -c 4 -o collapse > Merged_CR1_"$GENOME"_AllSeqs

# Merging broke the BED-like format
# (i.e. strand is now in 4th column, merged names in 5th column, etc)
# Rearrange the columns as required
awk '{print $1 "\t" $2 "\t" $3 "\t" $5 "\t" "1" "\t" $4}' Merged_CR1_"$GENOME"_AllSeqs >> Merged_CR1_"$GENOME"_AllSeqs_proper.bed

# Extract FASTA from corrected merged BED file
# Note that (for simplicity) this uses the whole genome file, not the Split_seqs
bedtools getfasta -s -fi ~/test_lastz/Genomes/$GENOME/*.fa -bed Merged_CR1_"$GENOME"_AllSeqs_proper.bed -fo results.fasta

# Sort sequences by length
usearch -sortbylength results.fasta -fastaout "$GENOME"_CR1_AllSeqs.fasta

# Move this final FASTA file to a separate directory (for easy access)
mkdir -p ~/test_lastz/Results/$GENOME/FASTA
mv "$GENOME"_CR1_AllSeqs.fasta ../FASTA


