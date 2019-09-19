#!usr/bin/perl
use strict;
use warnings;

my $file = "chipseq_peaks.xls.fmt";
my $number = 1;
open(my $fh, "<$file") or die "Can't open file:$!";
open(my $out, ">chipseq_peaks_filtered3.bed") or die "Can't open file:$!";
while(my $line = <$fh>) {
	chomp $line;
	my @array = split(/\t/,$line);
	my $fdr = $array[8];
	my $fe = $array[7];
	if($fdr < 5 and $fe > 100){
		my $chr = $array[0];
		my $start = $array[1];
		my $end = $array[2];		
		my $name = "MACS_peak_$number";
		my $pvalue = $array[6];
		print $out "$chr\t$start\t$end\t$name\t$pvalue\n";
		$number++;
	}	
	
}
close $fh;
close $out;
