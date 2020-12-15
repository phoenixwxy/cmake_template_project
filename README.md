# CMake项目模板

### 目录结构

```
.
├── 3rdparty                # 第三方库源码依赖和库依赖存放位置
│   ├── CMakeLists.txt      # 第三方库源码依赖编译CMakeLists文件
│   ├── spdlog              # 源码依赖示例项目spdlog(github可搜索)
│   └── target              # 库依赖存放目录
│       ├── linux_armv7-a   # 以平台和架构命名区分
│       │   ├── include     # 头文件存放目录
│       │   └── lib         # 库文件存放目录
│       └── linux_x86-64
│           ├── include
│           └── lib
├── cmake                   # 存放项目相关的cmakem模块文件
│   ├── load_3rdparty.cmake
│   ├── messagecolor.cmake
│   ├── toolchain_options.cmake
│   └── utils.cmake
├── CMakeLists.txt          # 项目根目录CMakeLists文件，cmake入口文件
├── conf                    # 项目配置文件存放目录
├── doc                     # 项目文档存放目录
├── platforms               # 项目平台性相关内容存放目录，包括交叉编译
│   └── linux
│       └── arm.himix200.cmake
├── README.md               # 项目说明
├── scripts                 # 相关脚本存放目录，包括持续集成和部署相关
├── src                     # 项目源码目录
│   ├── CMakeLists.txt
│   ├── common
│   ├── logger
│   └── main
└── tests                   # 测试示例源码存放目录
    ├── CMakeLists.txt
    └── test_logger.cpp
```



### 第三方库源码依赖

如果你想依赖第三方项目源码，一起编译，则我们可以通过git submodule来管理第三方源码，实现源码依赖和它的版本管理。当然你可以不用git submodule，直接将源码手动放入3rdparty目录中。

添加一个git submodule:

```
# url为git项目地址
# path为项目存放目录，可以多级目录，目录名一般为项目名称
# git add <url.git> <path>
# 示例，执行后，会直接拉取项目源码到3rdparty/spdlog目录下，并创建.gitmodule在仓库根目录下
$ git submodule add  https://github.com/gabime/spdlog.git 3rdparty/spdlog
```

还可以做到带指定分支进行添加操作：

```
# 注意：命令需要在项目根目录下执行，第一次会直接拉取源码，不用update
$ git submodule add -b v1.x   https://github.com/gabime/spdlog.git 3rdparty/spdlog
$ git submodule update --remote
```

最后的.gitmodules文件为：

```
[submodule "3rdparty/spdlog"]
    path = 3rdparty/spdlog                                                   
    url = https://github.com/gabime/spdlog.git 
    branch = v1.x
```

实现三方项目源码编译（首先你依赖的三方项目源码是支持CMake构建方式的），在3rdparty/CMakeLists.txt中编写：

```
CMAKE_MINIMUM_REQUIRED(VERSION 3.4)                                             
PROJECT(HiApp3rdparty)

ADD_SUBDIRECTORY(spdlog)
```

在根目录CMakeLists.txt中包含3rdparty中CMakeLists.txt，就可以编译第三方库了:

```
ADD_SUBDIRECTORY(3rdparty)
```

通过TARGET_LINK_LIBRARIES就可以指定第三方项目名称实现链接。



# 环境要求

- CMake 3.1+ 已安装。
- 能够支持C++11的编译器(4.8+)

# 编译和安装

```
$ mkdir build
$ cd build
$ cmake ..
$ make -j
$ make install DESTDIR={your destination}
```

# 交叉编译和安装

```
$ mkdir build
$ cd build
# cmake .. -DCMAKE_TOOLCHAIN_FILE=../platforms/linux/arm.himix200.cmake
$ cmake .. -DCMAKE_TOOLCHAIN_FILE=../platforms/linux/arm.himix200.cmake -DTOOLCHAIN_ROOTDIR={your toolchain directory}/arm-himix200-linux
$ make -j
$ make install DESTDIR={your destination}
```