#06_fastqc_post.sh
#This script submit samples to report fastqc results.

#After this script is complete, run the following commands to get MultiQC summary.
#cd result/06_fastqc
#multiqc *

for sample in $(cut -f1 data/sample_info_180810_310_Oalg.list); do
 for file in results/02-05_clean_reads/${sample}_SingleEndQualFiltered_NoBacCont.fastq.gz\
             results/02-05_clean_reads/${sample}_Paired_NoBacCont_1.fastq.gz\
             results/02-05_clean_reads/${sample}_Paired_NoBacCont_2.fastq.gz ;do
  qsub -hold_jid seqprep bin/fastqc.qsub $file results/06_fastqc_post/
 done
done