Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta:
Final transcriptome reference 

Oalg_verC3_non-repeat_cov10_common_transcripts.fasta:
This is the final set of transcriptomic reference made of 17242 contigs used for popgen analyses.
Reference transcripts were filtered with coverages (0 < mean-coverage < 10, all samples are not coverage>4 at the same time, appear in all locations; see below).

Original transcriptome ammsenbly containing 20229 contigs is;
 01_transcript_Olavius/results/13_isoform_2018/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta
 01_transcript_Olavius/results/Final_reference_transcriptomes/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta

The original transcriptome was assessed to exclude any contigs that always show high coverage in metagenoems (=repeats/paralogs) or no coverage.
This assessment was done with qualimap v2.2.1 (locally, default setting) on 30 representative BAM files from; 
 2_exome_snp_analyses/results/07-10a_mapping/Oalg_verC3

This analysis indicated that stable SFS can be obtained using contigs that the mean coverage across the 30 samples is less than 10X, but excludes contigs that have 
 no reads mapped, or that all samples indicated coverages more than 4X at the same time.
 These filtering conditions reasonably identified 17363 contigs that do not attract genetic reads from paralogs or repeat regions, but allowed stocastically high
 coverage in some samples. 
Transcript contigs that do not get any reads mapped in at least one of 8 populations (R20; random 20 worms per location) were then identified and removed. The final set of 17242 contigs was listed in;
 2_exome_snp_analyses\data\ref\Oalg_verC3_non-repeat_cov10_common_contigs.txt
The region-filter file for ANGSD analyses were made by adding ':' in each line and saved as;
 2_exome_snp_analyses\data\ref\Oalg_verC3_non-repeat_cov10_common_contigs.rf.txt .
