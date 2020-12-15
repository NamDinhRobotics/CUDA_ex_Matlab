// Copyright 2020 The MathWorks, Inc.

#include "MWCUSOLVERUtils.hpp"
#include "cuda_runtime.h"

static cusolverDnHandle_t cusolverGlobalHandle = NULL;

static void* cusolverWorkspaceBuff = NULL;

static int cusolverWorkspaceSize = 0;

static int cusolverWorkspaceReq = 0;

static int cusolverWorkspaceTypeSize = 0;

void cusolverEnsureInitialization() {
    if (cusolverGlobalHandle == NULL) {
        cusolverDnCreate(&cusolverGlobalHandle);
    }
}

void cusolverEnsureDestruction() {
    if (cusolverGlobalHandle != NULL) {
        cusolverDnDestroy(cusolverGlobalHandle);
        cusolverGlobalHandle = NULL;
    }
}

void cusolverDestroyWorkspace() {
    if (cusolverWorkspaceBuff != NULL) {
        cudaFree(cusolverWorkspaceBuff);
        cusolverWorkspaceSize = 0;
        cusolverWorkspaceBuff = NULL;
    }
}

void cusolverInitWorkspace() {
    if (cusolverWorkspaceSize < cusolverWorkspaceReq) {
        cusolverDestroyWorkspace();
        cudaMalloc(&cusolverWorkspaceBuff, cusolverWorkspaceReq *
                   cusolverWorkspaceTypeSize);
        cusolverWorkspaceSize = cusolverWorkspaceReq;
    }
}

cusolverDnHandle_t getCuSolverGlobalHandle() {
    return cusolverGlobalHandle;
}

int* getCuSolverWorkspaceReq() {
    return &cusolverWorkspaceReq;
}

void* getCuSolverWorkspaceBuff() {
    return cusolverWorkspaceBuff;
}

int getCuSolverWorkspaceSize() {
    return cusolverWorkspaceSize;
}

int getCuSolverWorkspaceTypeSize() {
    return cusolverWorkspaceTypeSize;
}

void setCuSolverWorkspaceTypeSize(int input) {
    cusolverWorkspaceTypeSize = input;
}
