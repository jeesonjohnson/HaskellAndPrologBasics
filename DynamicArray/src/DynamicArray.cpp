/*
 * DynamicArray.cpp
 *
 *  Author: Jeeson Johnson (jj00435) (6477799)
 */
#include "DynamicArray.h"
#include <iostream>
#include <iomanip>
using namespace std;

template<class T>
DynamicArray<T>::DynamicArray(int defaultArraySize) {
	if (defaultArraySize <= 0) {
		this->sizeOfArray = 10;
	} else {
		this->sizeOfArray = defaultArraySize;
	}
	this->numberOfElements = 0;
	this->arrayData = new T[this->sizeOfArray];

}

template<class T>
DynamicArray<T>::DynamicArray(const DynamicArray &currentObject) {
	arrayData = currentObject.arrayData;
	numberOfElements = currentObject.numberOfElements;
	sizeOfArray = currentObject.sizeOfArray;
}

template<class T>
DynamicArray<T>::~DynamicArray() {
	delete this->arrayData;
	this->arrayData = NULL;
}

template<class T>
void DynamicArray<T>::resizeArray() {
	T *tempValueStore = new T[sizeOfArray * 2];
	for (int x = 0; x < sizeOfArray; x++) {
		tempValueStore[x] = arrayData[x];
	}
	//Below methods are done to ensure that no memory leak
	//or dangling pointers are created.
	delete arrayData;
	arrayData = tempValueStore;
	tempValueStore = NULL;
	sizeOfArray *= 2;

}

template<class T>
void DynamicArray<T>::addStart(T item) {
	if (typeid(T).name() == typeid(item).name()) {
		if (numberOfElements + 1 == sizeOfArray)
			resizeArray();
		numberOfElements++;
		//Done in this order to ensure that no array copy needs to be made
		for (int x = numberOfElements - 1; x >= 0; x--) {
			arrayData[x + 1] = arrayData[x];
		}
		arrayData[0] = item;
	}else{
		throw "TypeException: You have to add an element of the array's DataType to the array";
	}

}

template<class T>
int DynamicArray<T>::size() {
	return numberOfElements;
}

template<class T>
T& DynamicArray<T>::operator[](int index) {
	if (index <= numberOfElements) {
		return this->arrayData[index];
	}
}

template<class T>
void DynamicArray<T>::print() {
	cout << "[";
	//Done with 2 if statements to increase efficiency at runtime
	if (typeid(T).name() == typeid(double).name()) {
		for (int x = 0; x < numberOfElements; x++) {
			//If statement for pure aesthetic reasons for print statement
			if (x == numberOfElements - 1) {
				cout << setprecision(0) << scientific << arrayData[x] << "]"
						<< endl;
			} else {
				cout << setprecision(0) << scientific << arrayData[x] << ",";
			}
		}
	} else {
		for (int x = 0; x < numberOfElements; x++) {
			//If statement for pure aesthetic reasons for print statement
			if (x == numberOfElements - 1) {
				cout << arrayData[x] << "]" << endl;
			} else {
				cout << arrayData[x] << ",";
			}
		}

	}

}

