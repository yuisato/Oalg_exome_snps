 transfile=$(ls results/08_transdecoder/Trinity_with_ORF.fasta)
  qsub bin/busco_metazoa.qsub $transfile results/08c_busco_transdec

#$1=infile: Transcript file to check completedness
#$2=outdir: Output folder