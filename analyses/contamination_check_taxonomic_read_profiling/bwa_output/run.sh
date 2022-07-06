for sample in *_composite.bam; do 
    python composite_score.py --composite $sample
    echo $sample
done
