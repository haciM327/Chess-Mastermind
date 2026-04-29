cmake_minimum_required(VERSION 3.16)

include(FetchContent)

set(CMAKE_CXX_COMPILER "g++")
set(CMAKE_C_COMPILER "gcc")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DNDEBUG -std=gnu++17")
project(chess-mastermind VERSION 0.8 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(stockfish_found TRUE)
if(POLICY CMP0135)
	cmake_policy(SET CMP0135 NEW)
	set(CMAKE_POLICY_DEFAULT_CMP0135 NEW)
endif()

if (UNIX AND NOT APPLE)
    set(LINUX TRUE)

endif()

if (LINUX)
  message("Downloading Stockfish...")
  FetchContent_Declare(
    stockfish
    URL "https://github.com/official-stockfish/Stockfish/releases/latest/download/stockfish-ubuntu-x86-64-avx2.tar"
    URL_HASH  "SHA256=536c0c2c0cf06450df0bfb5e876ef0d3119950703a8f143627f990c7b5417964"
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  )
elseif(APPLE)
  message("Downloading Stockfish...")
  FetchContent_Declare(
    stockfish
    URL "https://github.com/official-stockfish/Stockfish/releases/latest/download/stockfish-macos-m1-apple-silicon.tar"
    URL_HASH  "4d77c4aa3ad9bd1ea8111f2ac5a4620fe7ebf998d6893bf828d49ccd579c8cb0"
    )
elseif(WIN32)
  message("Downloading Stockfish...")
  FetchContent_Declare(
    stockfish
    URL "https://github.com/official-stockfish/Stockfish/releases/latest/download/stockfish-windows-x86-64-avx2.zip"
    URL_HASH  "6f6c272ebd6ea594377715235c8a7326f75940ef4f4f856f45106028fe6ae900"
    )
else()
  set(stockfish_found FALSE)
  message("A compatible engine could not be found.")
endif()

if (stockfish_found)
  FetchContent_MakeAvailable(stockfish)
endif()


find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Quick Gui)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)
qt_standard_project_setup(REQUIRES 6.6)

file(COPY ${CMAKE_CURRENT_BINARY_DIR}/_deps/stockfish-src/stockfish-ubuntu-x86-64-avx2/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/engines/stockfish)
file(COPY ./games DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ./img DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
file(COPY ./qml DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

set(PROJECT_SOURCES
        src/main.cpp
        src/analyzer.cpp
        include/analyzer.hpp
        include/chess.hpp
        include/funcs.hpp
        src/funcs.cpp
        #mainwindow.cpp
        #mainwindow.h
        #mainwindow.ui
)
add_definitions(-DWIN32_LEAN_AND_MEAN -DNOMINMAX)
if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(Chess-Mastermind
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
    qt_add_qml_module(Chess-Mastermind URI main VERSION 1.0 QML_FILES qml/main.qml qml/analyzer.qml qml/config_analyzer.qml qml/config_game.qml qml/config_engine.qml
    SOURCES include/qmlfuncs.h src/qmlfuncs.cpp
    )
    # Define target properties for Android with Qt 6 as:
    #    set_property(TARGET Chess-Mastermind APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
    #                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
    # For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(Chess-Mastermind SHARED
            ${PROJECT_SOURCES}
        )
        # Define properties for Android with Qt 5 after find_package() calls as:
        #    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(Chess-Mastermind
            ${PROJECT_SOURCES}
        )
    endif()
endif()
target_include_directories(Chess-Mastermind PRIVATE include)
target_link_libraries(Chess-Mastermind PRIVATE Qt${QT_VERSION_MAJOR}::Widgets Qt6::Gui Qt6::Quick Qt6::QuickControls2 archive curl)
# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
    set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.Chess-Mastermind)
endif()
set_target_properties(Chess-Mastermind PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)


if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(Chess-Mastermind)
endif()
