#!/bin/bash
# Calling script

rename_seqs ()
{
	while read line;
	do
	. test_rename.sh $line
	done < SpeciesGenomeNames.txt
}

rename_seqs