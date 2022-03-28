#!/bin/bash
set -euo pipefail

# canada_most_recent_and_usher_and_deer.fasta
# most recently sequenced genome from each lineage and closest genomes from usher
# 2022-02-21 USCS build
# n=595 including 5 complete deer nasal genomes, 2 partial deer RPLN genomes, 

# nextclade v1.10.1 db v2022-01-18T12:00:00Z
# nextalign based alignment for 3seq
nextclade --input-fasta input_data/canada_most_recent_and_usher_and_deer.fasta --input-dataset /databases/sars_cov_2_nextclade_db --output-basename nextclade_canada_most_recent_and_usher_and_deer --output-dir nextclade_canada_most_recent_and_usher_and_deer --jobs 10

# 3seq build 170612
# generate 3seq ptable and validate
3seq -gen-p ptable1000_canada_subset 1000
#3seq -c ptable1000_canada_subset

# check input alignment is valid
3seq -info nextclade_canada_most_recent_and_usher_and_deer/nextclade_canada_most_recent_and_usher_and_deer.aligned.fasta

# run a fullrun mode 3seq analysis
3seq -full nextclade_canada_most_recent_and_usher_and_deer/nextclade_canada_most_recent_and_usher_and_deer.aligned.fasta -ptable ptable1000_canada_subset -d -id canada_subsample_1000

# build phylogeny for identified breakpoints 
cd breakpoint_fragment_phylogeny
python cut.py
fasttree -nt alignment_chunk_0_1058.fasta > alignment_chunk_0_1058.nwk
fasttree -nt alignment_chunk_1058_21750.fasta > alignment_chunk_1058_21750.nwk
fasttree -nt alignment_chunk_21750_end.fasta > alignment_chunk_21750_end.nwk
cd ..

# To double check that over conservative multiple correction hasn't removed anything then do a second run with a higher p-value threshold 
3seq -full nextclade_canada_most_recent_and_usher_and_deer/nextclade_canada_most_recent_and_usher_and_deer.aligned.fasta -ptable ptable1000_canada_subset -d -t0.5 -id canada_subsample_1000_pvalue0.5
