#ifndef MORPHER_OP_LAUNCHINTERFACE_TD
#define MORPHER_OP_LAUNCHINTERFACE_TD

include "mlir/IR/OpBase.td"

def CGRALaunchInterface : OpInterface<"CGRALaunchInterface"> {
  let description = [{
     A launch-like interface for CGRA devices.
  }];
  let cppNamespace = "::mlir::morpher";

  let methods = [
    InterfaceMethod<[{
        Generate parameters to xml file.
      }],
      "::mlir::LogicalResult", "exportParamToXMLFile",
      (ins "::llvm::StringRef":$file_name)
    >,
  ];
}

#endif  // MORPHER_OP_LAUNCHINTERFACE_TD