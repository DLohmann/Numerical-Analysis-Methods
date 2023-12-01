#!/usr/bin/env python
import sys
import math as m
def Halley (a):
	x = a
	while (m.fabs(x*x - a) > 0.5):
		x2 = x*x
		x3 = x2*x
		x = (x3+(3*a*x))/(3*x2 + a)
	return x

P = 0
if (len(sys.argv) == 2):
	P = int(sys.argv[1])
else:
	P = 10**50
print ("P is: " + str(P) + "\n")

print ("Sqrt(P) is: " + str(Halley (P)) + "\n")
