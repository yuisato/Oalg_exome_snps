#00_phylo_coi_flash.sh located in /opt/extern/bremen/symbiosis/sato/05_
#This script submits sample (OalgG1SS, OalgG2SS etc.) files to phyloflash and coiflash; and assess coverage stats of ssu contigs based on bbmap.

for sample in $(cut -f1 data/sample_info_180810_310_Oalg.list); do
   qsub bin/phyloflash_covstats.qsub $sample\
   data\
   results/00_phyloflash_covstats
done
