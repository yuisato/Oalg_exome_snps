#!/usr/bin/env perl

use strict;
use warnings;

# Filter fasta index file 
# Report headers of longest Trinity isoform per Trinity gene

my %genelength_hash; # Hash to store counts and header names

#my $mincov = 4.0; # length cutoff value

while (<>) {
    chomp;
#    unless (/^#/) { # Ignore header line with regex
    my @splitline = split "\t", $_;
    my $length = $splitline[1]; # Get length field from fasta index file
#    my $coverage = $splitline[1]; # Get coverage field from bbmap covstats output
#    if ($coverage >= $mincov) { # check length over minimum
#        my @splitid1 = split " ", $splitline[0]; 
        my @splitid1 = split "_", $splitline[0];   # Split sequence name including "TRINITY...._i1"
        my $genename = join "_", @splitid1[0..3]; # Gene name are the first four parts of Trinity header
        my $isoform = $splitid1[4]; # Isoform i1, i2... is fifth part of Trinity header
        if (!defined $genelength_hash{$genename}{"length"}) { 
        # If first time encountering this gene, save info to hash
            $genelength_hash{$genename}{"length"} = $length;
            $genelength_hash{$genename}{"longestisoform"} = $isoform;
#            $genelength_hash{$genename}{"coverage"} = $coverage;
            $genelength_hash{$genename}{"header"} = $splitline[0]; #$splitid1[0];
        } else {
            if ($length > $genelength_hash{$genename}{"length"}) { 
            # Check if length of current isoform is longer than what is already stored, ignores ties
                $genelength_hash{$genename}{"length"} = $length; # New winner!
                $genelength_hash{$genename}{"longestisoform"} = $isoform;
#                $genelength_hash{$genename}{"coverage"} = $coverage;
                $genelength_hash{$genename}{"header"} = $splitline[0]; #$splitid1[0];
            }
        }
#    } 
#    }
}


# print results

foreach my $genename (sort {$a cmp $b} keys %genelength_hash) { # For each key of hash sorted ASCIIbetically...
    print STDOUT $genelength_hash{$genename}{"header"}; # Report header line of longest isoform of each gene
#    print STDOUT "\t".$genelength_hash{$genename}{"coverage"}."\t".$genelength_hash{$genename}{"length"};
#    print STDOUT $genename;
    print STDOUT "\n"; # Start new line for next entry
}

#example_transcripts.fasta.fai
#TRINITY_DN20_c0_g1_i1   247     58      60      61
#TRINITY_DN18_c0_g1_i1   205     372     60      61
#TRINITY_DN21_c0_g1_i1   419     639     60      61
