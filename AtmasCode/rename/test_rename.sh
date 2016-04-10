#!/bin/bash

# cd to the directory where all your genomes are
# (check that this is right)
cd /home/a1194388/test_lastz/Genomes/

# go inside the first genome directory
cd $1
echo -e "\nWe are working in directory: "$1
echo "Let's see the files in here... "
ls
echo "So the genome file here is: "$2
echo "Let's change things a bit."
rename_to_seq.sh $2
echo "Remember to note the number of sequences."
echo -e "We are done here. Please leave.\n"
cd ..
