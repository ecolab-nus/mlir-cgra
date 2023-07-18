
soda-opt --transform-ops-interp="transform-file=./transform-ops/tile-fuse.mlir" --canonicalize 01-linalg.mlir > 02-tiled.mlir
# soda-opt -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors --one-shot-bufferize='allow-return-allocs=true bufferize-function-boundaries=true' 02-tiled.mlir > 03-bufferized.mlir

# bufferize
soda-opt -linalg-init-tensor-to-alloc-tensor  --transform-ops-interp="transform-file=./transform-ops/to-memref.mlir" --canonicalize 02-tiled.mlir > 03-buf.mlir

soda-opt --transform-ops-interp="transform-file=./transform-ops/promote.mlir" --canonicalize 03-buf.mlir > 04-promoted.mlir

soda-opt --convert-linalg-conv-to-cgra --convert-linalg-generic-to-cgra 04-promoted.mlir > 05-locating.mlir

# cat transform-ops/to-memref.mlir >> 02-tiled.mlir
# mlir-opt --mlir-print-ir-after-all --linalg-init-tensor-to-alloc-tensor --eliminate-alloc-tensors --test-transform-dialect-interpreter --canonicalize 02-tiled.mlir #> 02-promoted.mlir

# mlir-opt --canonicalize -convert-tensor-to-linalg -linalg-init-tensor-to-alloc-tensor -eliminate-alloc-tensors   -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize   -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse 02-tiled.mlir

# 
# cat transform-ops/promote.mlir >> 03-bufferized.mlir
# soda-opt --test-transform-dialect-interpreter -canonicalize 03-bufferized.mlir > 04-promoted.mlir