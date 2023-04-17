/*
 * ======================================================================
 * CutomizedRuntime.cpp
 * ======================================================================
 * This file includes the interfaces to call OpenCGRA (pymtl test) or C
 * code running on native machine for simulation the CGRA offloading.
 *
 * Author : Cheng Tan
 *   Date : Nov 6, 2022
 */

#include "Common.h"

#include <algorithm>
#include <iostream>

using namespace std;

extern Simulator<int> *cgra;

extern "C" {
void *generic_0(int *a_allocated, int *a_aligned, int64_t a_offset,
                int64_t a_size0, int64_t a_stride0, int *b_allocated,
                int *b_aligned, int64_t b_offset, int64_t b_size0,
                int64_t b_stride0, int *c_allocated, int *c_aligned,
                int64_t c_offset, int64_t c_size0, int64_t c_stride0);
}

// generic cgra_call. Some operations are also offloaded to CGRA without
// user pre-defined mapping, which requires lowering to LLVMIR.
extern "C" void
cgra_generic_0(int *a_allocated, int *a_aligned, int64_t a_offset,
               int64_t a_size0, int64_t a_stride0, int *b_allocated,
               int *b_aligned, int64_t b_offset, int64_t b_size0,
               int64_t b_stride0, int *c_allocated, int *c_aligned,
               int64_t c_offset, int64_t c_size0, int64_t c_stride0) {

  // prepare inputs
  vector<int64_t> a_sizes = {a_size0};
  vector<int64_t> a_strides = {a_stride0};
  MemRef<int> memRef0(a_allocated, a_aligned, a_offset, a_sizes, a_strides, 1);

  vector<int64_t> b_sizes = {b_size0};
  vector<int64_t> b_strides = {b_stride0};
  MemRef<int> memRef1(b_allocated, b_aligned, b_offset, b_sizes, b_strides, 1);
  //
  //  vector<int64_t> c_sizes = {c_size0, c_size1};
  //  vector<int64_t> c_strides = {c_stride0, c_stride1};
  //  MemRef memRef2(c_allocated, c_aligned, c_offset, c_sizes, c_strides, 2);

  DataReq<int> input;
  input.assembleReq(memRef0);
  input.assembleReq(memRef1);
  //  input.assembleReq(memRef2);

  // prepare outputs
  vector<int64_t> c_sizes = {c_size0};
  vector<int64_t> c_strides = {c_stride0};
  MemRef<int> memRef3(c_allocated, c_aligned, c_offset, c_sizes, c_strides, 1);

  DataReq<int> output;
  output.assembleReq(memRef3);

  // issue READ/EXECUTE/WRITE requests for simulation
  cgra->issueRD(input);
  cgra->issueEX("generic_0", a_size0);
  cgra->issueWR(output,
                false); // false indicates there is no related predefined
                        // operation, so need to run the lowered llvm ir code

  generic_0(a_allocated, a_aligned, a_offset, a_size0, a_stride0, b_allocated,
            b_aligned, b_offset, b_size0, b_stride0, c_allocated, c_aligned,
            c_offset, c_size0, c_stride0);
}
