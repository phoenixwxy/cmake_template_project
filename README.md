

English | [简体中文](./README.cn.md)

# README

machine translation -_-!!!

## CMake project template

Implemented a CMake project based on C++ language in Linux environment

## Environmental requirements

- CMake 3.1+ has been installed.
- Compiler capable of supporting C++11 (4.8+)

## Compile and install

```
$ mkdir build
$ cd build
$ cmake ..
# Because some versions use cache, otherwise some version information is not available. . Fix afterwards
$ cmake ..
$ make -j
$ make install DESTDIR={your destination}
```

## Cross compilation and installation

```
$ mkdir build
$ cd build
# cmake .. -DCMAKE_TOOLCHAIN_FILE=../platforms/linux/arm.himix200.cmake
$ cmake .. -DCMAKE_TOOLCHAIN_FILE=../platforms/linux/arm.himix200.cmake -DTOOLCHAIN_ROOTDIR={your toolchain directory}/arm-himix200-linux
$ make -j
$ make install DESTDIR={your destination}
```

## TODO

- Support the construction of 3rdParty

- Support unit testing
- Support thread pool
- Support static code inspection

### Directory Structure

```
.
├── 3rdparty # Third-party library source code dependency and library dependency storage location
│ ├── CMakeLists.txt # The source code of the third-party library depends on the compiled CMakeLists file
│ ├── spdlog # The source code depends on the sample project spdlog (github searchable)
│ └── target # Library dependency storage directory
│ ├── linux_armv7-a # distinguished by platform and architecture
│ │ ├── include # Header file storage directory
│ │ └── lib # Library file storage directory
│ └── linux_x86-64
│ ├── include
│ └── lib
├── cmake # Store project-related cmakem module files
│ ├── load_3rdparty.cmake
│ ├── messagecolor.cmake
│ ├── toolchain_options.cmake
│ └── utils.cmake
├── CMakeLists.txt # Project root directory CMakeLists file, cmake entry file
├── conf # Project configuration file storage directory
├── doc # Project document storage directory
├── platforms # Project platform-related content storage directory, including cross-compilation
│ └── linux
│ └── arm.himix200.cmake
├── README.md # Project description
├── scripts # Storage directory for related scripts, including continuous integration and deployment related
├── src # Project source directory
│ ├── CMakeLists.txt
│ ├── common
│ ├── log
│ └── main
└── tests # Test sample source code storage directory
    ├── CMakeLists.txt
```

### Third-party library source code dependency

If you want to rely on the source code of a third-party project and compile it together, we can manage the third-party source code through git submodule to realize source code dependency and its version management. Of course, you can directly put the source code into the 3rdparty directory without using git submodule.

Add a git submodule:

```
# url is the address of the git project
# path is the project storage directory, which can be multi-level directories, the directory name is generally the project name
# git add <url.git> <path>
# Example, after execution, it will directly pull the project source code to the 3rdparty/spdlog directory, and create a .gitmodule in the warehouse root directory
$ git submodule add https://github.com/gabime/spdlog.git 3rdparty/spdlog
```

You can also add a specified branch:

```
# Note: The command needs to be executed in the project root directory, the source code will be pulled directly for the first time, without update
$ git submodule add -b v1.x https://github.com/gabime/spdlog.git 3rdparty/spdlog
$ git submodule update --remote
```

The final .gitmodules file is:

```
[submodule "3rdparty/spdlog"]
    path = 3rdparty/spdlog
    url = https://github.com/gabime/spdlog.git
    branch = v1.x
```

To compile the source code of the tripartite project (the source code of the tripartite project you depend on supports the CMake build method), write in 3rdparty/CMakeLists.txt:

```
CMAKE_MINIMUM_REQUIRED(VERSION 3.4)
PROJECT(HiApp3rdparty)

ADD_SUBDIRECTORY(spdlog)
```

If you include CMakeLists.txt in 3rdparty in the root directory CMakeLists.txt, you can compile third-party libraries:

```
ADD_SUBDIRECTORY(3rdparty)
```

Through TARGET_LINK_LIBRARIES, you can specify the name of the third-party project to achieve the link.