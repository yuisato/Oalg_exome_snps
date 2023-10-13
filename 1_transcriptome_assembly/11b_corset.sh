qsub bin/corset.qsub "results/11_corset/candidate_*_nr-megan_hits_Oalg_transcripts_verC3*.bam"\
 '1,2,1,2,2,1,1,2,1,2,2,1' results/11_corset/ candidate_Bilateria_nr-megan_hits_Oalg_transcripts_verC3
 #$1: all-mapped bam-files
 #$2: grouping of bam files (experiemtal groups), one per bam-file.
 #$3: output directory
 #$4: ref-file prefix for naming
