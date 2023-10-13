for transfile in $(ls results/11_corset/candidate_*_nr-megan_hits_Oalg_transcripts_ver*_corset.fasta); do
  qsub bin/busco_metazoa.qsub $transfile results/11_corset;
  echo $transfile
done

#$1=infile: Transcript file to check completeness
#$2=outdir: Output folder
