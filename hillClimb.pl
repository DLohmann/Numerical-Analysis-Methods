#!/usr/bin/perl

# This finds the minimum of an equation using a hill climbing method

=begin comment
sub Average {
   # get total number of arguments passed.
   $n = scalar(@_);
   $sum = 0;

   foreach $item (@_) {
      $sum += $item;
   }
   $average = $sum / $n;

   print "Average for the given numbers : $average\n";
}

Average(10, 20, 30);

=cut

#use strict;


# initialize hill equation:
sub f {	# f(x) = (x - 1)^2 + 1 
	my $num = scalar(@_);
	#print "Number of parameters: $num\n";
	
	
	my $ans = ($_[0] - 1)**2 + 1;
	
	#print "f($_[0]) is $ans\n";
	
	return $ans;
}

#Hillclimb algorithm that moves downhill in 1 dimension, until it finds a (local) min
sub hillClimb {
	my $h = 1;
	print "starting at $_[0]\n";
	my $x = $_[0];	#parameter 0 is the initial start point
	
	my $right = f($x + $h);
	my $val = f($x);
	my $left = f($x - $h);
	
=begin comment
	while (!(($val <= $right) && ($val <= $left))) {
		if ($f($x) > $f($x + $h)) {
			$x += $h;
			print "moved x right by $h to $x\n";
		} elsif ($f($x) > $f($x - $h)) {
			$x -= $h;
			print "moved x right by $h to $x\n";
		} else {
			print "Flat terrain found at x = $x\n";
			return $x;
		}
		
	}
=cut
	
	#=begin comment
	while (!((f($x) <= f($x + $h)) && (f($x) <= f($x - $h)))) {
		if (f($x) > f($x + $h)) {
			$x += $h;
			print "moved x right by $h to $x\n";
		} elsif (f($x) > f($x - $h)) {
			$x -= $h;
			print "moved x right by $h to $x\n";
		} else {
			print "Flat terrain found at x = $x\n";
			return $x;
		}
		
	}
	
	print "found min at $x\n";
	return $x;
	#=cut
}

# initialize start point:
my $x0 = -3.1;
$val = hillClimb($x0);
print "Min of function f (starting at $x0) is: $val \n";





