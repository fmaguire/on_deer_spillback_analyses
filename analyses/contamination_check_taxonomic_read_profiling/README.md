# contamination\_check\_taxonomic\_read\_profiling

To ensure WTD samples weren't contaminated by human SARS-CoV-2. 
A kraken2 taxonomic assignment analysis was performed for each of the raw sequencing samples (ARTICv4 and bait-capture, details found in `SraRunTable.txt`).

Each readset was evaluated against a custom database containing the human (GRC38) and the WTD (GCF002102435) reference genome and the largest pre-built index available (pluspf 2021-05-17). 
The resultant kreports were summarised using the `figure_generator.ipynb` workbook.

A run script which downloads the raw reads and executes the kraken2 analyses can be found in `run.sh`.
