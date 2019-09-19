#!usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0]; # gene_exp_siginificant.diff

open(my $in, "<$file") or die "Can't read: $!\n";
open(my $out, ">exprdata.csv") or die "Can't write to: $!\n";
print $out "ID,symbols,logFC,P.Value\n";

#my $count = 1;
while(my $line = <$in>){
	chomp $line;
	my @array = split(/\t/,$line);
	my $id = $array[0];
	my $symbol = $array[1];
	my $fc = $array[9];
	my $fdr = $array[12];
	print $out "$id,$symbol,$fc,$fdr\n";
	#$count++;		
}
close $out;


