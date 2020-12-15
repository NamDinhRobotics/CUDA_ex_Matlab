//
// File: mulMatrix.cu
//
// GPU Coder version                    : 2.0
// CUDA/C/C++ source code generated on  : 15-Dec-2020 11:16:10
//

// Include Files
#include "mulMatrix.h"
#include "mulMatrix_data.h"
#include "mulMatrix_initialize.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUSOLVERUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "math_constants.h"

// Function Declarations
static __global__ void mulMatrix_kernel1(const double A[1000000], const double
  B[1000000], double b_A[1000000], double mul[1000000]);
static __global__ void mulMatrix_kernel2(double mul[1000000]);

// Function Definitions
//
// Arguments    : dim3 blockArg
//                dim3 gridArg
//                const double A[1000000]
//                const double B[1000000]
//                double b_A[1000000]
//                double mul[1000000]
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void mulMatrix_kernel1(const double
  A[1000000], const double B[1000000], double b_A[1000000], double mul[1000000])
{
  int i;
  i = static_cast<int>(mwGetGlobalThreadIndex());
  if (i < 1000000) {
    // UNTITLED Summary of this function goes here
    //    Detailed explanation goes here
    mul[i] = B[i];
    b_A[i] = A[i];
  }
}

//
// Arguments    : dim3 blockArg
//                dim3 gridArg
//                double mul[1000000]
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void mulMatrix_kernel2(double mul
  [1000000])
{
  int i;
  i = static_cast<int>(mwGetGlobalThreadIndex());
  if (i < 1000000) {
    mul[i] = CUDART_NAN;
  }
}

//
// Add kernelfun pragma to trigger kernel creation
// Arguments    : const double A[1000000]
//                const double B[1000000]
//                double mul[1000000]
// Return Type  : void
//
void mulMatrix(const double A[1000000], const double B[1000000], double mul
               [1000000])
{
  double (*b_gpu_A)[1000000];
  double (*gpu_A)[1000000];
  double (*gpu_B)[1000000];
  double (*gpu_mul)[1000000];
  int (*gpu_IPIV)[1000];
  int info_t;
  int *gpu_info_t;
  if (!isInitialized_mulMatrix) {
    mulMatrix_initialize();
  }

  cudaMalloc(&gpu_mul, 8000000UL);
  cudaMalloc(&gpu_info_t, 4UL);
  cudaMalloc(&gpu_IPIV, 4000UL);
  cudaMalloc(&gpu_A, 8000000UL);
  cudaMalloc(&gpu_B, 8000000UL);
  cudaMalloc(&b_gpu_A, 8000000UL);

  // UNTITLED Summary of this function goes here
  //    Detailed explanation goes here
  cudaMemcpy(b_gpu_A, (void *)&A[0], 8000000UL, cudaMemcpyHostToDevice);
  cudaMemcpy(gpu_B, (void *)&B[0], 8000000UL, cudaMemcpyHostToDevice);
  mulMatrix_kernel1<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*b_gpu_A,
    *gpu_B, *gpu_A, *gpu_mul);
  cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), 1000, 1000, (double *)
    &(*gpu_A)[0], 1000, getCuSolverWorkspaceReq());
  setCuSolverWorkspaceTypeSize(8);
  cusolverInitWorkspace();
  cusolverDnDgetrf(getCuSolverGlobalHandle(), 1000, 1000, (double *)&(*gpu_A)[0],
                   1000, (double *)getCuSolverWorkspaceBuff(), &(*gpu_IPIV)[0],
                   gpu_info_t);
  cudaMemcpy(&info_t, gpu_info_t, 4UL, cudaMemcpyDeviceToHost);
  if (info_t < 0) {
    mulMatrix_kernel2<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>(*gpu_mul);
  } else {
    cusolverDnDgetrs(getCuSolverGlobalHandle(), CUBLAS_OP_N, 1000, 1000, (double
      *)&(*gpu_A)[0], 1000, &(*gpu_IPIV)[0], (double *)&(*gpu_mul)[0], 1000,
                     gpu_info_t);
  }

  cusolverDestroyWorkspace();
  cudaMemcpy(&mul[0], gpu_mul, 8000000UL, cudaMemcpyDeviceToHost);
  cudaFree(*b_gpu_A);
  cudaFree(*gpu_B);
  cudaFree(*gpu_A);
  cudaFree(*gpu_IPIV);
  cudaFree(gpu_info_t);
  cudaFree(*gpu_mul);
}

//
// File trailer for mulMatrix.cu
//
// [EOF]
//
