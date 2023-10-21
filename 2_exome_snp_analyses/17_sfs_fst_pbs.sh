#17_angsd_sfs_fst_pbs.sh
#This script submits a list of samples from 3 populaitons to bin/sfs_3pop_fst_pbs_region_snp.qsub
#Prerequisite is to have all mapped BAM files linked in the $BAMDIR folder.
#Samples of each groups are listed in data/sample_info_180312_SOR.list etc.

#sample_info_XXX.list contains, without headers and tab-delimiated:
#SampleID     LibraryID       PlatformUnit    Haplotype       Location        ReadLength
#OalgA10CA 2162_G_1        MPIPZ           A               Cavoli_Elba     150
#OalgA10SA 2162_Q_1        MPIPZ           A               SantAndrea_Elba 150
#OalgA1CA  CSP2012_1049310 JGI             A               Cavoli_Elba     150
#OalgA1SA  CSP2012_1021950 JGI             A               SantAndrea_Elba 150
#...

#data/ref/Oalg_verC3_snps_210210.rf.txt (region filter file for bin/sfs_3pop_fst_pbs_region_snp.qsub)
# TRINITY_DN10004_c0_g1_i2:1023
# TRINITY_DN10004_c0_g1_i2:1060
# TRINITY_DN10004_c0_g1_i2:1107
# ....
# This file is extracted from:  results/15_ngs_admix_region/180810_310_Oalg/Oalg_verC3/310Samples_to_Oalg_verC3_MinQ20_SNPpval1e-3_Prior1.hwe.gz
# See data/ref/Oalg_verC3_snps_210210.rf.README.txt for details.

####################################################

#Additon on 2021-08-19: Calculation of FST etc. based on previously identified SNP-sites only.
submit_3pop_region_snp(){
qsub -N sfs_fst_pbs_$2.$3.$4 bin/sfs_3pop_fst_pbs_region_snp.qsub $1 $2 $3 $4\
    results/17_sfs_fst_pbs_region-filter_minInd50_snp\
    results/10b-11_indel_angsd_depth/$5\
    data/sample_info_180810_Oalg_$2.list\
    data/sample_info_180810_Oalg_$3.list\
    data/sample_info_180810_Oalg_$4.list

#Parameters for "bin/sfs_3pop_fst_pbs_region_snp.qsub":
 #reffile=$1 #pop1=$2 #pop2=$3 #pop3=$4 #outdir=$5 #bamdir=$6 #sampleinfo1=$7 #sampleinfo2=$8
 #sampleinfo3=$9
}
#'submit_3pop_region_snp' parameters
  #$1=reffile Oalg_verC3 etc.
  #$2=pop1    MAGL_R20 etc.
  #$3=pop2    CLDF_R20 etc.
  #$4=pop3    CAVL_R20 etc.
  #$5=bamdir  180810_310_Oalg etc.
# saf-files are made within this script with a SNP-site filter.

###########################################################

submit_3pop_region_snp Oalg_verC3 VITA_R20 SORG_R20 SANT_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 SANT_R20 POMT_R20 CAVL_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 CAVL_R20 CLDF_R20 ZUCC_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 POMT_R20 ZUCC_R20 MAGL_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 SORG_R20 POMT_R20 CLDF_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 SANT_R20 CLDF_R20 MAGL_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 SORG_R20 CAVL_R20 MAGL_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 VITA_R20 SANT_R20 ZUCC_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 VITA_R20 SORG_R20 ZUCC_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 VITA_R20 POMT_R20 CAVL_R20 180810_310_Oalg
submit_3pop_region_snp Oalg_verC3 VITA_R20 CLDF_R20 MAGL_R20 180810_310_Oalg
