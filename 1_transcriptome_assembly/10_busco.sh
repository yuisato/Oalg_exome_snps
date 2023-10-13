for transfile in $(ls results/09b_megan/candidate_Bilateria_nr-megan_hits_Oalg_transcripts.fasta); do
  qsub bin/busco_metazoa.qsub $transfile results/10_busco_megan;
  echo $transfile
done

#$1=infile: Transcript file to check completedness
#$2=outdir: Output folder
