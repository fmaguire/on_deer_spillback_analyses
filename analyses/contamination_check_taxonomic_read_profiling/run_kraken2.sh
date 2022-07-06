#/bin/bash
set -euo pipefail

# get raw sequences from SRA
for acc in $(cut -f1 -d, SraRunTable.txt | grep -v "Run")
do 
    fastq-dl "$acc" SRA
done

# use kraken2 against a custom database containing SC2, human, and WTD genomes
# - GCF_002102435.1_Ovir.te_1.0_genomic.fna
# - GRC38_no_alt_analysis_set.fna
# - MN908947.3.fasta
# And k2_pluspf_20210517 just to double check nothing else is present
cd kraken2_output
for i in *_1.fastq.gz
do 
    kraken2 --db ../custom_wtd_db --report $(basename $i | cut -d '_' -f1)_wtd_db.kreport $i $(echo $i | sed 's/_1\.fastq/_2\.fastq/') > $(basename $i | cut -d '_' -f1)_wtd_db.kraken2; 
    kraken2 --db ../k2_pluspf_20210517 --report $(basename $i | cut -d '_' -f1)_k2pfp_db.kreport $i $(echo $i | sed 's/_1\.fastq/_2\.fastq/') > $(basename $i | cut -d '_' -f1)_k2pfp_db.kraken2; 
done
