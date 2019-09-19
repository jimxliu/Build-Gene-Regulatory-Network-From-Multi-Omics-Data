#!usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0]; # "osa.gff3"
open(my $in, "<$file") or die "Can't read file: $!\n";
open(my $out, ">miRNA.map") or die "Can't write to file: $!\n";

#print $out "V1,V2\n";
while(my $line = <$in>) {
	chomp $line;
	my @array = split(/\t/,$line);
	if($line !~ /#/) {
		my $type = $array[2];
		if($type eq 'miRNA'){
			my @attrs = split(/;/,$array[8]);
			my $id =  $attrs[0];
			my $name = $attrs[2];
			$id =~ s/ID=//;
			$name =~ s/Name=//; 
			print $out "$id,$name\n";
		}
	}			
}

close $in;
close $out;
