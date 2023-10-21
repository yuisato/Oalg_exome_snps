#01_fastqc.sh
#This script submit samples to report fastqc results.

#After this script is complete, run the following commands to get MultiQC summary.
#cd result/01_fastqc/
#multiqc *

#sample_info_XXX.list contains, without headers and tab-delimiated:
#SampleID     LibraryID       PlatformUnit    Haplotype       Location        ReadLength

#OalgA10CA 2162_G_1        MPIPZ           A               Cavoli_Elba     150
#OalgA10SA 2162_Q_1        MPIPZ           A               SantAndrea_Elba 150
#OalgA1CA  CSP2012_1049310 JGI             A               Cavoli_Elba     150
#OalgA1SA  CSP2012_1021950 JGI             A               SantAndrea_Elba 150

for sample in $(cut -f1 data/sample_info_180810_310_Oalg.list); do
 for file in data/$sample*.fq.gz ;do
  qsub bin/fastqc.qsub $file results/01_fastqc/
 done
done