
transform.with_pdl_patterns {
  ^bb0(%arg0: !pdl.operation):
    sequence %arg0 failures(propagate) {
      ^bb0(%arg1: !pdl.operation):
        %linalg = transform.structured.match ops{["linalg.conv_2d_nhwc_fhwc"]} in %arg1
        // transform.morpher.print %linalg { comment = "conv operation" }
        %2 = transform.structured.promote %linalg { operands_to_promote = [0, 1, 2], use_full_tiles_by_default }
    }
}
