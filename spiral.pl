use strict; use warnings; use 5.010; 
use IO::Handle;
use File::Temp "tempfile";
my($T,$N) = tempfile("plot-XXXXXXXX", "UNLINK", 1); 
for my $t (100..500) 
        { say $T $t*sin($t*0.1), " ", $t*cos($t*0.1); } 
close $T;
open my $P, "|-", "gnuplot" or die; 
printflush $P qq[
        unset key
        plot "$N" with lines lw 3
]; 
<STDIN>; 
close $P;
