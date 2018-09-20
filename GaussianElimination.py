#!/usr/bin/env python

import random as rand # used for fuzz testing
import numpy as np # used for allclose method

def vector_scalar_multiply(c, A):
	return [c*A_i for A_i in A]
	
def vector_multiply (A, B):
	if (len(A) != len(B)): # Error checking
		raise ValueError ("Error: can't dot 2 vectors of different lengths.")
		return None
	return sum(A[i]*B[i] for i in range (len(A)))
	
#IS THERE ANY WAY TO SPECIFY DATA TYPE OF PARAMETERS IN FUNCTION? IE, C = SCALAR, A AND B ARE ARRAYS?
#def vector_dot (c = 1, A = [], B = []):
#	vect_prod = A
#	if (c != 1):
#		vect_prod = vector_scalar_multiply(c, vect_prod)
#	if (B != []):
#		vect_prod = vector_multiply(vect_prod, B)
#	return vect_prod
	
	
	
	
	'''
	if (A == [] or (c == 1 and B == [])):
		print ("Error: Can't dot an empty vector")
		return None
	
	vect_prod = 0
	
	#Dot with a vector
	if (B != []):
		if (len(A) == len(B)):
			vect_prod = sum(A[i]*B[i] for i in range (len(A))) #dot the vectors and multiply by scalar
		else:
			raise ValueError ("Error: can't dot 2 vectors of different lengths.")
			#return -1
		#return sum(A[i]*B[i] for i in range (len(A))
		#if (True):
		#	print ("hi")
		#if (c != 1):
		#	return c*vect_prod	#after dotting vectors, check if scalar should be dotted
	elif (c != 1): #B is empty and c is not. So dot scalar c and vector A
		vect_prod = A
		vect_prod = [c*vect_prod_i for vect_prod_i in vect_prod] #scalar dot product.
	
	return vect_prod
	'''

def vector_add (A, B):
	if (len(A) != len(B)):
		print ("Error: vectors are not same length")
		return None
	return [A[i] + B[i] for i in range (len(A))]

def matrix_vector_multiply (A, b):
	
	#-----COPIED AND PASTED FROM Gaussian_Elimination-----
	#Check that A's row length matches b's vector length, so that multiplication is valid.
	if (len(A[0]) != len(b)):
		print ("Error: To multiply matrix A by vector b, the number of columns in A must equal the number of entries in b")
		raise ValueError ("Cannot multiply a matrix with ", len(A[0]), " columns by a matrix with ", len(b), " entries. They must be the same!")
	#-----END OF COPY AND PASTE-----
	
	x = [vector_multiply (A_row, b) for A_row in A]
	#x = [vector_multiply (A[i], b) for i in range(len(b))]
	'''
	x = [None]*len(b)
	for i in range(b):
		x[i] = vector_multiply (A[i], b)
	'''
	return x
	

def Gaussian_Elimination (A, b):	# Solves problems of the form Ax = b. The inputs are A, a matrix, and b, a vector. Solves for, and returns x, a vector
	print ("Performing Gaussian Elimination")
	print ("A = ", A, ", b = ", b)
	
	#Check that A's row length matches b's vector length, so that multiplication is valid.
	if (len(A[0]) != len(b)):
		print ("Error: To multiply matrix A by vector b, the number of columns in A must equal the number of entries in b")
		print ("The result of the multiplication will have the same amount of entries as b")
		raise ValueError ("Cannot multiply a matrix with ", len(A[0]), " columns by a matrix with ", len(b), " entries. They must be the same!")
	
	#TODO: ERROR CHECKING:
	#Check that A is a rectangular array of arrays???
	#eliminate/exclude linearly dependent (duplicate) rows/columns???
	#If underdetermined, return error
	#If overdetermined, get rid of data, then cross-reference with excluded data to check if it agrees
	#Guarantee that this code never divides by 0, but always checking if an entry is 0 before dividing by it. If it is 0, then find the solution another way
	#If a row operation results in a row of all 0's, then we know that rows are not linearly independent??? So get rid of the 0 row???
	
	#TODO: OPTIMIZATION:
	#Re-order rows (or even columns?) to get into RREF format more easily
	#Don't need to multiply by 1 or add by 0 when doing row operations. Can skip this part when doing row operations on elements that are guaranteed to be 1 or 0
	#Code C/C++, and connect to CPython with C/C++ extension
	#Find a faster algorithm than Gaussian Elimination???
	#When converting from REF to RREF, when 0ing out entries above diagonal by subtracting rows, don't iterate through looking for a row to subtract by, and instead just subtract by the row with a 1 in that column on the diagonal, which is guaranteed to work just as well.
	
	#TODO: ORGANIZE:
	#Make 2 functions called makeOne(A, rowNum, columnNum) and  makeZero(A, rowNum, columnNum) that do row or column operations on A to make the entry A[rowNum, columnNum] be 1 or 0
	#Add symbolic solve functionality??? Would be hard, since we don't know whether we can divide y a variable "entry" unless we know that "entry" is NOT 0. Maybe there could be an option for the user to specify that a variable is definitely not 0, so program assumes it is not???
	
	
	Ag = [A[rowIndex][0::]+ [b[rowIndex]] for rowIndex in range(len(A[0]))] # Forms augmented matrix Ag
	print ("Ag = ", Ag)
	
	
	
	#Performs the actual Gaussian elimination
	#Moves down through the rows, and then right through the columns, to get row echelon form. Ignore the rightmost column of Ag (the solution vector), by iterating over row and column indexes of A instead of Ag (ie "for row in A (not Ag), for column in A (not Ag)")
	for columnNum in range(len(A[0])):	# go through each column after going through each row
		for rowNum in range(len(A)):	# go through each row, from the middle diagonal to bottom.
			
			print ("\n\nNow at entry Ag[", rowNum, "][", columnNum, "] == ", Ag[rowNum][columnNum])
			
			if (rowNum < columnNum):
				print ("skipping")
				continue	# skip entries above the diagonal (for now) to only get row echelon form, but not reduced row echelon form
			
			row = Ag[rowNum]
			
			if (rowNum > columnNum):# Check if the entry is below the diagonal, and thus should be a 0 (like in the identity matrix)
			
				#-----COPIED AND PASTED TO RREF BELOW-----
				# We want to do row operations to set this entry Ag[rowNum][columnNum] to 0.
				# To do this we can find a way to set a value below this entry to the value in this entry 
				#(by multiplying the row below by a constant), and subtract this entire row by the row below multiplied by a constant
				if (Ag[rowNum][columnNum] == 0):	#check if it's already 0. If so, then skip
					print ("skipping")
					continue
				
				print ("Make this entry 0")
				
				# Find a different row such that it's entry in this column is non-zero (but all the entries left of this are 0). Then set the variable "dummyRow" to this.
				# Find a row that looks like:
				#  0, 1, 2, ..., columnNum - 1, columnNum, columnNum+1, columnNum+2, ..., len(A[0])
				# [0, 0, 0, ..., 0            , non-zero , anything   , anything   , ..., anything ], and this row is not row rowNum!
				# And this row (addedRowNum) must NOT be the same as rowNum (to ensure vectors are linearly independent)
				# This row will be multiplied by a constant and added to the current row (rowNum's row) to make it 0
				addedRowNum = 0
				for addedRowNum in range (len(Ag)):
					if (all(Ag[addedRowNum][i] == 0 for i in range(0, columnNum)) and Ag[addedRowNum][columnNum] != 0 and addedRowNum != rowNum):
						break
				#print ("addedRowNum = ", addedRowNum)
				if (addedRowNum == len(Ag)):	# If the "for" loop ended without finding a row (besides numRow) that has a non-zero entry in the current column numColumn
					print ("Error: row ", rowNum, " is the only row with a non-zero entry in the ", columnNum, "th column. So either can't find this variable, or this entry should be pivot")
				dummyRow = vector_scalar_multiply(-1*(Ag[rowNum][columnNum]/Ag[addedRowNum][columnNum]), Ag[addedRowNum])
				row = vector_add (row, dummyRow)
				
				#row = [Ag[rowNum][columnNum] -  for rowEntry in row]
				print ("R", (rowNum), "* = R", (rowNum), " - (", Ag[rowNum][columnNum], "/", Ag[addedRowNum][columnNum], ") * R", (addedRowNum))
				#-----END OF COPY AND PASTE-----
				
			elif (rowNum == columnNum): # Check if the entry is on the diagonal, and thus should be a 1 (like in the identity matrix)
				# We want to do row operations to set this entry Ag[rowNum][columnNum] to 1.
				# To do this we can find what the value in this entry is, and divide this entire row by that value
				if (Ag[rowNum][columnNum] == 1):	#check if it's already 1. If so, then skip
					print ("skipping")
					continue
					
				print ("Make this entry 1")
				row = [rowEntry/Ag[rowNum][columnNum] for rowEntry in row]	#vector_dot(1/Ag[rowNum][columnNum], row)
				print ("R", (rowNum), "* = (1/", Ag[rowNum][columnNum], ")*R", (rowNum))
				
			else:
				print ("Error: got an entry above the diagonal of the matrix???")
			
			Ag[rowNum] = row
			print("Ag is: ", Ag)
	
	print ("\n\n\n\nMatrix now in row-echelon form (0's below diagonal, 1's on diagonal).\nGetting it in reduced row-echelon form (1's on diagonal, 0's everywhere else):")
	
	#Now that Ag is in row echelon form, we can get it in reduced row echelon form by making all entries above the diagonal 0:
	for columnNum in range(1, len(A[0])):	# go through each column after going through each row
		for rowNum in range(columnNum):	# go through each row, from the middle diagonal to bottom.
			print ("\n\nNow at entry Ag[", rowNum, "][", columnNum, "] == ", Ag[rowNum][columnNum])
			row = Ag[rowNum]
			#-----COPIED AND PASTED FROM 0ing OUT ABOVE-----
			# We want to do row operations to set this entry Ag[rowNum][columnNum] to 0.
			# To do this we can find a way to set a value below this entry to the value in this entry 
			#(by multiplying the row below by a constant), and subtract this entire row by the row below multiplied by a constant
			if (Ag[rowNum][columnNum] == 0):	#check if it's already 0. If so, then skip
				print ("skipping")
				continue
			
			print ("Make this entry 0")
			
			# Find a different row such that it's entry in this column is non-zero (but all the entries left of this are 0). Then set the variable "dummyRow" to this.
			# Find a row that looks like:
			#  0, 1, 2, ..., columnNum - 1, columnNum, columnNum+1, columnNum+2, ..., len(A[0])
			# [0, 0, 0, ..., 0            , non-zero , anything   , anything   , ..., anything ], and this row is not row rowNum!
			# And this row (addedRowNum) must NOT be the same as rowNum (to ensure vectors are linearly independent)
			# This row will be multiplied by a constant and added to the current row (rowNum's row) to make it 0
			addedRowNum = 0
			for addedRowNum in range (len(Ag)):
				if (all(Ag[addedRowNum][i] == 0 for i in range(0, columnNum)) and Ag[addedRowNum][columnNum] != 0 and addedRowNum != rowNum):
					break
			#####print ("addedRowNum = ", addedRowNum)
			if (addedRowNum == len(Ag)):	# If the "for" loop ended without finding a row (besides numRow) that has a non-zero entry in the current column numColumn
				print ("Error: row ", rowNum, " is the only row with a non-zero entry in the ", columnNum, "th column. So either can't find this variable, or this entry should be pivot")
			dummyRow = vector_scalar_multiply(-1*(Ag[rowNum][columnNum]/Ag[addedRowNum][columnNum]), Ag[addedRowNum])
			#####print ("dummyRow == vector_scalar_multiply(", -1*Ag[rowNum][columnNum], "/", Ag[addedRowNum][columnNum], ",", Ag[addedRowNum], ") == ", dummyRow)
			row = vector_add (row, dummyRow)
			#####print ("row == vector_add (", row, ", ", dummyRow, ") == ", row)
			#row = [Ag[rowNum][columnNum] -  for rowEntry in row]
			print ("R", (rowNum), "* = R", (rowNum), " - (", Ag[rowNum][columnNum], "/", Ag[addedRowNum][columnNum], ") * R", (addedRowNum))
			#-----END OF COPY AND PASTE-----
			Ag[rowNum] = row
			print("Ag is: ", Ag)
			
	X = [row[-1] for row in Ag]	# x is the rightmost column of Ag
	print ("X = ", X)
	return X
	


def Gaussian_Elimination_Fuzz_Test_Reals (numTrials = 5):
	rand.seed(0)
	
	#TODO: Test non-square matrices
	#Test matrices with duplicate vectors (but scaled differently), and with both duplicate row vectors, and duplicate column vectors. Test with vectors that are linearly dependent
	#Test with numbers outside domain 0 to 1 (what rand-range function gives) to test for floating point rounding errors.
	#Test matrices with only integers. This increases the chances that some entries are 0, which will test for dividing by 0. This ensures that 0 entries won't mess up
	
	numPassed = 0
	
	for trialNum in range(numTrials):
		print ("\n\n\n\nTrial ", trialNum, " beginning!!!\n")
		sideLength = rand.randrange(2, 5)	# test square matrices with sideLengthths from 2 - 5 (4 - 25 entries)
		A = [[rand.random() for columnNum in range(sideLength)] for rowNum in range (sideLength)]
		b = [rand.random() for entry in range(sideLength)]
		x = Gaussian_Elimination (A, b)
		
		passed = all(
						np.allclose(
							matrix_vector_multiply(A, x), b
						) for entry in x
					)
					
		print ("Trial ", trialNum, " PASSED" if passed else " FAILED")
		if (passed):
			numPassed += 1
	return numPassed
# Find determinant of a matrix
#def determinant ():

def main():
	#TODO: Make the print-debug statements turn on or off with a debug option. There is a way to turn on or off debugging statements in Python
	'''
	c = 2
	A1 = [1, 2]
	A2 = [3, 4]
	print ("vector_add(", A1, ", ", A2, ") = ", vector_add(A1, A2))
	
	
	print ("vector_dot(", c, ", ", A1, ") = ", vector_dot(c, A1))
	print ("vector_dot(", A1, ", ", A2, ") = ", vector_dot(A1, A2))
	print ("vector_dot(", c, ", ", A1, ", ", A2, ") = ", vector_dot(c, A1, A2))
	'''
	
	A = [[2, -4], 
		 [1, 3]]
	b = [10,
		 -5]
	
	#print ("Solution0 is: ", Gaussian_Elimination(A, b))
	'''
	print ("Solution1 is:", Gaussian_Elimination(
												[[1, 3, 1],
												 [2, 1, 4],
												 [0, 3, 1]],
												 [1,
												  0,
												  2])
												)
	
	print ("Solution2 is:", Gaussian_Elimination(
												[[1, 3, 1],
												 [2, 1, 4],
												 [0, 3, 1]],
												 [1,
												  0,
												  2])
												)
	
	#Test a few vectors for linear independence (if the result is a vector of all 0's):
	
	#This result should be all 0's, indicating linear independence
	print ("Solution3 is:", Gaussian_Elimination(
												[[2, 1, 4],
												 [2, -1, 2],
												 [0, 1, -2]],
												 [0,
												  0,
												  0])
												)
	
	
	#This result should be not linearly independent (because of duplicated, scaled up vectors 2*[2, 1] == [4, 2])
	
	#SOLUTIONS 4-5 CAUSE DIVIDE BY 0!
	print ("Solution4 is:", Gaussian_Elimination(
												[[2, 1],
												 [4, 2]],
												 [0,
												  0])
												)
	
	print ("Solution5 is:", Gaussian_Elimination(
												[[2, 1, 1],
												 [4, 2, 5],
												 [1, 2, 3]],
												 [0,
												  0,
												  0])
												)
	'''
	
	print (Gaussian_Elimination_Fuzz_Test(), " of 5  tests passed")
	
	#determinant. Can be used for Cramer's rule
	return

#if this file is the module being run, __name__ == '__main__' Otherwise __name__ is name of module being run
if __name__ == '__main__':
	main()