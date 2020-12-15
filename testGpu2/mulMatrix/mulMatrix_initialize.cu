//
// File: mulMatrix_initialize.cu
//
// GPU Coder version                    : 2.0
// CUDA/C/C++ source code generated on  : 15-Dec-2020 11:16:10
//

// Include Files
#include "mulMatrix_initialize.h"
#include "mulMatrix_data.h"
#include "MWCUSOLVERUtils.hpp"

// Function Definitions
//
// Arguments    : void
// Return Type  : void
//
void mulMatrix_initialize()
{
  cusolverEnsureInitialization();
  isInitialized_mulMatrix = true;
}

//
// File trailer for mulMatrix_initialize.cu
//
// [EOF]
//
