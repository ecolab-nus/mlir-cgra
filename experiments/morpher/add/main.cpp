
#include "Common.h"

#include <iostream>

template <typename T, size_t N> struct MemRefDescriptor {
  T *allocated;
  T *aligned;
  intptr_t offset;
  intptr_t sizes[N];
  intptr_t strides[N];
};

extern "C" {
  // void *main_graph(MemRefDescriptor<float, 2> input0, MemRefDescriptor<float, 2> input1, MemRefDescriptor<float, 2> input2, MemRefDescriptor<float, 2> input3, MemRefDescriptor<float, 2> output);
  void *main_graph(int* a_allocated, int* a_aligned, int64_t a_offset, int64_t a_size0, int64_t a_stride0,
                   int* b_allocated, int* b_aligned, int64_t b_offset, int64_t b_size0, int64_t b_stride0,
                   int* c_allocated, int* c_aligned, int64_t c_offset, int64_t c_size0, int64_t c_stride0);
}


Simulator<int>* cgra;

int main(int argc, char *argv[]) {
  int *a = new int[20];
  int *b = new int[20];
  int *c = new int[20];

  for (int i=0; i<20; ++i) {
    a[i] = i;
    b[i] = i;
  }

  // we can use this to describe the memref later
//  MemRefDescriptor<int, 2> memref = {
//    a,    // allocated
//    a,    // aligned
//    0,    // offset
//    {20}, // sizes[N]
//    {1},  // strides[N]
//  };
//
  cgra = new Simulator<int>(4, 4); // true or false indicates whether double buffer is enabled
  cgra->enableDoubleBuffer();
  cgra->runAsBaseline();
  
  // register the operations into runtime, these operations are offloaded and runing on CGRA.
  // However, they are mapped in the conventional way (i.e., through mlir->llvm->mapping), in
  // other words, there are no corresponding user pre-defined mapping. Meanwhile, they usually
  // have longer execution cycles than the pre-defined ones. Note that for baseline (i.e., 
  // conventional CGRA), all the operations are conventionally mapped, so we need to register
  // all of them one by one. 
  // cgra->registerTraditionalMapping("matmul", 40);
  // cgra->registerTraditionalMapping("generic_0", 40);

  // main_graph(memref0, memref1, memref2, memref3, memref4);
  main_graph(
      a, a, 0, 20, 1,
      b, b, 0, 20, 1,
      c, c, 0, 20, 1 );

  std::cout<<"Check result: "<<std::endl;
  for (int i=0; i<20; ++i) {
    std::cout<<c[i]<<"\t";
  }
  std::cout<<std::endl;
  std::cout<<"Total cycles: "<<cgra->getTotalCycles()<<std::endl;
  return 0;
}
