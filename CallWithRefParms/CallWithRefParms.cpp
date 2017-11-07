// CallWithRefParms.cpp : Defines the entry point for the console application.
// Pg 42 of Modern X86 Assembly Language Programming, by Daniel Kusswurm
// Refer to comments in MemoryAddressing.asm file which this calls
//

#include "stdafx.h"

extern "C" int NumFibVals_;
extern "C" int MemoryAddressing_(int i, int* v1, int* v2, int* v3, int* v4);

int main()
{
	for (int i = -1; i < NumFibVals_ + 1; i++) {
		int v1 = -1, v2 = -1, v3 = -1, v4 = -1;
		int rc = MemoryAddressing_(i, &v1, &v2, &v3, &v4);
		
		printf("i: %3d | rc: %3d | ", i, rc);
		printf("v1: %5d  | v2: %5d  | v3: %5d  | v4: %5d\n", v1, v2, v3, v4);
	}

    return 0;
}

