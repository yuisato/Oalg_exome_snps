#!/usr/bin/env perl
use strict;
use warnings;

# Parse corset cluster file
# Report only longest sequence id per cluster

open (DATA1, "<clusters.txt");
#TRINITY_DN32_c0_g1_i1   Cluster-0.0
#TRINITY_DN7_c0_g1_i1    Cluster-1.0
#TRINITY_DN29_c0_g1_i1   Cluster-1.1

my %cluster_hash; #hash to store cluster, contig, length
my (@splitline1, $contig, $cluster);

while(<DATA1>){
   chomp;
   @splitline1 = split "\t", $_;
   $contig = $splitline1 [0];
   $cluster = $splitline1 [1];
   if (!(exists $cluster_hash{$contig})){	#For each new contig name as key, 
     $cluster_hash{$contig} [0] = $cluster;	#register cluster name. in cluster_hash in [0] field.
   }
}
close (DATA1);

open (DATA2, "<trans.fasta.fai");
#TRINITY_DN20_c0_g1_i1   247     58      60      61
#TRINITY_DN18_c0_g1_i1   205     372     60      61
#TRINITY_DN21_c0_g1_i1   419     639     60      61

my (@splitline2, $contig2, $length);
while(<DATA2>){
   chomp;
   @splitline2 = split "\t", $_;
   $contig2 = $splitline2 [0];		#contig2 from DATA2
   $length =  $splitline2 [1];		#length from DATA2
   $cluster_hash{$contig2} [1] = $length; 	#Using cluster_hash with contig2 as key, making values to an array made of cluster and length
#   print $contig2 . "\t" . $cluster_hash{$contig2} [0] . "\t".  $cluster_hash{$contig2} [1] . "\n";
#   Note some of contig2 do not have cluster value in hash [0] as they do not appear in the cluster table.
}
close (DATA2);

# print results
my %summary;			#hash to make a summary
my ($cl , $len , $cont );	#to place cluster, length, contigs
$cl="";				#empty them.
my @temp_array ="";		#empty temp-array for writing contig and length.
foreach $cont (keys (%cluster_hash)){	#iterates over the contig names (= key of cluster_hash)
      $cl = $cluster_hash{$cont}[0];	#cluster name from the hash array-0
      $len = $cluster_hash{$cont}[1];	#contig length from the hash array-1
      #print "$cont \t $len $cl \t $len \n";
      @temp_array = ($cont, $len);	#write contig and length in temp-array
      if (!defined($cl)){	 #if the cluster was not defined/present for the contig, then ignore the contig and go back up.
         next;
      }

      if (exists $summary{$cl}){ #if the name of the cluster alredy exists in the list of key of summary, then
      #print " $cl    $summary{$cl}[1]\n"; 	#print the cluster that is assigned to multiple contigs
         if ( $len > $summary{$cl}[1]){		#check new length is bigger than pre-exisiting one.
            #print "change from old $summary{$cl}[1] to new $len \n\n\n";
            $summary{$cl} = [@temp_array];  	##summary will now be replaced with a hash (key= cluster name) as an array of contig name and length
         }
      }
      else {					#if the cluster is new for the summary,
          #print "new entry " . $cl . " " . $temp_array[0] . "\n";
          $summary{$cl} = [@temp_array];	#write temp-array into the summary.
      }
}


#print "\n\nSUMMARY RESULTS\n\n"; 
#print final results written in summary-hash

foreach my $key ( keys %summary) { 	# For each key (=cluster) of hash...
    print  $key. "\t" . $summary{$key}[0] ."\t" . $summary{$key}[1]; 
    print  "\n"; # Start new line for next entry
}







