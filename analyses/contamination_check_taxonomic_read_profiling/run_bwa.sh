for i in all_raw_deer/*_1.fastq.gz
do
    #bwa mem -t 8 GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna $i $(echo $i | sed 's/_1\./_2\./') | samtools view -b > bwa_mapping/$(basename $i | sed 's/_1\.fastq\.gz//')_human.bam
    #bwa mem -t 8 GCF_002102435.1_Ovir.te_1.0_genomic.fna $i $(echo $i | sed 's/_1\./_2\./') | samtools view -b > bwa_mapping/$(basename $i | sed 's/_1\.fastq\.gz//')_deer.bam
    #bwa mem -t 8 MN908947.3.fasta $i $(echo $i | sed 's/_1\./_2\./') | samtools view -b > bwa_mapping/$(basename $i | sed 's/_1\.fastq\.gz//')_virus.bam
    bwa mem -t 8 ../covid-19-signal/data/composite_deer_human_viral_reference.fna $i $(echo $i | sed 's/_1\./_2\./') | samtools view -b > bwa_mapping/$(basename $i | sed 's/_1\.fastq\.gz//')_composite.bam
    echo $i
done


