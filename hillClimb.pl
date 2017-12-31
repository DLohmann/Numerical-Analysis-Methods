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
sub f1 {	# f1(x) = (x - 1)^2 + 1 
	return ($_[0] - 1)**2 + 1;
}


sub g {		# g(x) = (x-1)(x-2)(x-3)
	return ($_[0] - 1)*($_[0] - 2)*($_[0] - 3);
}

sub f2 {	# f2(x) = (x - 1)^2 + (y - 1)^2 + 1 
	return ($_[0] - 1)**2 + ($_[1] - 1)**2 + 1;
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

#HillClimb algorithm that moves downhill in N dimensions along axial direction of each parameter, until it finds a (local) min. Accurate to within 1h (1 step size)
sub hillClimb {
	my $h = 1;	#initial step size (might decrease by half later to get a result to within a smaller tolerance)
	my $f = $_[0];	#parameter 0 is the function to find the minimum of
	my $tol = $_[1];	#parameter 1 is the tolerance. Min will be found to within this tolerance
	#my $x = $_[2];	#parameter 2 is the initial start point
	my @xArr = @_[2..$#_];	#array of all independent variables (inputs) to function. Set these to initial condition of point. parameter 2.. are the coordinates of initial point
	my $numDimensions = scalar(@_) - 1;	#number of dimensions = number of parameters - 1. (parameter 0 = function or dependent variable to optimize, parameter 2 = tolerance). Includes the dependent variable being minimized (the function f)
	my $numSteps = 0;	#count number of max steps to take. Quit after taking this many
	
	my $i = 0;
	my @xLeft = @xArr[0..($i-1)];	#All parameters left of parameter being optimized
	my $xCenter = $xArr[$i];	#parameter being optimized
	my @xRight = @xArr[($i+1)..(scalar(@xArr) - 1)];	#All parameters right of parameter being optimized

	my $yVal = $f->(@xArr);	#output of function. The value of dependent variable at the current point x.
	my $partitionedYVal = $f->(@xLeft, $xCenter, @xRight);	#should be same as yVal. If not, something screwed up
	my $shiftedRightY = $f->(@xLeft, $xCenter + $h, @xRight);	#yVal of 1 step to right		
	my $shiftedLeftY = $f->(@xLeft, $xCenter - $h, @xRight);	#yVal of 1 step to left
	
	
	
	print "\nHillClimb in $numDimensions dimension(s): Min of function (with initial step size = $h):\n";
	
	#INDICATE INITIAL POINT (might be in several dimensions)
	#print all Independent variables first
	print "Independent variables: @xArr \n";
	print "Initial point: (";
	for ($i = 2; $i <= $numDimensions; $i += 1) {
		print "$_[$i], ";
	}
	#print dependent variable (function value at initial point) last
	print "$yVal)\n";
	
	#INDICATE TOLERANCE
	print "Tolerance: $tol\n";
	

	#this loop checks if a local min has been found to within a tolerance
	#while no near point (within tolerance) is lower

	#this loop optimizes each independent variable one by one
	for ($i = 0; $i < scalar(@xArr); $i += 1) {
		print "parameter $i is being optimized: @xArr[0..($i-1)] <$xArr[$i]> @xArr[($i+1)..(scalar(@xArr) - 1)]\n";
		$h = 1;	#reset the step size every time a new variable is optimized
		
		#output of function. The value of dependent variable at the current point x.
		
		@xLeft = @xArr[0..($i-1)];	#All parameters left of parameter being optimized
		$xCenter = $xArr[$i];	#parameter being optimized
		@xRight = @xArr[($i+1)..(scalar(@xArr) - 1)];	#All parameters right of parameter being optimized

		$yVal = $f->(@xArr);	#get the new yVal with current independent variables
		$partitionedYVal = $f->(@xLeft, $xCenter, @xRight);	#should be same as yVal. If not, something screwed up
		$shiftedRightY = $f->(@xLeft, $xCenter + $h, @xRight);	#yVal of 1 step to right		
		$shiftedLeftY = $f->(@xLeft, $xCenter - $h, @xRight);	#yVal of 1 step to left
		
		while (($yVal > $f->(@xLeft, $xCenter + $tol, @xRight)) || ($yVal > $f->(@xLeft, $xCenter - $tol, @xRight))) {
			#this loop optimizes a single independent variable in 1 dimension.
			
			@xLeft = @xArr[0..($i-1)];	#All parameters left of parameter being optimized
			$xCenter = $xArr[$i];	#parameter being optimized
			@xRight = @xArr[($i+1)..(scalar(@xArr) - 1)];	#All parameters right of parameter being optimized

			$yVal = $f->(@xArr);	#get the new yVal with current independent variables
			$partitionedYVal = $f->(@xLeft, $xCenter, @xRight);	#should be same as yVal. If not, something screwed up
			$shiftedRightY = $f->(@xLeft, $xCenter + $h, @xRight);	#yVal of 1 step to right		
			$shiftedLeftY = $f->(@xLeft, $xCenter - $h, @xRight);	#yVal of 1 step to left
=begin comment
			print "xArr == @xArr\n";
			print "xLeft == @xLeft\n";
			print "xCenter == $xCenter\n";
			print "xRight == @xRight\n";
			
			print "f(yVal)                  == f(@xArr)             == $yVal\n";
			print "f(..., xCenter,     ...) == f(@xLeft, $xCenter,     @xRight) == $partitionedYVal\n";
			print "f(..., xCenter + h, ...) == f(@xLeft, $xCenter + $h, @xRight) == $shiftedRightY\n";
			print "f(..., xCenter - h, ...) == f(@xLeft, $xCenter - $h, @xRight) == $shiftedLeftY\n";
=cut
			if ($yVal > $shiftedRightY) {
				$xArr[$i] += $h;
				print "moved x$i right by $h to $xArr[$i]\n";
			} elsif ($yVal > $shiftedLeftY) {
				$xArr[$i] -= $h;
				print "moved x$i left  by $h to $xArr[$i]\n";
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
					print "Flat terrain found at x$i = $xArr[$i]\n";
					last;	#same as 'break' statement in most languages 
					#return @xArr;
				}
			}
			$numSteps += 1;
			if ($numSteps > 100) {
				print "Min not found within 100 steps; giving up\n";
				return @xArr;
			}
		}
	}
	
	print "found min at f(@xArr) == $yVal\n";
	return @xArr;
}

# initialize start point:
my $x0 = 9.5;
my $x1 = 10.7;
my $tol = 0.001;

print "\n\n3 DIMENSIONAL OPTIMIZATION\n";
my @inputs = hillClimb(\&f2, $tol, $x0, $x1);
my $val = f2(@inputs);
print "Min of function f2 (starting at ($x0, $x1), to within tolerance $tol, initial step size = 1) is: f(@inputs) == $val\n";

print "\n\n2 DIMENSIONAL OPTIMIZATION\n";
@inputs = hillClimb(\&f1, $tol, $x0);
$val = f1(@inputs);
print "Min of function f1 (starting at ($x0), to within tolerance $tol, initial step size = 1) is: f(@inputs) == $val\n";


#@val = hillClimb(\&g, $tol, $x0, 6, 7, 8);
#print "Min of function f (starting at $x0, to within tolerance $tol, initial step size = 1) is: @val \n";

#$val = gradDes($x0, 1);
#print "gradDesce: Min of function f (starting at $x0) is: $val \n";




