for infile in $(ls results/04_bbmap/*R1_prep.fa.gz) ;do
 qsub bin/bbmap_4c.qsub ${infile} results/04_bbmap
 echo $infile
done
