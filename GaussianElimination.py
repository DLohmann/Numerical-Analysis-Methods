#!/usr/bin/env python


def vector_dot (c = 1, A = [], B = []):
	
	# Error checking
	if (A == [] or (c == 1 and B == [])):
		print ("Error: Can't dot an empty vector")
		return None
	
	vect_prod = 0
	
	#Dot with a vector
	if (B != []):
		if (len(A) == len(B)):
			vect_prod = sum(A[i]*B[i] for i in range (len(A)) #dot the vectors and multiply by scalar
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

def vector_add (A, B):
	if (len(A) != len(B)):
		print ("Error: vectors are not same length")
		return None
	return [A[i] + B[i] for i in range (len(A))]

'''
def Gaussian_Elimination (A, b):	# Solves problems of the form Ax = b. The inputs are A, a matrix, and b, a vector. Solves for, and returns x, a vector
	print ("Performing Gaussian Elimination")
	print ("A = ", A, ", b = ", b)
	
	#ERROR CHECKING:
	#Check that A's row length matches b's vector length, so that multiplication is valid.
	#Check that A is a rectangular array of arrays???
	#eliminate/exclude linearly dependent (duplicate) rows/columns???
	#If underdetermined, return error
	#If overdetermined, get rid of data, then cross-reference with excluded data to check if it agrees
	
	# Form augmented matrix Ag
	Ag = [A[rowIndex][0::]+ [b[rowIndex]] for rowIndex in range(len(A[0]))]
	print ("Ag = ", Ag)
	
	#Perform the actual Gaussian elimination
	#Move down through the rows, and then right through the columns, to get row echelon form
	for columnNum in range(len(Ag[0])):	# go through each column after going through each row
		for rowNum in range(len(Ag)):	# go through each row, from the middle diagonal to bottom.
			
			if (rowNum < columnNum):
				continue	# skip entries above the diagonal (for now) to only get row echelon form, but not reduced row echelon form
			
			row = Ag[rowNum]
			
			if (rowNum > columnNum):# Check if the entry is below the diagonal, and thus should be a 0 (like in the identity matrix)
				# We want to do row operations to set this entry Ag[rowNum][columnNum] to 0.
				# To do this we can find a way to set a value below this entry to the value in this entry 
				#(by multiplying the row below by a constant), and subtract this entire row by the row below multiplied by a constant
				if (Ag[rowNum][columnNum] == 0):	#check if it's already 0. If so, then skip
					continue
				
				print ("Make this entry 0")
				
				# Find a different row such that it's entry in this column is non-zero. Then set the variable "dummyRow" to this. 
				# This row will be multiplied by a constant and added to the current row (rowNum's row) to make it 0
				addedRowNum = 0
				for addedRowNum in range (len(Ag)):
					if (Ag[addedRowNum][columnNum] != 0 and addedRowNum != rowNum):
						break
				print ("addedRowNum = ", addedRowNum)
				if (addedRowNum == len(Ag)):	# If the "for" loop ended without finding a row (besides numRow) that has a non-zero entry in the current column numColumn
					print ("Error: row ", rowNum, " is the only row with a non-zero entry in the ", columnNum"th column. So either can't find this variable, or this entry should be pivot")
				dummyRow = vector_dot(-1*(Ag[rowNum][columnNum]/Ag[addedRowNum][columnNum]), Ag[addedRowNum])
				row = vector_add (row, dummyRow)
				
				#row = vector_add (row, vector_dot(-1, dummyRow))
				
				
				#row = [Ag[rowNum][columnNum] -  for rowEntry in row]
				#print ("R", (rowNum+1), "* = (1/", Ag[rowNum][columnNum], ")*R", (rowNum+1))
				
			elif (rowNum == columnNum): # Check if the entry is on the diagonal, and thus should be a 1 (like in the identity matrix)
				# We want to do row operations to set this entry Ag[rowNum][columnNum] to 1.
				# To do this we can find what the value in this entry is, and divide this entire row by that value
				if (Ag[rowNum][columnNum] == 1):	#check if it's already 1. If so, then skip
					continue
					
				print ("Make this entry 1")
				row = [rowEntry/Ag[rowNum][columnNum] for rowEntry in row]	#vector_dot(1/Ag[rowNum][columnNum], row)
				print ("R", (rowNum+1), "* = (1/", Ag[rowNum][columnNum], ")*R", (rowNum+1))
				
			else:
				print ("Error: got an entry above the diagonal of the matrix???")
			
			Ag[rowNum] = row
			print("Ag is: ", Ag)
	#Now that Ag is in row echelon form, we can get it in reduced row echelon form
	print ("Ag is: ", Ag)
	
	X = [row[-1] for row in Ag]	# x is the rightmost column of Ag
	print ("X = ", X)
	return X
'''
	
# Find determinant of a matrix
#def determinant ():
def main():
	c = 2
	A1 = [1, 2]
	A2 = [3, 4]
	print ("vector_add(", A1, ", ", A2, ") = ", vector_add(A1, A2))
	
	
	print ("vector_dot(", c, ", ", A1, ") = ", vector_dot(c, A1))
	print ("vector_dot(", A1, ", ", A2, ") = ", vector_dot(A1, A2))
	print ("vector_dot(", c, ", ", A1, ", ", A2, ") = ", vector_dot(c, A1, A2))
	
	
	'''
	A = [[1, 2], 
		 [3, 4]]
	b = [10,
		 20]
	print ("Solution is: ", Gaussian_Elimination(A, b))
	'''
	#determinant. Can be used for Cramer's rule
	return

#if this file is the module being run, __name__ == '__main__' Otherwise __name__ is name of module being run
if __name__ == '__main__':
	main()