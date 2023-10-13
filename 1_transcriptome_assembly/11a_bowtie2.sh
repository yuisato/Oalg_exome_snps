for ref_fasta in $(ls results/09b_megan/candidate_Bilateria_nr-megan_hits_Oalg_transcripts.fasta); do
 for R1file in $(ls results/04_bbmap/Oalg*_R1_prep.fa.gz) ;do
  qsub bin/bowtie2_all.qsub $R1file $ref_fasta results/11_corset/;
 done
done

