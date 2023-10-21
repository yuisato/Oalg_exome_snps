Original transcriptome ammsenbly containing 20229 contigs is;
 1_transcript_Olavius/results/13_isoform_2018/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta
 1_transcript_Olavius/results/Final_reference_transcriptomes/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta

The original transcriptome was assessed to exclude any contigs that always show high coverage in metagenoems (=repeats/paralogs) or no coverage.
This assessment was done with qualimap v2.2.1 (locally, default setting) on 30 representative BAM files from; 
 2_exome_snp_analyses/results/07-10a_mapping/Oalg_verC3

This analysis indicated that stable SFS can be obtained using contigs that the mean coverage across the 30 samples is less than 10X, but excludes contigs that have 
 no reads mapped, or that all samples indicated coverages more than 4X at the same time.
 These filtering conditions reasonably identified 17363 contigs that do not attract genetic reads from paralogs or repeat regions, but allowed stocastically high
 coverage in some samples. 
Transcript contigs that do not get any reads mapped in at least one of 8 populations (R20; random 20 worms per location) were then identified and removed. The final set of 17242 contigs was listed in;
 2_exome_snp_analyses/data/ref/Oalg_verC3_non-repeat_cov10_common_contigs.txt
The region-filter file for ANGSD analyses were made by adding ':' in each line and saved as;
 2_exome_snp_analyses/data/ref/Oalg_verC3_non-repeat_cov10_common_contigs.rf.txt 


Oalg_verC3_snps_210210.rf.txt:
This file is a region filter file intended to use for ANGSD.
Each line contains a SNP position, incicated as "contig:position".  
Extracted from a base file:  results/15_ngs_admix_region/180810_310_Oalg/Oalg_verC3/310Samples_to_Oalg_verC3_MinQ20_SNPpval1e-3_Prior1.hwe.gz

EXAMPLE
TRINITY_DN10004_c0_g1_i2:26
TRINITY_DN10004_c0_g1_i2:30
TRINITY_DN10004_c0_g1_i2:96
TRINITY_DN10004_c0_g1_i2:120
TRINITY_DN10004_c0_g1_i2:138
....

These SNPs were identified with ANGSD v0.929 using Oalg_verC3 reference with a region filter on 310 O.algarvenssis samples.
Settings were as follows:
----
angsd-0.929 -b bam_list.txt -ref Oalg_verC3.fasta -out 310Samples_to_Oalg_verC3_MinQ20_SNPpval1e-3_Prior1 -GL 2 -doGlf 2 -doMaf 1 -doMajorMinor 1 -doPost 1 -doHWE 1 -doCounts 1 -P 32 -remove_bads 0 -uniqueOnly 0 -only_proper_pairs 0 -SNP_pval 1e-3 -setMaxDepthInd 4 -minHWEpval -1 -setMinDepth 126 -setMaxDepth 500 -minInd 155 -minQ 2 -minMaf 0.01 -rf data/ref/Oalg_verC3_non-repeat_cov10_common_contigs.rf.txt 
	-> angsd version: 0.929-19-gb2b41b5 (htslib: 1.6-55-gb065a60) build(Apr  8 2019 04:35:36)
	-> Mon Feb 15 11:09:31 2021


Oalg_mito_refs.fasta:
Reference full-mitochondrial genomes assembled from major clades of O. algarvensis lineages.
Each clade is represented twice with different starting point in the circular genome to fascilitate pair-read mapping. 
