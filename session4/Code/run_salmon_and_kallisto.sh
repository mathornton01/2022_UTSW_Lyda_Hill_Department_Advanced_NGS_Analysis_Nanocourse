#!/bin/bash

# NOTE: Please do not try to run this script if you do not 
#  have all of the requiste programs installed and working 
#  your salmon should be within a conda environment as well. 

# First Create an index for Salmon to use for the data. 
conda activate salmon
salmon index -i sal_idx -t ../Data/c22.425.txome.fa > log.txt
conda deactivate 

# Now create an index for Kallisto to use
kallisto index -i kal_idx ../Data/c22.425.txome.fa > log.txt

# Now quantify the paired end reads with Salmon 
conda activate salmon 
salmon quant -i sal_idx \
             -o sal_quant\
             -l A\
             -1 ../Data/c22.425_1.fa\
             -2 ../Data/c22.425_2.fa > log.txt
conda deactivate 

# Finally Quantify the reads with Kallisto 
kallisto quant -i kal_idx \
               -o kal_quant\
               ../Data/c22.425_1.fa\
               ../Data/c22.425_2.fa > log.txt

# Display the Results from Salmon & Kallisto: 

echo "Results from Salmon:" 
cat sal_quant/quant.sf
echo "Results from Kallisto:" 
cat kal_quant/abundance.tsv
echo "True Simulated Abundances: " 
cat ../Data/c22.425.stat

# Remove intermediate files: 

rm kal_idx; rm -rf kal_quant; rm -rf sal_idx; rm -rf sal_quant; rm log.txt;
