#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
# Authors: Steven Cannon, Annie Brown, USDA-ARS at Ames, IA

my $usage = <<EOS;
  Synopsis: sim_matrix_to_pairs.pl [options] -in FILE_IN 
  
  Takes in a rectangular identity matrix, with labels in first row and first column
  and returns a list of pairs that are within the specified identity.
  Identity in the matrix is indicated by 1.
  
  Required:
  -in        Input file name. A tab-delimited matrix
  
  Options:
  -identity  for reporting pairs from the matrix. Default 0.9

  -verbose  Print value from matrix, for each pair of identifiers

  -help    This message. 

  Note: the output from this file can be clustered using blinkPerl.pl, as follows:
    blinkPerl.pl -i test_array.out -o test_array.cl -s test_array.sum

EOS

my ($in, $help, $verbose);
my $identity = 0.9;

GetOptions (
  "in=s" =>        \$in,
  "identity:f" =>  \$identity,
  "help" =>        \$help,
  "verbose" =>     \$verbose
);

die "\n$usage\n" if ( $help or !defined($in) );

open( my $IN, '<', $in ) or die "can't open in $in: $!";

my @id_ary = (); # an array to hold IDs from the first row of the matrix
while (<$IN>) {
  chomp;
  next if $_ =~ /^$/;
  #$_ =~ s/^\s+|\s+$//g; # remove any leading and trailing whitespaces
  my @ary = split (/\s+/, $_);
  
  if ($. == 1) { # get IDs from first row
    @id_ary = @ary;
    #foreach my $a (@id_ary) { print "$a," } # print IDs
    #print join(',',@id_ary);  # print "\n";
  }
  else { # process remaining rows
    my $item_ct = 0;
    my $row_id;
    foreach my $a (@ary) {
      if ($item_ct == 0) { # remember ID and increment item count, then go onto next item
        $row_id = $a; 
        $item_ct++;
        next;
      } 
      if ($a >= $identity) {
        if ($row_id ne $id_ary[$item_ct]){ # skip self-matches - which should be identical
        	if ($verbose) { # print value at this cell
        	  print "$row_id\t$id_ary[$item_ct]\t$a\n";
        	}
        	else { # not verbose
        	  print "$row_id\t$id_ary[$item_ct]\n";
        	}
	}
      }
      $item_ct++;
    }
  }
}

__END__
VERSIONS

v0.01 17-02-01 Script started: parse_identity_matrix.pl
v0.02 17-02-03 fix some comments. Rename to sim_matrix_to_pairs.pl

