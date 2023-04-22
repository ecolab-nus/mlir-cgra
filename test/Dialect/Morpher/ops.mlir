// RUN: soda-opt -allow-unregistered-dialect %s | FileCheck %s

func.func() {
    morpher.map_hint
}
