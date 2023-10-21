Exome-wide SNP analyses for eukaryotic population genomics in Olavius algarvensis.

Mapping genome (metagenome) sequences to a host reference transcriptome to a low-coverage (1~4x) to identify exome-wide genome SNPs, and perform population structure analyses. Modified and expanded from Therkildsen&Palumbi (2016).

Data: Metagenome reads from single Olavius algarvensis worms. To be downloaded from "metagenome"s from the European Nucleotide Archive (ENA) under accession numbers PRJEB42310 and PRJEB55913.

Reference: O. algarvensis transcriptome assembly "Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta": 
Provided in ../1_transcriptome_assembly/results/Final_reference_transcriptomes/

The number of scripts corresponds to the steps in the workflow below, as well as its result folder names. Input and output files are usually specified within shell control scripts. These scripts mostly use a qsub command to run a task script in the bin/. See more annotations within the scripts:

Exome-capturing SNP-calling/-analysis workflow
(0) Phyloflash to get compositions of SSU (18S/16S rRNA genes).
(1) Quality check for raw input files (fastqc)
(2) Remove PCR-duplications (fastuniq) and clip residual barcodes and adapter sequences (trimmomatic).
(2b) Separate reads to mitochondrial, symbionts, and unmapped that is dominated with the host Oalg (BBsplit).
  Refs: Oalg symbionts  bins (Provided in ../1_transcriptome_assembly/data/ref/symbiont_genomes_2017_7.fasta.gz)
        Oalg mitochondrial genomes (Provided as ./data/ref/Oalg_mito_refs.fasta)
(3) Quality-trimming (trimmomatic).
(4) Merge overlapping reads (flash), and add QC-orphaned reads to extended (single end) reads.
(5) i) Remove contaminant reads (bowtie2, python script) from remaining reads.
 Contaminant references: 
  Human genome (ftp://ftp.ensembl.org/pub/release-82/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_rm.toplevel.fa.gz)
  Viral genomes (https://www.ncbi.nlm.nih.gov/genomes/GenomesGroup.cgi?taxid=10239; Retrieve sequences: RefSeq nucleotides)
  Bacterial genomes (https://www.ncbi.nlm.nih.gov/assembly    
    [ bacteria   latest genbank   complete genome ] + [ bacteria   representative refseq   all levels )]
  rRNA collection (sortmeRNA database: rRNA_rfam_silva.fa.gz; Provided in ../1_transcriptome_assembly/data/ref/)
   ii) Normalize clean reads containing host nuclear DNA to 1.0~1.8G base pairs to reduce SNP ID noises (reformat.sh).
(5b-c) Mitochondrial genome construction (spades/mitobim) according to Sato et al. 2022 DOI:10.1186/s40168-022-01372-2. See https://github.com/yuisato/Oalg_linkage/blob/main/02_assemble_ref_mtDNA.sh
(6) Re-check quality of PE and SE reads after QC (fastqc).
(7) Map clean reads to the Oalg-reference transcriptome. (bowtie2; Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta)
(8) Obsolete
(9) Remove duplicates due to intron/exon boundaries (picard-MarkDuplicates).
(10) Identify and realign around indels (GenomeAnalysisToolKit (GATK)-IndelRealigner).
(11) Check distributions of coverage depth and mapping quality (angsd -doDepth). Check on the sample depth report PDF and .depthSample file to decide #MaxDepthInd in the ANGSD step below, according to the depth where the growth of cummurative read% becomes minimal (e.g. 2Gbases data per sample, 5x is reasonable).    
(12) SNP-identification based on genotype likelihood, followed by calculating genetic distances (angsd, ngsDist) and admixture proportions (ngsAdmix; optional). In ANGSD, MinDepth/MaxDepth range set as 5 - 80 percentiles (This depends on the mapping reference: assessed for Oalg_verC3 with depth.PDF to ensure it does not show a strong secondary peak; if there is a secondary peak, check where the peak are and change the upper percentile accordingly. This can be done by checking the .info file from (11)) 
Also applied: -setMaxDepthInd=4 to ensure to remove highly repeated regions that lead to false positive SNPs. SNP p-value < 1e-3, minMaf 0.01, 50% of population for minInd, check deviation from Hardy Weinberg Equilibrium (-doHWE 1). 
(13) Obsolete
(14) Heatmap (optional) and MDS based on genetic distances (ngsDist) for identifying population structuring. Checking statistical significance of clustering with PERMANOVA and pairwise-PERMANOVA.
(15) Plotting admix proportions (ngsAdmix) for pooled population. (optional)
(16) Inbreeding assessment per local population (per location; ngsF-HMM), performing the ANGSD-depth first for each population. 
Then performs 'inbred-coefficient F'-adjusted admix, MDS, and PERMANOVA; which were obsolete as F indicated none for all populations.)
(17) SFS (Site Frequency Spectra; F-adjusted if needed) per local population, and FST and PBS estimation between populations (angsd, realSFS). Applying Isolation by Distance test on pairwise FST and geographic distances.
(18) Obsolete
(19) Bayesian modeling on the IBD patterns (R, brm())



<<Scripts in the running order>>
00a_phyloflash_covstats.sh
Phyloflash

01_fastqc.sh
Initial QC

02-05_bbsplit_norm_clean.sh
QC, filtering of raw sequence files

05b_mito_spades.sh
05c_mitobim.sh
Mitochondrial genome (mtDNA) assembly

06_fastqc_post.sh
QC on clean reads.

07-10a_map_picard_samtools.sh
Mapping metagenomic reads to the transcriptomic reference.

10b-11_indel_gatk_angsd_depth.sh
Filtering of mapped reads and checking depth profiles for the next ANGSD step

12_angsd_snp_covar_dist_admix.sh
Identifying SNPs with ANGSD, and obtain matrixes for PCA, MDS and admix plots.

13_ngsCovar_PCA_R.Rmd
Plotting PCA from ngsCover output (optional)

14a_getMDS_matrix_from_dist.sh    +     getMDS.R
14b_ngsDist_heatmap_MDS_R.Rmd
14c_3D_MDS.Rmd
Process ngsDist output for MDS, and plotting

14d_PERMANOVA_on_ngsDist_matrix.Rmd
Statistic tests on cluster structuring
 
15_plot_admix.Rmd
Plotting Admixture proportions in local R machine. (optional)

16_angsd_depth_F-HMM_admix_dist.sh
Individual inbreeding coefficient F estimation, and F-adjusted ngsAdmix and ngsDist.
 
17_sfs_fst_pbs.sh
Site frequency spectra estimation, FST (pairwise FSTs among 3 populations at a time), and calculation of population branching statistic (PBS; optional).

17b_fst_ibd_mantel.Rmd
Mantel tests for Isolation-By-Distance patterns, in local R machine.

19_brms_dist_FST.Rmd
Bayesian modeling of IBD patterns.