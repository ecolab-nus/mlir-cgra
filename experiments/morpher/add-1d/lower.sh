#!/usr/bin/env sh

mlir-opt --test-transform-dialect-interpreter --canonicalize --split-input-file linalg-input.mlir > bufferized.mlir
