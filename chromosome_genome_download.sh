#!/bin/bash

cd ~
cd Data
cd Genomes
cd Chromosome
cd Coturnix_japonica

mkdir assembled_chromosomes
mkdir unlocalized_scaffolds
mkdir unplaced_scaffolds


cd assembled_chromosomes
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_001577835.1_Coturnix_japonica_2.0/GCA_001577835.1_Coturnix_japonica_2.0_assembly_structure/Primary_Assembly/assembled_chromosomes/FASTA/*'
gunzip *
cd ..

cd unplaced_scaffolds
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_001577835.1_Coturnix_japonica_2.0/GCA_001577835.1_Coturnix_japonica_2.0_assembly_structure/Primary_Assembly/unplaced_scaffolds/FASTA/*'
gunzip *
cd ..

cd unlocalized_scaffolds
wget --timestamping 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_001577835.1_Coturnix_japonica_2.0/GCA_001577835.1_Coturnix_japonica_2.0_assembly_structure/Primary_Assembly/unlocalized_scaffolds/FASTA/*'
gunzip *