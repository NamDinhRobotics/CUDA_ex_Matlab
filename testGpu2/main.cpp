//
// File: main.cu
//
// GPU Coder version                    : 2.0
// CUDA/C/C++ source code generated on  : 15-Dec-2020 11:16:10
//

//***********************************************************************
// This automatically generated example CUDA main file shows how to call
// entry-point functions that MATLAB Coder generated. You must customize
// this file for your application. Do not modify this file directly.
// Instead, make a copy of this file, modify it, and integrate it into
// your development environment.
//
// This file initializes entry-point function arguments to a default
// size and value before calling the entry-point functions. It does
// not store or use any values returned from the entry-point functions.
// If necessary, it does pre-allocate memory for returned values.
// You can use this file as a starting point for a main function that
// you can deploy in your application.
//
// After you copy the file, and before you deploy it, you must make the
// following changes:
// * For variable-size function arguments, change the example sizes to
// the sizes that your application requires.
// * Change the example values of function arguments to the values that
// your application requires.
// * If the entry-point functions return values, store these values or
// otherwise use them as required by your application.
//
//***********************************************************************

// Include Files
#include "main.h"
#include "mulMatrix.h"
#include "mulMatrix_terminate.h"
#include <iostream>
// Function Declarations
static void argInit_1000x1000_real_T(double result[1000000]);
static void argInit_1000x1000_real_T1(double result[1000000]);

static double argInit_real_T();
static void main_mulMatrix();

// Function Definitions
//
// Arguments    : double result[1000000]
// Return Type  : void
//
static void argInit_1000x1000_real_T(double result[1000000])
{
  // Loop over the array to initialize each element.
  for (int idx0 = 0; idx0 < 1000; idx0++) {
    for (int idx1 = 0; idx1 < 1000; idx1++) {
      // Set the value of the array element.
      // Change this value to the value that the application requires.
      result[idx0 + 1000 * idx1] = 0.5+ 0.1* idx0 + 102.2 * idx1;
    }
  }
}

static void argInit_1000x1000_real_T1(double result[1000000])
{
    // Loop over the array to initialize each element.
    for (int idx0 = 0; idx0 < 1000; idx0++) {
        for (int idx1 = 0; idx1 < 1000; idx1++) {
            // Set the value of the array element.
            // Change this value to the value that the application requires.
            result[idx0 + 1000 * idx1] = 0.1+ 0.2* idx0 + 100.2 * idx1;
        }
    }
}

//
// Arguments    : void
// Return Type  : double
//
static double argInit_real_T()
{
  return 1.2;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_mulMatrix()
{
  static double b[1000000];
  static double c[1000000];
  static double mul[1000000];

  // Initialize function 'mulMatrix' input arguments.
  // Initialize function input argument 'A'.
  // Initialize function input argument 'B'.
  // Call the entry-point 'mulMatrix'.
  argInit_1000x1000_real_T(b);
  argInit_1000x1000_real_T1(c);
  mulMatrix(b, c, mul);

    printf("b at 1000 is %lf \n", b[1000]);
    printf("c at 1000 is %lf \n", c[1000]);

    printf("mul at 1000 is %lf \n", mul[1000]);
}

//
// Arguments    : int argc
//                const char * const argv[]
// Return Type  : int
//
int main(int, const char * const [])
{
  // The initialize function is being called automatically from your entry-point function. So, a call to initialize is not included here. 
  // Invoke the entry-point functions.
  // You can call entry-point functions multiple times.
    for (int i = 0; i < 100; ++i) {
        main_mulMatrix();

    }

  // Terminate the application.
  // You do not need to do this more than one time.
  mulMatrix_terminate();
  return 0;
}

//
// File trailer for main.cu
//
// [EOF]
//
