//
// File: mulMatrix_terminate.cu
//
// GPU Coder version                    : 2.0
// CUDA/C/C++ source code generated on  : 15-Dec-2020 11:16:10
//

// Include Files
#include "mulMatrix_terminate.h"
#include "mulMatrix_data.h"
#include "MWCUSOLVERUtils.hpp"

// Function Definitions
//
// Arguments    : void
// Return Type  : void
//
void mulMatrix_terminate()
{
  cusolverEnsureDestruction();
  isInitialized_mulMatrix = false;
}

//
// File trailer for mulMatrix_terminate.cu
//
// [EOF]
//
