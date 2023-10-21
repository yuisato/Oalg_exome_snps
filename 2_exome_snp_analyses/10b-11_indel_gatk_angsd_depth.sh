#10b-11_indel_gatk_angsd_depth.sh
#This script submits a list of samples to bin/gatk_indel_angsd_depth.qsub
#Prerequisite is that all the mapped files are linked in to one folder specified below as $bamdir.

#sample_info_XXX.list contains, without headers and tab-delimiated:
#SampleID     LibraryID       PlatformUnit    Haplotype       Location        ReadLength
#OalgA10CA 2162_G_1        MPIPZ           A               Cavoli_Elba     150
#OalgA10SA 2162_Q_1        MPIPZ           A               SantAndrea_Elba 150
#OalgA1CA  CSP2012_1049310 JGI             A               Cavoli_Elba     150
#OalgA1SA  CSP2012_1021950 JGI             A               SantAndrea_Elba 150

#setting up a function 'submit'.
#Parameters for "bin/gatk_indel_angsd_depth.qsub":
#$1=reffile $2=sampleinfo $3=bamdir $4=outdir $5=maxdepth (estimate as 10x #sample)
submit(){
  qsub -hold_jid mapping bin/gatk_indel_angsd_depth.qsub $1 data/sample_info_$2.list\
    results/07-10a_mapping/$3\
    results/10b-11_indel_angsd_depth/$2 $4
#'submit' parameters
  #$1=reffile    (Oalg_verC3 etc.)
  #$2=sample_set (180810_310_Oalg etc.)
  #$3=bamdir     (180810 etc.)
  #$4=maxdepth   (~#sample x 10; 3000 etc.)
}

submit Oalg_verC3 180810_310_Oalg 180810 3200
submit Oalg_verC3 180810_286_Oalg_Elba 180810 3000