filterbyname.sh in=results/05_trinity/Trinity.fasta\
 out=results/08_transdecoder/Trinity_with_ORF.fasta names=cds_contigs.list\
 include=t overwrite

rm cds_contigs.list