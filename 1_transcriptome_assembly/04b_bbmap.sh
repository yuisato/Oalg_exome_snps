for infile in $(ls results/02_prep/*R1_prep.fa.gz) ;do
 qsub bin/bbmap_4b.qsub ${infile} results/04_bbmap
 echo $infile
done
