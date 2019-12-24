//============================================================================
// Name        : DynamicArray.cpp
// Author      : Author: Jeeson Johnson (jj00435) (6477799)
// Version     : 1.0
// Copyright   : Jeeson Johnson
// Description : Dynamic Array data type implementation
//============================================================================

#include <iostream>
#include <random>
#include "DynamicArray.cpp"

using namespace std;

int main() {
	//Q1.3.a
	DynamicArray<int> integerArray(5);
	for (int x = 0; x < 5; x++) {
		integerArray.addStart((std::rand() % (100 + 1)));
	}
	cout << "This is what the integer array looks like currently:" << endl;
	integerArray.print();

	//Q1.3.b
	cout << "Enter 5 numbers one after the other make sure its an integer"
			<< endl;
	int counter = 0;
	while (counter < 5) {
		int tempNumber;
		try {
			cin >> tempNumber;
			integerArray.addStart(tempNumber);
			cout << "Added " << tempNumber << " to integerArray" << endl;
			counter++;
		} catch (...) {
			cout << "Make sure you enter an integer!";
		};
	}
	cout << "This is what the integer array looks like currently:" << endl;
	integerArray.print();
	//////////////////////////////////////////////////////////////////////

	//Q1.3.c
	DynamicArray<double> doubleArray(5);
	for (int x = 0; x < 5; x++) {
		doubleArray.addStart((double) rand() / RAND_MAX);
	}
	cout << "This is what the integer array looks like currently:" << endl;
	doubleArray.print();

	//Q1.3.d
	cout << "Enter 5 numbers one after the other make sure its an integer"
			<< endl;
	counter = 0;
	while (counter < 5) {
		double tempDouble;
		try {
			cin >> tempDouble;
			doubleArray.addStart(tempDouble);
			cout << "Added " << tempDouble << " to integerArray" << endl;
			counter++;
		} catch (...) {
			cout << "Make sure you enter an integer!";
		};
	}
	cout << "This is what the integer array looks like currently:" << endl;
	//////////////////////////////////////////////////////////////////////
	//Q1.3.e
	cout << endl
			<< "After running the program the final values of the arrays are "
			<< endl;
	cout << "For the integer array:";
	integerArray.print();
	cout << "For the double array:";
	doubleArray.print();

	return 0;
}

