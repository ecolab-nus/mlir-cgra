#include "soda/Dialect/Relay/RelayDialect.hpp"

#include "soda/Dialect/Relay/RelayOps.hpp"
#include "soda/Dialect/Relay/RelayOpsDialect.cpp.inc"

namespace mlir {
namespace relay {

void RelayDialect::initialize() {
    addOperations<
#define GET_OP_LIST
#include "soda/Dialect/Relay/RelayOps.cpp.inc"
        >();
}

}  // namespace relay
}  // namespace mlir