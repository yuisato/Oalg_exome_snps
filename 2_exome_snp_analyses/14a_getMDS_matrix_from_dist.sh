#This script converts .dist files from ngsDist into MDS matrix files, using the ngsTools script "getMDS.R". 

for infile in $(ls results/12_ngs_dist_region/*/*.dist); do
 echo "Infile: $infile"
 outfile=$(echo $infile | sed 's/.dist/.mds/');
 n_ind=$(head $infile -n2 | tail -n1)
 tail -n+3 $infile | head -n $n_ind | Rscript --vanilla --slave getMDS.R \
     --no_header --data_symm -n 4 -m "MDS" -o $outfile
 echo
done