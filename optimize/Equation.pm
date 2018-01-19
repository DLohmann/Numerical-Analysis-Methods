package Equation;
use strict;
use warnings;


#Constructor
sub new {
=begin comment
	my ($class, $func, $name, $equation) = @_;
	return bless 
=cut
#=begin comment
	$class = shift;
	$self = {
		#Member Variables
		func => shift,	#pointer to the function that gets evaluated
		name => shift,	#name of the function being evaluated as a string. ie: "f", or "sha256", or "riemann-zeta"
		expression =>	shift	#string of function evaluated. ie: "x^2 - x + 9/4"
	};
	bless $self, $class;	#allows $class to reference member variables in $self
	return $self;
#=cut
}

#Accessors
sub getName {
	print "getName ran!, name is: $self->{name}\n";
	my ($self) = @_;
	#return "f";	#$self->{name};
	return $self->{name};
}

sub getExpression {
	my ($self) = @_;
	return $self->{expression};
}



#Mutators
sub setName {
	my ($self, $newName) = @_;
	$self->{name} = $newName if defined ($newName);
}

sub setExpression {
	my ($self, $newExpression) = @_;
	$self->{expression} = $newExpression if defined ($newExpression);
}



1;