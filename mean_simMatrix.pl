#!/home/abrown1/miniconda3/bin/perl
use strict;
use warnings;

my ($sum,$count);
my $min = 1;
my $firstline = 1;

while (<>) {
    if ($firstline == 1 ){
       $firstline = 0;
       next;
    }
    my @line = split(/\t/,$_);
    my $len = scalar(@line) -1;
    for( my $i = 1; $i < $len; $i++){
        my $val = $line[$i];
        if ($val != 1) {
            if ($val < $min) { 
              $min = $val;
	    }
	    $sum += $val;
	    $count++;
	}
    }
}

print "Min: ".$min."\nMean: ".($sum/$count)."/n";
