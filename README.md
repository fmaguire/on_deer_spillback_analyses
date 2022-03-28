# Ontario White-Tailed Deer SARS-CoV-2 Analyses

This repository contains analysis scripts, outputs, and figure generation code
for the Ontario White-Tailed Deer SARS-CoV-2 lineage manuscript.

Not all intermediate or input datasets are included due to limitations with
github maximum repository size. However, these should be documented clearly in 
the manuscript and run scripts.  

The primary aim of this repository isn't automatic reproduction of all figures but to full document exact commands and analyses performed.

## figure\_generator.ipynb
This is the primary notebook that parses outputs from individual analyses folders and generates figures and creates numerical summaries for the manuscript text. 
Relatively minor analyses that don't merit a separate analysis folder e.g., mutation distribution are also performed within this notebook.

## figures/
This folder contains all the final main manuscript figures (although Fig 1-3 were generated by co-authors using data contained within this repository). Similarly Figure 6 was created in [BioRender](https://biorender.com/).

### figures/intermediate/
These are intermediate SVGs that were generated before manual editing/merging to generate final figures in the parent directory. 

### figures/supplemental/
A subset of the supplemental figures for the manuscript (doesn't include the codon usage analyses performed by Oliver Lung's group).

## tables/
Folder containing the key mutation table and collated supplemental table generated for the manuscript.

## sequencing/
[Viral-recon](https://github.com/nf-core/viral-recon) variant/consensus generation results for the combined amplicon and bait-capture data.

### sequencing/viral\_recon\_final\_merged\_read\_genomes/
Output files from Peter Kruczkiewicz's viral-recon run of the combined samples

### sequencing/sequencing\_reports/
Peter Kruczkiewicz's [xlavir](https://github.com/CFIA-NCFAD/xlavir) reports for each sequencing run.

## analyses/
Individual analyses can be found in individual directories within this folder.
Each folder contains a README and run scripts as relevant that contain commands executed.

