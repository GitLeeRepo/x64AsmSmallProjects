// AsmArraySquares.cpp :
// Modified version of: Prog on Pg 59 of Modern X86 Assembly Language Programming, by Daniel Kusswurm
//                      Added srcMultFactor parameter.Also changed parameter order from the book
//                      and added more descriptive variables.
//          
// Refer to AsmCalcArraySquares.asm for more details

#include "stdafx.h"

extern "C" int CalcArraySquares_(const int* srcArray, int* destArray, int numElements, int srcMultFactor);

int CalcArraySquaresCpp(const int* srcArray, int* destArray,  int numElements) {
    int sum = 0;

    for (int i = 0; i < numElements; i++) {
        destArray[i] = srcArray[i] * srcArray[i];
        sum += destArray[i];
    }

    return sum;
}

int main()
{
    int srcArray[] = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 };
    const int numElements = sizeof(srcArray) / sizeof(int);
    int destArrayCpp[numElements];
    int destArrayAsm[numElements];
    const int srcMultFactor = 2;

    int sumCpp = CalcArraySquaresCpp(srcArray, destArrayCpp, numElements);
    int sumAsm = CalcArraySquares_(srcArray, destArrayAsm, numElements, srcMultFactor);

    for (int i = 0; i < numElements; i++) {
        printf("i: %2d | srcA: %4d | destCppA: %4d | srcMultFactor %4d | destAsmA: %d\n", i, srcArray[i], destArrayCpp[i], srcMultFactor, destArrayAsm[i]);
    }
    printf("\n");

    printf("sumDestCpp: %d\n", sumCpp);
    printf("sumDestAsm: %d\n", sumAsm);

    getchar();

    return 0;
}

