#12_angsd_snp_covar_dist_admix.sh located in 
#This script submits jobs to bin/angsd_ngs_dist.qsub, and bin/angsd_ngs_admix.qsub (optional) with a set of parameters.
#Jobs are done with specified reference and sample set.

#sample_info_XXX.list contains, without headers and tab-delimiated:
#SampleID     LibraryID       PlatformUnit    Haplotype       Location        ReadLength
#OalgA10CA 2162_G_1        MPIPZ           A               Cavoli_Elba     150
#OalgA10SA 2162_Q_1        MPIPZ           A               SantAndrea_Elba 150
#OalgA1CA  CSP2012_1049310 JGI             A               Cavoli_Elba     150
#OalgA1SA  CSP2012_1021950 JGI             A               SantAndrea_Elba 150

#Setting up a function to sumbit jobs to qsub with varying parameters.
submit3(){
qsub -hold_jid gatk_dep -N ngsdist_$1_$2 bin/angsd_ngs_dist.qsub $1\
  data/sample_info_$2.list\
  results/10b-11_indel_angsd_depth/$2\
  results/12_ngs_dist_region/$2 $3 $4
qsub -hold_jid gatk_dep -N ngsadmix_$1_$2 bin/angsd_ngs_admix.qsub $1\
  data/sample_info_$2.list\
  results/10b-11_indel_angsd_depth/$2\
  results/15_ngs_admix_region/$2 $3 $4 $5  #admix proportion analysis is optional.
#Parameters for "angsd_ngs_dist.qsub" and "angsd_ngs_admix.qsub":
# $1=reffile $2=sampleinfo $3=bamdir $4=outdir $5=snp_pval $6=prior $7=k_max(admix only)
# (automated depths, minind; preset maxdepind and hwepval cutoffs.)
}
#'submit3' parameters
  #$1=reffile    (Oalg_verB1 etc.)
  #$2=sample_set (180312_41Oalg etc.)
  #$3=snp_pval   (1e-3 etc.)
  #$4=prior      (1 or 2; -dopost)
  #$5=k_max      (8 etc.  K=2~8 will be done in admix)
  
#Full Oalg dataset run for 5-80%, maxDepthInd4, GL2, no-minHWEpval and uisng a region-filter file. ANGSD v0.929.
submit3 Oalg_verC3 180810_310_Oalg 1e-3 1 18
submit3 Oalg_verC3 180810_286_Oalg_Elba 1e-3 1 18