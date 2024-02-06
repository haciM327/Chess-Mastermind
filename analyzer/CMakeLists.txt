cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(PYTHON_FIND_VERSION_MAJOR 3.10)

project(analyze VERSION 0.1 LANGUAGES CXX)



find_package(PythonLibs COMPONENTS Development)

#set (CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ./)
add_executable(analyze main.cpp)
target_include_directories(analyze PRIVATE ${PYTHON_INCLUDE_DIRS})
target_link_libraries(analyze ${PYTHON_LIBRARIES})
