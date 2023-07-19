include(ExternalProject)

project(easyloggingpp NONE)

set(EASYLOGGINGPP_NAME easyloggingpp)
set(EASYLOGGINGPP_ROOT ${CMAKE_BINARY_DIR}/easyloggingpp)
set(EASYLOGGINGPP_BINARY ${CMAKE_BINARY_DIR}/easyloggingpp/build)
set(EASYLOGGINGPP_INSTALL ${CMAKE_BINARY_DIR}/easyloggingpp/install)

EXTERNALPROJECT_ADD(${EASYLOGGINGPP_NAME}
        GIT_REPOSITORY https://github.com/abumq/easyloggingpp.git
        GIT_TAG master
        SOURCE_DIR ${CMAKE_BINARY_DIR}/easyloggingpp
        BINARY_DIR ${CMAKE_BINARY_DIR}/easyloggingpp
        INSTALL_DIR ${CMAKE_BINARY_DIR}/easyloggingpp
        CMAKE_ARGS -Dbuild_static_lib=ON
#        CONFIGURE_COMMAND "echo `pwd` && ${CMAKE_COMMAND} -Dbuild_static_lib=ON ."
        INSTALL_COMMAND ""
        BUILD_BYPRODUCTS Easyloggingpp_libraries
        )


#message("easy logging src ${EASYLOGGINGPP_SRC}")
#
#target_include_directories(easyloggingpp::easyloggingpp INTERFACE ${EASYLOGGINGPP_ROOT}/src)
#target_link_libraries(easyloggingpp::easyloggingpp INTERFACE ${EASYLOGGINGCPP_ROOT}/libeasyloggingpp.a)
