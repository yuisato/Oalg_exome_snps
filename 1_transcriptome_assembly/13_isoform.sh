mkdir -p results/13_isoform

fasta="results/11_corset/candidate_Bilateria_nr-megan_hits_Oalg_transcripts_verC3_corset.fasta"
samtools faidx $fasta
echo $fasta
cat $fasta.fai | perl bin/pick_trinity_longest_isoform.pl > isoform.list
filterbyname.sh in=$fasta\
  out=results/13_isoform/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta\
  names=isoform.list include overwrite
rm isoform.list $fasta.fai;

TrinityStats.pl results/13_isoform/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta
#Remove trinity comments from the sequence headers and saved in the final result folder.
sed 's/ .*$//' results/13_isoform/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta\
 >  results/Final_reference_transcriptomes/Oalg_transcripts_verC3_Bilateria_nr-megan_hits.fasta
