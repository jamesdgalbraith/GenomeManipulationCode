#!/bin/bash


cd ~
cd Data
cd Genomes
cd Scaffolds

mkdir Species_name
cd Species_name
wget --timestamping 'Primary_Assembly/unplaced_scaffolds/FASTA/unplaced.scaf.fna.gz'
gunzip unplaced.scaf.fna.gz
mv unplaced.scaf.fna.gz AssemblyName.fa



cd ~
cd Data
cd Genomes
cd Chromosome

mkdir Species_name
cd Species_name
mkdir assembled_chromosomes
mkdir unlocalized_scaffolds
mkdir unplaced_scaffolds


cd unplaced_scaffolds
wget --timestamping 'Primary_Assembly/unplaced_scaffolds/FASTA/unplaced.scaf.fna.gz'
gunzip unplaced.scaf.fna.gz
mv unplaced.scaf.fna.gz AssemblyName.fa
cd ..

cd assembled_chromosomes
wget --timestamping 'address'
gunzip *
cd ..

cd unlocalized_scaffolds
wget --timestamping 'address'
gunzip *
cd ..