#!/bin/bash
echo "compiling python"
#python -O -m py_compile fileA.py fileB.py fileC.py
python -O -m py_compile Babylonian.py Halley.py SquareRoot.py

echo "Timing Babylonian:"
time python Babylonian.pyo

echo "Timing Halley:"
time python Halley.pyo

echo "Timing SquareRoot:"
time python SquareRoot.pyo