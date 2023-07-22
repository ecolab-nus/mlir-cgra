cmake_minimum_required(VERSION 3.13.4)
project(soda-opt LANGUAGES CXX C)

set(BUILD_DIR "/home/huiying/llvm-project-16/debug")
set(LLVM_EXTERN_LIT ${BUILD_DIR}/bin/llvm-lit)
set(MLIR_DIR ${BUILD_DIR}/lib/cmake/mlir)

set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")

find_package(MLIR REQUIRED CONFIG)
#
#include_directories(${CMAKE_CURRENT_BINARY_DIR}/${EASYLOGGINGCPP_NAME}/src/${EASYLOGGINGCPP_NAME})

message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/bin)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/lib)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})
set(SODA_LIB_DIR ${CMAKE_BINARY_DIR}/lib)

list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(cmake/easyloggingpp.cmake)
include(TableGen)
include(AddLLVM)
include(AddMLIR)
include(HandleLLVMOptions)
include(MLIRDetectPythonEnv)

if(MLIR_ENABLE_BINDINGS_PYTHON)
  include(MLIRDetectPythonEnv)
  mlir_configure_python_dev_packages()
endif()

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_BINARY_DIR}/include)

link_directories(${LLVM_BUILD_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

if(MLIR_ENABLE_BINDINGS_PYTHON)
  message(STATUS "Enabling SODA-OPT Python API")
  add_subdirectory(python)
else()
  message(STATUS "SODA-OPT Python bindings are disabled.")
endif()

add_subdirectory(include/soda)
add_subdirectory(include/morpher)
add_subdirectory(lib)
add_subdirectory(test)
add_subdirectory(tools)

add_subdirectory(llvm_plugins/lib)

