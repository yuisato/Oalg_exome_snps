 transfile=$(ls results/07_bbmap_cov_filter/candidate_isoforms.fasta)
  qsub bin/busco_metazoa.qsub $transfile results/07b_busco_coverage_filter

#$1=infile: Transcript file to check completedness
#$2=outdir: Output folder