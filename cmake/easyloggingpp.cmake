project(easyloggingpp)

project(easyloggingpp CXX)

#EXTERNALPROJECT_ADD(easyloggingpp
#       GIT_REPOSITORY git@github.com:abumq/easyloggingpp.git
#       GIT_TAG master
#       #URL https://github.com/abumq/easyloggingpp/archive/refs/tags/v9.97.1.zip
#       SOURCE_DIR ${CMAKE_BINARY_DIR}/easyloggingpp
#       BINARY_DIR ${CMAKE_BINARY_DIR}/easyloggingpp
#       INSTALL_DIR ${CMAKE_BINARY_DIR}/easyloggingpp
#       CMAKE_ARGS -Dbuild_static_lib=ON
#       INSTALL_COMMAND "")

include(FetchContent)
FETCHCONTENT_DECLARE(
        easyloggingpp
        GIT_REPOSITORY git@github.com:abumq/easyloggingpp.git
        GIT_TAG master
        CMAKE_ARGS -Dbuild_static_lib=ON
)

#set_property(TARGET easyloggingpp PROPERTY build_static_lib ON)
set(easyloggingpp_build_static_lib ON)
FETCHCONTENT_MAKEAVAILABLE(easyloggingpp)
FETCHCONTENT_GETPROPERTIES(easyloggingpp)

include_directories(${easyloggingpp_SOURCE_DIR}/src)
add_library(libeasyloggingpp STATIC ${easyloggingpp_SOURCE_DIR}/src/easylogging++.cc)
