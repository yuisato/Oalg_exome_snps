#!/usr/bin/env perl

use strict;
use warnings;

# Filter coverage stats file from bbmap 
# Report contigs with coverage > threshold (default 4.0)

my $mincov = 4.0; # length cutoff value

while (<>) {
    chomp;
    unless (/^#/) { # Ignore header line with regex
    my @splitline = split "\t", $_;
    my $coverage = $splitline[1]; # Get coverage field from bbmap covstats output
    if ($coverage >= $mincov) { # check length over minimum
        my @splitid1 = split " ", $splitline[0]; 
        my @splitid2 = split "_", $splitid1[0];
        my $genename = join "_", @splitid2[0..4]; # Gene name are the first five parts of Trinity header
        print STDOUT $genename;
        print STDOUT "\n"; # Start new line for next entry
        }   
    }
}
