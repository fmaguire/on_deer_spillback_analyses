#!/bin/bash
nextflow run nf-core/viralrecon \                                             
    --input samplesheet.csv \
    --platform illumina \
    --protocol amplicon \
    --genome 'MN908947.3' \
    -profile docker --max_cpus 4 --max_memory 12GB --primer_set artic --primer_set_version 4 --skip_assembly -resume --skip_kraken2 --skip_asciigenome --skip_assembly --skip_variants_quast --skip_ivar_trim --skip_markduplicates --skip_picard_metrics --gff split_orf1ab.gff

