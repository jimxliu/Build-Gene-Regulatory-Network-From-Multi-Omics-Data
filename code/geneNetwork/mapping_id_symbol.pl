#!usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0]; # nearest.out
my %map;
open(my $in, "<$file") or die "Can't read: $!\n";

while(my $line = <$in>) {
	chomp $line;
	my @array = split(/\t/,$line);
	my @attrs = split(/;/,$array[13]);
	my $id = $attrs[0]; 
	$id =~ s/ID=//;
	my $name = $attrs[1];
	$name =~ s/Name=//;
	if($name ne $id){
		print $id."\t".$name."\n";
	}
}
close $in;
