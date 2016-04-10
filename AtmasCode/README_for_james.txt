#### Instructions for running the CR1 extraction pipeline from full genome data ####

Things to do before running the pipeline:

Create ~/bin directory (this is where you will put your executables etc)
> mkdir ~/bin

Check that this directory is in your PATH
>less .bash_profile
PATH=$PATH:$HOME/bin
export PATH

Put lastz into your ~/bin
> cp /apps/software/lastz/1.02.00/bin/lastz ~/bin

Check that it runs from any directory
> lastz

Download usearch onto your desktop and copy to ~/bin on phoenix
> scp usearch8.1.1861_i86linux32 aIDno@phoenix.adelaide.edu.au:~/bin/

Rename for convenience
> mv usearch8.1.1861_i86linux32 usearch

Give permissions for it to be run as an executable
> chmod ugo+rwx usearch

Check that it runs from any directory
> usearch

Move split.sh to ~/bin and give permissions
> scp split.sh aIDno@phoenix.adelaide.edu.au:~/bin/
> chmod ugo+rwx split.sh
(Note: split.sh is a simple script which divides a large genome FASTA file into smaller files.
So it's easier to use as an executable script in ~/bin instead of submitting as a slurm script).

The pipeline requires directories to be set up in a particular way
(You can either set them up this way, or change the code to suit you)
For example, I've currently set everything up in: /data/rc003/atma/test_lastz
> cd /data/rc003/atma/test_lastz
> ls
Genomes/  lastz.sh  Query/  Results/

> ls Genomes/
Chelonia.mydas/  Crocodylus.porosus/

> ls Genomes/Chelonia.mydas/
CheMyd_1.0.fa  Split_seqs/

> ls Genomes/Chelonia.mydas/Split_seqs/
seq10.fa  seq12.fa  seq14.fa  seq1.fa  seq3.fa  seq5.fa  seq7.fa  seq9.fa
seq11.fa  seq13.fa  seq15.fa  seq2.fa  seq4.fa  seq6.fa  seq8.fa

The Genomes/ folder contains each genome in its own folder. 
Inside the Chelonia.mydas (green sea turtle) folder is the whole genome file (CheMyd_1.0.fa),
and another folder (Split_seqs/) which contains the smaller, divided genomes files (seq*.fa).

> ls Query/
CR1RepbaseFurtherFiltered3Kb.fa

This folder contains the FASTA file of the query sequences.

> ls Results/

This folder currently contains nothing. When you run the pipeline for each species,
it will automatically create a folder for each species which contains 
the original hit files (BED format etc) and the final FASTA file of extracted sequences.

And finally, lastz.sh is the slurm script needed to run the pipeline.
Example usage: 
> GENOME=Chelonia.mydas STARTVALUE=1 ENDVALUE=15 sbatch lastz.sh

The start and end values correspond to the number of seq*.fa files in /Genomes/Chelonia.mydas/Split_seqs/
The last step of the pipeline is to make a new folder (called FASTA) /Results/$GENOME to put the final FASTA file into.
When you see a file in this folder, you will know the job has completed. Check the slurm*.out script for any errors.

PS. On phoenix, to check which jobs you have running:
> squeue -u a1211880
JOBID  PARTITION     NAME     USER  ST      TIME  NODES NODELIST(REASON)
548731     batch lastz.sh a1211880  R       3:46      1 r1n18

(Obviously, replace that with your student number, not mine.)









