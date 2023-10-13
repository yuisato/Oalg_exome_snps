mkdir -p results/02_prep
for infile in $(ls YOURDATA/*R1.fq.gz) ;do
qsub bin/bbduk_seecer_bbmap.qsub ${infile} results/02_prep/;
done
