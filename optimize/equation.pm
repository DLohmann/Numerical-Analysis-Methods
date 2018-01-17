package equation;

#####!/usr/bin/perl
#use strict;
#use warnings;


#Constructor
sub new {
	$class = shift;
	$self = {
		#Member Variables
		func => shift,	#pointer to the function that gets evaluated
		name => shift,	#name of the function being evaluated as a string. ie: "f", or "sha256", or "riemann-zeta"
		equation =>	shift	#string of function evaluated. ie: "x^2 - x + 9/4"
	};
	bless $self, $class;	#allows $class to reference member variables in $self
	return $self;
}

#Accessors
sub getName {
	print "getName ran!, name is: $self->{name}\n";
	my $self = @_;
	return $self->{name};
}

sub getEquation {
	my $self = @_;
	return $self->{equation};
}



#Mutators
sub setName {
	my ($self, $new_name) = @_;
	$self->{name} = $new_name if defined ($new_name);
}

sub setEquation {
	my ($self, $new_equation) = @_;
	$self->{equation} = $new_new_equation if defined ($new_new_equation);
}



1;