//
// Created by huiying on 5/3/23.
//

#ifndef MORPHER_TRANSFORMOPS_UTILS_H
#define MORPHER_TRANSFORMOPS_UTILS_H

#include "mlir/Interfaces/CallInterfaces.h"

namespace mlir {
namespace morpher {

template<typename FuncType>
FailureOr<FuncType> outline(ArrayRef<Operation*> ops, StringRef kernel_name,
std::function<void(mlir::OpBuilder &, llvm::ArrayRef<Value>)>
    buildLaunchOp);
}
}

#endif // MORPHER_TRANSFORMOPS_UTILS_H
