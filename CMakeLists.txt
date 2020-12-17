CMAKE_MINIMUM_REQUIRED(VERSION 3.1)

#-----------------------------------------------#
# Include Utils cmake
#-----------------------------------------------#
INCLUDE(cmake/utils.cmake)

#-----------------------------------------------#
# Set environment property
# in cmake/utils.cmake
#-----------------------------------------------#
set_env_prop()

#-----------------------------------------------#
# Set Message Color
#-----------------------------------------------#
INCLUDE(cmake/messagecolor.cmake)

#-----------------------------------------------#
# Set Project Version
#-----------------------------------------------#
MESSAGE(INFO "--------------------------------")
MESSAGE(INFO "Set Project Version")

SET(PROJECT_VERSION_MAJOR 0)
SET(PROJECT_VERSION_MINOR 1)
SET(PROJECT_VERSION_PATCH 0)

# cmake/utils.cmake
project_extract_version()
MESSAGE(INFO "--------------------------------")

MESSAGE(INFO "--------------------------------")
PROJECT(project VERSION ${PROJECT_VERSION} LANGUAGES CXX)
MESSAGE(STATUS "Build ${PROJECT_NAME}: ${PROJECT_VERSION}")
MESSAGE(INFO "--------------------------------")

#--------------------------------------------
# Set compilation options
#--------------------------------------------
MESSAGE(INFO "--------------------------------")
MESSAGE(INFO "Set and Check Platform")
IF(NOT TARGET_OS)
    SET(TARGET_OS linux)
ENDIF()
IF(NOT TARGET_ARCH)
    SET(TARGET_ARCH x86-64)
ENDIF()
MESSAGE(STATUS "Your target os : ${TARGET_OS}")
MESSAGE(STATUS "Your target arch : ${TARGET_ARCH}")
MESSAGE(INFO "--------------------------------")

MESSAGE(INFO "--------------------------------")
MESSAGE(INFO "Set Compilation")
INCLUDE(cmake/toolchain_options.cmake)
MESSAGE(INFO "--------------------------------")

# Build tests
MESSAGE(INFO "--------------------------------")
OPTION(BUILD_TESTS "Build with tests" ON)
MESSAGE(STATUS "Build Tests: ${BUILD_TESTS}")
MESSAGE(INFO "--------------------------------")

#--------------------------------------------#
# Set default build to debug
#--------------------------------------------#
MESSAGE(INFO "--------------------------------")
IF(NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose Release or Debug" FORCE)
ENDIF()
MESSAGE(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
# cmake -DCMAKE_BUILD_TYPE=Release ..
MESSAGE(INFO "If want Release, please use \"cmake -DCMAKE_BUILD_TYPE=Release ..\"")
MESSAGE(INFO "--------------------------------")

MESSAGE(INFO "--------------------------------")
MESSAGE(INFO "Load 3rdparty")
INCLUDE(cmake/3rdparty.cmake)
LOAD_LIB3RDPARTY(TARGET_OS TARGET_ARCH)
MESSAGE(INFO "--------------------------------")

#--------------------------------------------#
# build 3rdparty
#--------------------------------------------#
MESSAGE(INFO "--------------------------------")
MESSAGE(STATUS "Build 3rdparty")
ADD_SUBDIRECTORY(3rdparty)
MESSAGE(INFO "--------------------------------")

#--------------------------------------------#
# Build application
#--------------------------------------------#
MESSAGE(INFO "--------------------------------")
MESSAGE(INFO "Build application")
# project_extract_version()

# Add you need submodule
ADD_SUBDIRECTORY(src)

IF(BUILD_TESTS)
    ADD_SUBDIRECTORY(tests)
ENDIF()

MESSAGE(INFO "--------------------------------")
