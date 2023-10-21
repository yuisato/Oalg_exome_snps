#02-05_bbsplit_norm_clean.sh
#This script subimts jobs to prepare raw reads using bin/bbsplit_clean_norm.qsub
#All samples will be performed for bbsplit size-normalised read-QC and decontamination.

for sample in $(cut -f1 data/sample_info_180810_310_Oalg.list); do
  qsub -N seqprep bin/bbsplit_clean_norm.qsub $sample results/02-05_clean_reads
done