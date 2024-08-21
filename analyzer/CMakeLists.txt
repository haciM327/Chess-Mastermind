cmake_minimum_required(VERSION 3.16)
project(analyzer)

# Print the source directory for debugging

# Set the path to your Python script
set(PYTHON_SCRIPT_PATH "${CMAKE_SOURCE_DIR}/analyzer/main.py")

# Set the output directory for the executable
set(OUTPUT_DIR "${CMAKE_BINARY_DIR}")

# Find Python3 interpreter
find_package(Python3 REQUIRED COMPONENTS Interpreter)

# Print the Python executable path for debugging

# Add custom target to run PyInstaller
add_custom_target(run_pyinstaller
    COMMAND ${Python3_EXECUTABLE} -m PyInstaller --add-data ${CMAKE_SOURCE_DIR}"/analyzer/analyzer.qml:." --onefile ${PYTHON_SCRIPT_PATH} --distpath ${OUTPUT_DIR}/bin -n analyze
    COMMENT "Running PyInstaller to build executable from Python script..."
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)

# Define a custom target that depends on `run_pyinstaller`
add_custom_target(build ALL
    DEPENDS run_pyinstaller
    COMMENT "Building project and running PyInstaller..."
)