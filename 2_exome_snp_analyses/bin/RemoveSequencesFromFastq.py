#!/usr/bin/env python

# Removes records in list of read names from Fastq file
# Adapted from http://seqanswers.com/forums/showthread.php?t=14708
# The .split(None,1)[0] Fastq files that include the " 1:N:0:CGATGT" at the end of read names are compatible with lists of read names that do not include this part of the read name (e.g. sam files from bowtie2)


import sys
from Bio.SeqIO.QualityIO import FastqGeneralIterator

input_file = sys.argv[1]
id_file = sys.argv[2]
output_file = sys.argv[3]


remove = set(line.rstrip("\n").split(None,1)[0] for line in open(id_file))
print "Found %i unique identifiers in %s" % (len(remove), id_file)
#print remove

count = 0
handle = open(output_file, "w")
for title, seq, qual in FastqGeneralIterator(open(input_file)) :
    #print title.split(None,1)[0]
    if title.split(None,1)[0] not in remove:
        handle.write("@%s\n%s\n+\n%s\n" % (title, seq, qual))
        
        count += 1
handle.close()

print "Saved %i records from %s to %s" % (count, input_file, output_file)
if count < len(remove):
    print "Warning %i IDs not found in %s" % (len(remove)-count, input_file)