#!/bin/bash

# Used to split a large genome FASTA file into multiple smaller FASTA files

# Parameters:
# $1 = Genome file to be split
# $2 = number of sequences in each new file

# Example usage:
# ./split_into_smaller_files.sh genome.fa 10000

# split a large fasta file into smaller fasta files
# e.g. set it to split at 10,000 sequences per file
# e.g. file0 will have 10,000 sequences, 
# file10000 will have the next 10,000 sequences, 
# file20000 will have the next 10,000 sequences, etc
# the last file will have any leftover sequences
awk 'BEGIN {n_seq=0;} /^>/ {if(n_seq%'$2'==0){file=sprintf("file%d",n_seq);} print >> file; n_seq++; next;} { print >> file; }' < $1

# rename file0 to seq1.fa, file10000 to seq2.fa, etc
ls file* | cut -c 5- |sort -g | awk '{print "file" $0, "seq" NR ".fa"}' | xargs -n2 mv

# move seq* files to a new sub-directory
mkdir -p Split_seqs
mv seq*.fa Split_seqs

# print the sequence files in numerical order
# e.g. to see how many files need to be analysed
cd Split_seqs
ls seq* | cut -c 4- | sort -g | awk '{print "seq" $0}'

