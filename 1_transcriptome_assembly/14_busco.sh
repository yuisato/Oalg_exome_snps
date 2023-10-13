 for transfile in $(ls results/13_isoform/Oalg_transcripts_ver*_nr-megan_hits.fasta); do
  echo $transfile
  qsub bin/busco_metazoa.qsub $transfile "results/14_busco/"
 done

#$1=infile: Transcript file to check completeness
#$2=outdir: Output folder