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

=begin comment
sub f {	# f(x) = (x - 1)^2 + 1 
	my $num = scalar(@_);
	#print "Number of parameters: $num\n";
	
	
	my $ans = ($_[0] - 1)**2 + 1;
	
	#print "f($_[0]) is $ans\n";
	
	return $ans;
}
=cut

sub g {	# g(x) = (x-1)(x-2)(x-3)
	return ($_[0] - 1)*($_[0] - 2)*($_[0] - 3);
}

#Gradient descent algorithm that moves downhill in 1 dimension, until it finds a (local) min. Accurate to within 1 tolerance
#*************I think that this is not the correct gradient descent algorithm. Correct algorithm can be found here: https://en.wikipedia.org/wiki/Gradient_descent#Python
sub gradDes {
	my $h = 1;
	print "\nGradient Descent: starting at $_[0]\n";
	my $x = $_[0];	#parameter 0 is the initial start point
	my $tol = $_[1];	#parameter 1 is the tolerance. Min will be found to within this tolerance
	my $leftBound = -100;	#left bound that min must be right of
	my $rightBound = 100;	#right bound that min must be left of
	
#=begin comment
	while (!((f($x) <= f($x + $tol)) && (f($x) <= f($x - $tol)))) {
		if (f($x) > f($x + $h)) {
			$h = 1 * (f($x) - f($x + $h));
			$leftBound = $x;
			$x += $h;
			print "moved x by +$h to $x\n";
		} elsif (f($x) > f($x - $h)) {
			$h = 1 * (f($x) - f($x - $h));
			$rightBound = $x;
			$x -= $h;
			print "moved x by -$h to $x\n";
		} else {
			print "Flat terrain found at x = $x\n";
			return $x;
		}
		
	}
	
	print "found min at $x\n";
	return $x;
#=cut
}

#Hillclimb algorithm that moves downhill in 1 dimension, until it finds a (local) min. Accurate to within 1h (1 step size)
sub hillClimb {
	my $h = 1;
	my $x = $_[0];	#parameter 0 is the initial start point
	my $tol = $_[1];	#parameter 1 is the tolerance. Min will be found to within this tolerance
	my $f = $_[2];	#parameter 2 is the function to find the minimum of
	
	my $numSteps = 0;
	print "\nHillClimb: Min of function (starting at $x, to within tolerance $tol, with initial step size = $h):\n";
#=begin comment
	while (($f->($x) > $f->($x + $tol)) || ($f->($x) > $f->($x - $tol))) {
		if ($f->($x) > $f->($x + $h)) {
			$x += $h;
			print "moved x right by $h to $x\n";
		} elsif ($f->($x) > $f->($x - $h)) {
			$x -= $h;
			print "moved x left by $h to $x\n";
		} else {
			#if, with the current step size $h, the area in front is no longer downhill,
			#then decrease the step size by half (until it is within the tolerance)
			#and keep going downhill
			
			#when flat terrain is found, we may have overshot the min point.
			#so decrease the step size $h by half, until it is within the tolerance
			if ($h > $tol) {
				$h = $h/2;
				print "decreasing h by half to $h\n";
			} else {
				print "Flat terrain found at x = $x\n";
				return $x;
			}
		}
		$numSteps += 1;
		if ($numSteps > 100) {
			print "Min not found within 100 steps; giving up\n";
			return $x;
		}
	}
	
	print "found min at $x\n";
	return $x;
#=cut
}

# initialize start point:
my $x0 = 5;
my $tol = 0.000001;

#$val = g(0);
#print "g(0) = $val\n";
$val = hillClimb($x0, $tol, \&g);
print "Min of function f (starting at $x0, to within tolerance $tol, initial step size = 1) is: $val \n";

#$val = gradDes($x0, 1);
#print "gradDesce: Min of function f (starting at $x0) is: $val \n";





