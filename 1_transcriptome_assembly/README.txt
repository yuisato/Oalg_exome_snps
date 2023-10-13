Transcriptome reference assembly for  population genomics in Olavius algarvensis.

Goal: Generate sequences of the O. algarvensis transcriptome, containing one representative, complete sequence for each gene (i.e. isoforms and allelic variants have a single sequence representative; while gene families and recent gene duplications (paralogs) are maintained as separate sequences, with no contaminating sequences from other organisms.

Data: Paired-end Illumina sequences of O. algarvensis metatranscriptome from 12 libraries (6 'oxic' and 6 'anoxic'; see the main document). Downloaded from ERS13442267-ERS13442278 in the European Nucleotide Archive (ENA) under accession number PRJEB55913.

The number of scripts in this folder corresponds to the steps in the workflow and its result folder names. Coresponding shell scripts use a qsub command to run a task script in the bin/ folder.

(1) Quality check (fastqc)
(2) Adapter-trimming, common contaminant (PhiX) filtering, quality-based and length trimming
(3) Illumina-sequencing error correction (SEECER)
(4a) Remove reads of rRNA, mtDNA and the major symbiontic bacterial genomes, and remove orphaned reads;
Mapping against refernce files in data/ref [SortmeRNA database + symbiont-genome-bins + Olavius mitochondrial genomes; provided] and output non-mapping PE-reads (bbmap). 
(4b) Filter out contamination sequences (Drosophila melanogaster; ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/215/GCF_000001215.4_Release_6_plus_ISO1_MT/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz) and additional symbionts (data/ref/symbiont_genomes_2017_7.fasta ; provided). 
(4c; human RNA were also checked against human RNA assembly (ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.36_GRCh38.p10/GCF_000001405.36_GRCh38.p10_rna.fna.gz) 
 Keep output sequences for Step 11.
(5) Pool all processed reads from all libraries.
(6) a. K-mer normalisation (x50; In-silico normalisation by Trinity default).
       Keep normalized file for Steps 7.
    b. De-novo assembly; reporting only >600 bp contigs to remove artefacts (Trinity).
    c. Assess assembly s completeness against single-copy orthlogs (BUSCO DB; metazoa_odb9)
(7) Filter transcripts to >4x coverage to remove artefacts (bbmap/perl); apply BUSCO-assesment again.
(8) Coding-region ORF-prediction/isolation to remove contigs without full-ORFs (first without training file, then using Annelids sequences as a training file from step 9) (TransDecoder); apply BUSCO-assesment again.
(9) Remove transcripts of other bacterial and eukaryotic contamination:
    a. Diamond-blastx search transcript contigs against NCBI-nr-protein database.	
    b. MEGAN6 tax-classification to taxonomically filter transcripts associated with 'Bilateria' on a local machine via GUI (meganize daaFile='Trinity_with_ORF_nr-blastx.daa' minScore=50.0 maxExpected=1.0E-5 minPercentIdentity=0.0 topPercent=1.0E-5 minSupport=1 weightedLCA=false minComplexity=0.0 useIdentityFilter=false fNames=SEED paired=false)
(10) BUSCO-assessment.
(11) Remove redundant allelic-variations (and structurally similar isoforms) by clustering, but keep most of paralogs separated if detected (Corset and use seqtk-subseq)
a. Map (bowtie2 -all) reads from Step 4b to the assembly to produce multiple BAM-files per sample. 
b. Run corset; Assign each BAM file to a group. 
  	 (groupings = e.g. (oxic A4,A6,A9,B4,B6,B9 vs. anoxic A5,A7,A8,B5,B7,B8)
c. List resulting clusters (longest in each contig) and extract from the assembly (subseq).
d. BUSCO-assessment
(12) (obsolete)
(13) Isoform-identification (as  isoform (i)  in Trinity; e.g. 'DN1_c0_g1_i#' are from the same gene) and collapse them to the longest one (a custom Perl-script and bbtools/filterbyname.sh).
(14) Assess assembly's completeness against single-copy orthlogs (BUSCO DB; metazoa_odb9)


<<Scripts in the running order>>
01_fastqc.sh
Initial QC

02-04_bbduk_seecer_bbmap.sh
Decontamination of reads and error-correction

02-04_cleanup.sh
Post run clean-up of files 

04b_bbmap.sh
Check for Drosopila contamination

04c_bbmap.sh
Check for human contamination

05-06_pool_trinity.sh
Pooling clean read files and assembly

06b_busco.sh
Initial QC of transcriptome assembly

07a_filter_by_mapping_coverage.sh
Remove low-coverage contigs <4X

07b_busco.sh
Check the effect of coverage filtering on QC scores

08a_transdecoder.sh
08b_transdecoder_filter.sh
Coding region prediction and filtering

08c_busco_transdecoder.sh
Check the effect of coding region filter on QC scores.

09a_diamond.sh
Blastx-like search against the NCBI-nr database

<MEGAN6 on a local machine via GUI>
Visualize the diamond output in a taxonomic tree and export read IDs matching taxonomic criteria.

09b_megan_filter.sh
Filter reads using the IDs from above.

10_busco.sh
Check QC

11a_bowtie2.sh
Mapping reads as preparation for corset clustering

11b_corset.sh
Transcriptomic contig clustering based on read mapping depths and experiment conditions.
 
11c_corset_filter.sh
Filter out contigs using the corset output from above

11d_busco.sh
Check QC again

13_isoform.sh
Using trinity isoform header, cluster isoform to the longest contig

14_busco.sh
Final QC on transcriptome references