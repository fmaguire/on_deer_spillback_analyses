#!/bin/bash
set -euo pipefail
# excluding 7a and 7b as there was no phylogenetic resolution on the ON WTD clade
for gene in "E" "M" "N" "ORF10" "ORF3a" "ORF6" "ORF8" "S" "ORF1ab";
# "ORF8" "ORF10"rexcluded due to internal stops
do 	
	mkdir -p $gene
	virulign virulign_sc2_references/${gene}.xml input_data/B1_background_and_deer.fasta --exportWithInsertions no --exportReferenceSequence yes --exportKind GlobalAlignment --exportAlphabet Nucleotides --progress yes | sed "s/$gene $gene/Hu-1/" | sed "s/ //g" | fasta_formatter | sed 's/TAA$//' > $gene/B1_and_deer_${gene}.fasta
	cd $gene
	raxml-ng --model GTR --msa B1_and_deer_${gene}.fasta --threads 10 --tree pars{3} --redo
	# pause here to manually label using phylowidget
	# will fail if not done
	echo "mpirun -np 20 HYPHYMPI ABSREL --alignment B1_and_deer_${gene}.fasta --tree B1_and_deer_${gene}.fasta.raxml.labelled.bestTree --output ${gene}.absrel.json --branches on_deer 2>&1 | tee -a ${gene}.absrel.log"
	mpirun -np 20 HYPHYMPI ABSREL --alignment B1_and_deer_${gene}.fasta --tree B1_and_deer_${gene}.fasta.raxml.labelled.bestTree --output ${gene}.absrel.json --branches on_deer 2>&1 | tee -a ${gene}.absrel.log 
	echo "mpirun -np 20 HYPHYMPI  BUSTED --alignment B1_and_deer_${gene}.fasta --tree B1_and_deer_${gene}.fasta.raxml.labelled.bestTree --output ${gene}.busted.json --branches on_deer --starting-points 10 2>&1 | tee -a ${gene}.busted.log"
	mpirun -np 20 HYPHYMPI  BUSTED --alignment B1_and_deer_${gene}.fasta --tree B1_and_deer_${gene}.fasta.raxml.labelled.bestTree --output ${gene}.busted.json --branches on_deer --starting-points 10 2>&1 | tee -a ${gene}.busted.log 
	echo "mpirun -np 20 HYPHYMPI RELAX --alignment B1_and_deer_${gene}.fasta --tree B1_and_deer_${gene}.fasta.raxml.labelled.bestTree --models Minimal --output ${gene}.relax.json --test on_deer --refererence Hu-1 --starting-points 10 --srv Yes 2>&1 | tee -a ${gene}.relax.log"
	mpirun -np 20 HYPHYMPI RELAX --alignment B1_and_deer_${gene}.fasta --tree B1_and_deer_${gene}.fasta.raxml.labelled.bestTree --models Minimal --output ${gene}.relax.json --test on_deer --refererence Hu-1 --starting-points 10 --srv Yes 2>&1 | tee -a ${gene}.relax.log
	cd ..
done

grep "branches under selection among" */*.absrel.log
echo
grep "Likelihood ratio test for episodic diversifying positive selection," */*.busted.log
echo
grep "branches _relative_ to the" */*.relax.log
