#!/usr/bin/perl
use strict;
use warnings;
use lib 'optimize';
use equation;

my $parabola = new equation (1, "f", "(x - 1)^2 + 1");
print "name: ";

print ($parabola->getName());

#my $str = $parabola->getName();

#print "$str\n";