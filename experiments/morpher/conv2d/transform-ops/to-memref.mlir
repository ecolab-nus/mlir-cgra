transform.with_pdl_patterns {
^bb0(%arg0: !pdl.operation):
  sequence %arg0 failures(propagate) {
    ^bb0(%arg1: !pdl.operation):
     transform.bufferization.one_shot_bufferize %arg1  {allow_return_allocs=true, bufferize_function_boundaries=true}
  }
}