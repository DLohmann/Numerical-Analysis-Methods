#ifndef mathlib_h
#include <vector>

//Tensor (int M, int N);
//Tensor dot(Tensor, Tensor);


class matrix : public std::vector< std::vector<double> > {
	// matrix inherits from a vector of vectors of doubles

	public:

		// ********** CONSTRUCTORS **********
		// input: Number of rows and columns.
		// ouput: a matrix of zeros, that are doubles
		matrix (int, int);

		int numRows ();
		int numCols ();

		// find the determinant
		//double det();
		// idea: override the assignment operator for the matrix, to keep a boolean to check if there were any changes since the last determinant was calculated
		// if the matrix was not changed since the last det() function was called, then there is no need to re-calculate the determinant; just use the old calculated value
		// but we wil need a boolean to check if it has been changed

		

		// take the transpose
		//matrix trans();

		// check if the columns are independent

		
	protected:
		// keep track of whether matrix was changed since last determinant was calculated
		// bool wasChangedSinceLastDet = true;
};

// 
void operator*= (matrix&, matrix&);

// creates a new matrix, and calls operator*=
matrix operator* (matrix&, matrix&);

matrix operator
// LU factorization

#endif
