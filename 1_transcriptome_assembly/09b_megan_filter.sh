cat results/09b_megan/Bilateria_nr-megan_hits.fasta | grep '>' | sed 's/>//g' > filter_seqs.list
filterbyname.sh in=results/05_trinity/Trinity.fasta\
 out=results/09b_megan/candidate_Bilateria_nr-megan_hits_Oalg_transcripts.fasta names=filter_seqs.list\
 include=t overwrite

rm filter_seqs.list