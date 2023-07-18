transform.with_pdl_patterns {
  ^bb0(%arg0: !pdl.operation):
    sequence %arg0 failures(propagate) {
      ^bb0(%arg1: !pdl.operation):
        // tile and fuse conv and addf
        %3 = transform.structured.match ops{["linalg.conv_2d_nhwc_fhwc"]} in %arg1
        %1, %loops:2 = transform.structured.fuse %3 {tile_sizes = [0, 2, 2, 0, 0, 0, 0]}
    }
}