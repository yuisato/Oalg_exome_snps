#16_angsd_depth_F-HMM_admix_dist.sh
#This script submits a list of local population samples to bin/angsd_depth_F-HMM_admix_dist.qsub etc.
#Samples are listed in data/sample_info_180810_310_Oalg.list etc.
#Prerequisite is that all mapped result files in bam format are linked into one folder $BAMDIR.

#sample_info_XXX.list contains, without headers and tab-delimiated:
#SampleID     LibraryID       PlatformUnit    Haplotype       Location        ReadLength
#OalgA10CA 2162_G_1        MPIPZ           A               Cavoli_Elba     150
#OalgA10SA 2162_Q_1        MPIPZ           A               SantAndrea_Elba 150
#OalgA1CA  CSP2012_1049310 JGI             A               Cavoli_Elba     150
#OalgA1SA  CSP2012_1021950 JGI             A               SantAndrea_Elba 150


#Setting up functions:
submit(){
qsub -N ngsF-HMM_$2 bin/angsd_depth_F-HMM_admix_dist.qsub $1\
    data/sample_info_$2.list\
    results/10b-11_indel_angsd_depth/$3\
    results/16_angsd_F-HMM_admix_dist_region/$2 $4 $5
#Parameters for "bin/angsd_depth_F-HMM_admix_dist.qsub":
#$1=reffile $2=sampleinfo $3=bamdir $4=outdir $5=SNPpval $6=k_max
}
#'submit' parameters
  #$1=reffile    (Oalg_verC3 etc.)
  #$2=sample_set (180810_Oalg_SANT etc.)
  #$3=bamdir     (180810_310_Oalg etc.)
  #$4=SNPpval    (1e-3 etc.)
  #$5=k_max      (5 etc. for admix)

#############################################################

#Within-location MDS&Admix using a region-filter file (data/ref/Oalg_verC3_non-repeat_cov10_common_contigs.rf.txt)
submit Oalg_verC3 180810_Oalg_CAVL 180810_310_Oalg 1e-3 5
submit Oalg_verC3 180810_Oalg_CLDF 180810_310_Oalg 1e-3 5
submit Oalg_verC3 180810_Oalg_POMT 180810_310_Oalg 1e-3 5
submit Oalg_verC3 180810_Oalg_SANT 180810_310_Oalg 1e-3 5
submit Oalg_verC3 180810_Oalg_SORG 180810_310_Oalg 1e-3 5
submit Oalg_verC3 180810_Oalg_VITA 180810_310_Oalg 1e-3 5
submit Oalg_verC3 180810_Oalg_ZUCC 180810_310_Oalg 1e-3 5
submit Oalg_verC3 180810_Oalg_MAGL 180810_310_Oalg 1e-3 5