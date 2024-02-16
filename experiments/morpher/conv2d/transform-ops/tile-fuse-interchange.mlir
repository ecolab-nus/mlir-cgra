
// 0: n, 1:h, 2: w, 3: co, 4: kh, 5: kw, 6: ci

transform.with_pdl_patterns {
  ^bb0(%arg0: !pdl.operation):
    sequence %arg0 failures(propagate) {
      ^bb0(%arg1: !pdl.operation):
        // tile and fuse conv and addf
        %3 = transform.structured.match ops{["linalg.conv_2d_nhwc_fhwc"]} in %arg1
        %4 = transform.structured.generalize %3
        %5 = transform.structured.interchange %4 { iterator_interchange = [0, 2, 5, 1, 3, 4, 6] }
        %1, %2 = transform.structured.tile_to_foreach_thread_op %5 num_threads [0, 4, 0, 0, 0, 0, 0] (mapped to dims [0])
        %red:2 = transform.structured.tile %2 [0, 0, 0, 0, 0, 4, 0]
        // %5 = transform.structured.fuse %4 {tile_sizes = [0, 47, 0, 0, 0, 0, 0], tile_interchange = [0, 2, 1, 3, 4, 5, 6]}
    }
}