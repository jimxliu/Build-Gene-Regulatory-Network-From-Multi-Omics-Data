#!usr/bin/perl
use strict;
use warnings;

my $cifNetwork = $ARGV[0]; #  cifNetwork
my $gff = $ARGV[1]; # genes.gff

open(my $fh1, "<$cifNetwork") or die "Can't open file: $!\n";
my %ids;
my $header = <$fh1>;
while(my $row = <$fh1>){
	chomp $row;
	my @array = split(/,/,$row);
	my $id = $array[1];
	#print "$id\n";	
	$id =~ s/"//g;
	#print "$id\n";	
	$ids{$id} = 1;
}
close $fh1;

open(my $fh2,"<$gff") or die "Can open gff: $!\n";
print "Gene_ID\tFunction_Annotation\n";
while(my $row = <$fh2>) {
	chomp $row;
	my @array =  split(/\t/,$row);
	my @attrs =  split(/;/,$array[8]);
	my $id = $attrs[0];
	$id =~ s/ID=//;
	if(exists($ids{$id})){
		#print "Exists $id\n";
		my $note = $attrs[2];
		$note =~ s/Note=//;
		$note =~ s/%20/ /g;
		$note =~ s/%2C/,/g;
		$note =~ s/%2F/\//g;
		print "$id\t$note\n";	
	}		
}
close $fh2;
