#!usr/bin/perl
use strict;
use warnings;
use List::MoreUtils qw(uniq);

my $file = $ARGV[0]; # nearest.out
my @genes;
open(my $in, "<$file") or die "read: $!\n";
while(my $line = <$in>){
	chomp $line;
	my @array = split(/\t/,$line);
	my @attrs = split(/;/,$array[13]);
	my $id = $attrs[0];
	$id =~ s/ID=//;
	#print $id."\n";
	push @genes, $id;
}
close $in;

open(my $out, ">bind_list.csv") or die "cannot write:$!\n";
my @uniq_genes = sort(uniq(@genes));
#my $count = 1;
print $out "from,to\n";
foreach my $id (@uniq_genes){
	print $out "LOC_Os03g51690,$id\n";
	#$count++;
}
close $out;
