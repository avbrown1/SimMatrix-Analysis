#!/usr/bin/env perl

# Author: Annie Brown, USDA-ARS at Ames, IA and Andrew Wilkey. 

use strict; 
use warnings; 
use Getopt::Long;

my $usage =<<EOS;
  Synopsis: Extract_Top_Match.pl [options] -in FILE_IN -id ID_NAME
  
  Takes in a rectangular identity matrix  with labels in first row and first column
  and returns the top matches for a given Sample name

  Required:
  -in		Input file name. A tab-delimited matrix
  -id		Name of accession (Sample) to be extracted from the matrix

  Options:
  -hits		for reporting the number of top matches. Default 10
  -verbose	print value from matrix, the identity score for the top match and the given sample
  -self         Include accession in matches
  -help		This message

EOS

my ($in, $id, $help, $verbose, $self);
my $hits = 10;

GetOptions (
  "in=s" =>	\$in,
  "id=s" =>	\$id,
  "hits=i" =>	\$hits,
  "verbose" =>	\$verbose,
  "self" =>	\$self,
  "help" =>	\$help
);

die "\n$usage\n" if ( $help or !defined($in) );

open( my $IN, '<', $in ) or die "can't open in $in: $!";

my @id_ary; # an array to hold IDs from the first row of the matrix
my %matches = ();

while (<$IN>) {
  chomp;
  next if $_ =~ /^$/;
  #$_ =~ s/^\s+|\s+$//g; # remove any leading and trailing whitespaces
  my @ary = split (/\s+/, $_);
  
  if ($. == 1) { # get IDs from first row
    @id_ary = @ary;
  }
  else { # process remaining rows
    my $item_ct = 0;  # position in array
    my $row_id;
    foreach my $a (@ary) {
      if ($item_ct == 0){
        if ($a eq $id) { # remember ID and increment item count, then go onto next item
          $item_ct++;
          next;
        } else {
          last;
	}
      }
      if(!($self) && ($id eq $id_ary[$item_ct]) ){
        $item_ct++;
        next; 
      } else {
        $matches{ $id_ary[$item_ct] } = $a;
        $item_ct++;
      }    
    }
  }
}

my $match_count = 0;

foreach my $id ( sort { $matches{$b} <=> $matches{$a} } keys %matches ) {
  print $id;
  if ($verbose){
    print "\t$matches{$id}";
  }
  print "\n";

  $match_count++;
  if( $match_count == $hits){
    last;
  }
}


#foreach my $key (keys %friends) {
#   print "$key\t$friends{$key}\n";
#   if ($uniquefile) {
#     if ($friends{$key} == 2) {
#      print "$key\n";
#    }
#   }
#}
 
__END__

if $id = $a (@ary) {
    my @tophits = sort {split(/\t/, $b))[$id]

    my @tophits = sort_by {$id} @ary
 
    sort{$b <=> $a} @ary)[0 .. $n-1];

print "Top Hits: $";
