
#include "Common.h"
#include "CGRAFunc.h"

#include <iostream>

template<>
Simulator<float>::Simulator(int dimX, int dimY) {
  // DMA speed in GB/s @1GHz => bytes/cycle
  this->doubleBufferEnabled = false;
  this->dimX = dimX;
  this->dimY = dimY;
  // Usually, the II increases along with the size of the CGRA
  // as larger CGRA lowers vectorized kernels. And vectorization
  // leads to longer critical path (i.e., recII).
  traditionalII = dimX;
  isBaselineMode = false;
 
  exFuncMap["matmul"] = matmul;
  exFuncMap["batch_matmul"] = batch_matmul;
  exFuncMap["fusion_add_max_add"] = fusion_add_max_add;
}

template<>
Simulator<int>::Simulator(int dimX, int dimY) {
  // DMA speed in GB/s @1GHz => bytes/cycle
  this->doubleBufferEnabled = false;
  this->dimX = dimX;
  this->dimY = dimY;
  // Usually, the II increases along with the size of the CGRA
  // as larger CGRA lowers vectorized kernels. And vectorization
  // leads to longer critical path (i.e., recII).
  traditionalII = dimX;
  isBaselineMode = false;
}

template<typename T>
void Simulator<T>::enableDoubleBuffer() {
  this->doubleBufferEnabled = true;
}

// For baseline, all the kernels are mapped in the
// traditional way.
template<typename T>
void Simulator<T>::runAsBaseline() {
  isBaselineMode = true;
}

template<typename T>
void Simulator<T>::issueRD(DataReq<T>& input) {

  // prepare data for computation
  currentInput[rdIndex] = input;

  // calculate data communication (host->CGRA) cycles
  int64_t rdCycles = 0;
  int64_t totalSize = 0;
  for (auto& dataReq: input.memRefs) {
    int64_t tensorSize = 1;
    for (auto& size: dataReq.sizes) {
      tensorSize *= size;
    }
    totalSize += tensorSize;
  }
  rdCycles = totalSize * 4 / DMASpeed * 2; // assume 400MHz DMA (32b/cycle), the CGRA is 800MHz.
  int64_t rdStartCycle = max(lastRDCompleteCycle[0], lastEXCompleteCycle[0]);
  if (doubleBufferEnabled)
    rdStartCycle = max(lastRDCompleteCycle[rdIndex ^ 1], lastEXCompleteCycle[rdIndex]);
  lastRDCompleteCycle[rdIndex] = rdStartCycle + rdCycles;

  // cout<<"issueRD: lastRDCompleteCycle["<<rdIndex<<"]: "<<lastRDCompleteCycle[rdIndex]<<"; totalSize: "<<totalSize<<endl;

  if (doubleBufferEnabled)
    rdIndex = rdIndex ^ 1;
}

template<typename T>
void Simulator<T>::issueEX(string operationType, int64_t loopBounds) {

  // calculate execution cycles (the computation is done during issueWR())
  currentOperation[exIndex] = operationType;
  int64_t exCycles = 0;

  if (operationType == "matmul" || operationType == "batch_matmul") {
    if (isBaselineMode) {
      exCycles = loopBounds * traditionalII;
    } else {
      exCycles = loopBounds + this->dimX - 1;
    }
  } else {
    if (isBaselineMode || operationType.substr(0, 7) == "generic") {
      // assume unrolling factor is the same as the dimX
      exCycles = loopBounds * traditionalII;
    } else {
      // for generic op
      // in this prototype, we only target 3-opt chain
      exCycles = loopBounds / this->dimX + 2 * (this->dimX -1);
    }
  }

  // int64_t exCycles = exCycleMap[operationType];
  int64_t exStartCycle = max(lastRDCompleteCycle[0], lastEXCompleteCycle[0]);
  if (doubleBufferEnabled)
    exStartCycle = max(lastRDCompleteCycle[exIndex], lastEXCompleteCycle[exIndex ^ 1]);
  lastEXCompleteCycle[exIndex] = exStartCycle + exCycles;

  // cout<<"issueEX: lastEXCompleteCycle["<<exIndex<<"]: "<<lastEXCompleteCycle[exIndex]<<endl;

  if (doubleBufferEnabled)
    exIndex = exIndex ^ 1;


}

template<typename T>
void Simulator<T>::issueWR(DataReq<T>& output, bool computeHere) {

  // prepare input and output for computation
  DataReq<T>& input = currentInput[wrIndex];
  string operation = currentOperation[wrIndex];

  // perform computation
  if (computeHere) {
    pfunc<T> f = exFuncMap[operation];
    (*f)(input, output, *this);
  }

  // calculate data communication (CGRA->host) cycles
  int64_t wrCycles = 0;
  int64_t totalSize = 0;
  for (auto& dataReq: output.memRefs) {
    int64_t tensorSize = 1;
    for (auto& size: dataReq.sizes) {
      tensorSize *= size;
    }
    totalSize += tensorSize;
  }
  wrCycles = totalSize * 4 / DMASpeed * 2;

  int64_t wrStartCycle = lastEXCompleteCycle[wrIndex];
  if (doubleBufferEnabled)
    wrStartCycle = max(lastWRCompleteCycle[wrIndex ^ 1], lastEXCompleteCycle[wrIndex]);
  lastWRCompleteCycle[wrIndex] = wrStartCycle + wrCycles;

  // cout<<"issueWR: lastWRCompleteCycle["<<wrIndex<<"]: "<<lastWRCompleteCycle[wrIndex]<<"; totalSize: "<<totalSize<<endl;

  if (doubleBufferEnabled)
    wrIndex = wrIndex ^ 1;

}

template<typename T>
int64_t Simulator<T>::getTotalCycles() {
  return max(lastWRCompleteCycle[0], lastWRCompleteCycle[1]);
}

template class Simulator<float>;
template class Simulator<int>;
