
cmake_minimum_required(VERSION 3.12)
project(YourProjectName)

add_compile_definitions(UNICODE _UNICODE)



# Add a define for UNICODE for use with wmain




# Specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

find_package(PythonLibs COMPONENTS Development)

#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-subsystem,windows") # -Wl,-entry:wmainCRTStartup")

# Add the executable
add_executable(analyze game_review.c
    display.py game_review.c game_review.py pieces.py)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  target_compile_definitions(analyze PRIVATE SIZEOF_VOID_P=8 MS_WIN64)
endif()

# Add the -municode option for MinGW
if(MINGW)
  target_compile_options(analyze PRIVATE -DMS_WIN64 -DSIZEOF_VOID_P=8)
endif()

target_include_directories(analyze PRIVATE ${PYTHON_INCLUDE_DIRS})
target_link_libraries(analyze ${PYTHON_LIBRARIES})
