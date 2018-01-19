#!/usr/bin/env perl
#use strict;
#use warnings;
use lib 'optimize';
use Equation;

my $parabola = new Equation (1, "f", "(x - 1)^2 + 1");
my $name = $parabola->getName();
print "name: $name\n";

my $expression = $parabola->getExpression();
print "expression: $expression\n";

#my $str = $parabola->getName();

#print "$str\n";



=begin comment
#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use Equation;

my $parabola = Equation->new (1, "f", "(x - 1)^2 + 1");
my $name = $parabola->getName();
print "name: $name\n";

#my $str = $parabola->getName();

#print "$str\n";
=cut