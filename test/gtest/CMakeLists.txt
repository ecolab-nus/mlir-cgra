#find_package(GTest)
#if (NOT GTEST_FOUND)
#  message(STATUS "GTest not found, downloading GTest.")
#  # Download and unpack googletest at configure time
#  message("${CMAKE_LOCAL}/gtest_cmake.in -> ${CMAKE_BINARY_DIR}/googletest-download/CMakeLists.txt")
#  configure_file("${CMAKE_LOCAL}/gtest_cmake.in" "${CMAKE_BINARY_DIR}/googletest-download/CMakeLists.txt")
#  execute_process(COMMAND "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
#    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/googletest-download" )
#  execute_process(COMMAND "${CMAKE_COMMAND}" --build .
#    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/googletest-download" )
#  # Prevent GoogleTest from overriding our compiler/linker options
#  # when building with Visual Studio
#  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
#
#  # Add googletest directly to our build. This adds
#  # the following targets: gtest, gtest_main, gmock
#  # and gmock_main
#  add_subdirectory("${CMAKE_BINARY_DIR}/googletest-src"
#    "${CMAKE_BINARY_DIR}/googletest-build")
#
#  target_compile_definitions(gtest PRIVATE ${ENABLE_GNU_EXTENSION_FLAGS})
#  target_compile_definitions(gmock PRIVATE ${ENABLE_GNU_EXTENSION_FLAGS})
#  target_compile_definitions(gtest_main PRIVATE ${ENABLE_GNU_EXTENSION_FLAGS})
#  target_compile_definitions(gmock_main PRIVATE ${ENABLE_GNU_EXTENSION_FLAGS})
#  target_include_directories(dmlc_unit_tests PRIVATE
#    "${gtest_SOURCE_DIR}/include" "${gmock_SOURCE_DIR}/include")
#  target_link_libraries(dmlc_unit_tests
#    gtest dmlc Threads::Threads)
#else()
#  target_include_directories(dmlc_unit_tests PRIVATE ${GTEST_INCLUDE_DIRS})
#  target_link_libraries(dmlc_unit_tests
#    ${GTEST_LIBRARIES} dmlc Threads::Threads)
#endif()
#
#add_executable(TestMorpherUtils TestMorpherUtils.cpp)
#target_link_directories(TestMorpherUtils
#        gtest
#        pthread
#        )
#
#gtest_discover_tests(TestMorpherUtils)


add_executable(test TestMorpherUtils.cpp)
target_link_libraries(
        test

        PRIVATE
        MLIRMorpherOps
        MLIRMorpherTransforms
        MLIRMorpherTransformOps
        libeasyloggingpp
)