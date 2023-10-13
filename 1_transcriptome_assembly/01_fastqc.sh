mkdir -p results/01_fastqc
for infile in $(ls YOURDATA/*fq.gz) ;do
qsub bin/fastqc.qsub ${infile} results/01_fastqc/;
done
