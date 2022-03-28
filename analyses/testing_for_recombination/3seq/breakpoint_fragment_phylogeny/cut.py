from Bio import AlignIO

align = AlignIO.read('../nextclade_canada_most_recent_and_usher_and_deer/nextclade_canada_most_recent_and_usher_and_deer.aligned.fasta', 'fasta')

with open('alignment_chunk_0_1058.fasta', 'w') as out_fh:
    AlignIO.write(align[:, 0:1058], out_fh, 'fasta')

with open('alignment_chunk_1058_21750.fasta', 'w') as out_fh:
    AlignIO.write(align[:, 1058:21750], out_fh, 'fasta')

with open('alignment_chunk_21750_end.fasta', 'w') as out_fh:
    AlignIO.write(align[:, 21750:], out_fh, 'fasta')
