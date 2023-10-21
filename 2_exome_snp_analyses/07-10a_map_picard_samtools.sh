#07-10a_map_pichard_samptools.sh 
#This script submits a batch of read-mapping processes.

for sample in $(cut -f1 data/sample_info_180810_310_Oalg.list); do
  echo $sample
  qsub -hold_jid fastqc bin/bowtie2_picard_samtools.qsub $sample results/02-05_clean_reads\
   data/sample_info_180810_310_Oalg.list\
   data/ref\
   'Oalg_verC3'\
   results/07-10a_mapping/180810
done
#$1=sample $2=indir $3=infolist $4=refdir $5=reflist $6=outdir