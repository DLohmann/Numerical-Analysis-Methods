#!/usr/bin/env python


def vector_dot (c = 1, A = [], B = []):
	#Dot with a vector
	if (B != []):
		if (len(A) == len(B)):
			vect_prod = sum(A[i]*B[i] for i in range (len(A)) #dot the vectors and multiply by scalar
		else:
			raise ValueError ("Error: can't dot 2 vectors of different lengths.")
			return -1
	elif (c != 1): #B is empty and c is not. So dot scalar c and vector A
		vect_prod = A
		vect_prod = [c*vect_prod_i for vect_prod_i in vect_prod] #scalar dot product.
	
	return vect_prod

A = 1
B = 1

def check(k):
	if (k == 0):
		print ("inside if")
	elif (k == 1):
		print ("inside elif")
	elif (k != 1):
		print ("elif k != 1")



if (B != 0):
	if (A != B):
		print ("Error: can't dot 2 vectors of different lengths")
		return None
	
	print ("vect_prod = sum(A[i]*B[i] for i in range (len(A))")	
elif (c != 1): #B is empty and c is not. So dot scalar c and vector A
	print("vect_prod = A")
	print("vect_prod = [c*vect_prod_i for vect_prod_i in vect_prod]" #scalar dot product.
else:
	print ("hi!")
check(0)
check(1)
check(2)
