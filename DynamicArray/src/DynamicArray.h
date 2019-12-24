/*
 * DynamicArray.h
 *
 *      Author: Jeeson Johnson (jj00435) (6477799)
 */

#ifndef DYNAMICARRAY_H_
#define DYNAMICARRAY_H_
#include <iostream>


template <class T>
class DynamicArray {

private:
	int sizeOfArray;
	int numberOfElements;
	T *arrayData;
	void resizeArray();//Allows the resizing of the array if appropriate

public:
	DynamicArray(int defaultArraySize);
	DynamicArray(const DynamicArray &currentObject);
	virtual ~DynamicArray();
	//The number of elements in the given array
	int size();

	//Returns a given element from array
	T &operator [](int index);

	//Adds an element to the start of an array
	void addStart(T Item);

	//Prints all the contents of the array
	void print();

};

#endif /* DYNAMICARRAY_H_ */
