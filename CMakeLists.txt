cmake_minimum_required(VERSION 3.16)

include(FetchContent)

include(GNUInstallDirs)

project(chess-mastermind VERSION 0.8 LANGUAGES C CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_AUTOGEN_BUILD_DIR "${CMAKE_BINARY_DIR}/autogen")

set(QT_QUICK_COMPILER OFF)
set(QT_QMLCACHEGEN OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_link_options("$<$<CXX_COMPILER_ID:GNU>:-static-libgcc;-static-libstdc++>")


set(stockfish_found TRUE)
if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW)
  set(CMAKE_POLICY_DEFAULT_CMP0135 NEW)
endif()

if (UNIX AND NOT APPLE)
  set(LINUX TRUE)

endif()

find_package(Qt6 REQUIRED COMPONENTS
    Widgets
    Gui
    Quick
    Qml
    QuickControls2
)

qt_standard_project_setup(REQUIRES 6.6)

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
qt_add_executable(Chess-Mastermind
    MANUAL_FINALIZATION
    ${PROJECT_SOURCES}
)
qt_add_qml_module(Chess-Mastermind URI main VERSION 1.0 NO_CACHEGEN
    QML_FILES
    qml/main.qml
    qml/analyzer.qml
    qml/config_analyzer.qml
    qml/config_game.qml
    qml/config_engine.qml

    SOURCES
    include/qmlfuncs.h
    src/qmlfuncs.cpp
)

target_include_directories(Chess-Mastermind PRIVATE include)
if (WIN32)
  target_link_libraries(Chess-Mastermind PRIVATE Qt6::Widgets Qt6::Gui Qt6::Qml Qt6::Quick Qt6::QuickControls2 ${CMAKE_CURRENT_SOURCE_DIR}/libarchive.dll.a ${CMAKE_CURRENT_SOURCE_DIR}/libcurl.dll.a)
else()
  target_link_libraries(Chess-Mastermind PRIVATE Qt6::Widgets Qt6::Gui Qt6::Qml Qt6::Quick Qt6::QuickControls2 archive curl)
endif()
# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.

set_target_properties(Chess-Mastermind PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

qt_finalize_executable(Chess-Mastermind)


# Install commands
if (WIN32)
  install(
    TARGETS Chess-Mastermind
    RUNTIME DESTINATION .
)
else()
  install(
    TARGETS Chess-Mastermind
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
endif()
message(${CMAKE_INSTALL_DATADIR})
if (WIN32)
  install(
    DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/engines
      ${CMAKE_CURRENT_BINARY_DIR}/games
      ${CMAKE_CURRENT_BINARY_DIR}/qml
      ${CMAKE_CURRENT_BINARY_DIR}/img
    DESTINATION
      .
  )
else()
  install(
    DIRECTORY
      ${CMAKE_CURRENT_BINARY_DIR}/engines
      ${CMAKE_CURRENT_BINARY_DIR}/games
      ${CMAKE_CURRENT_BINARY_DIR}/qml
      ${CMAKE_CURRENT_BINARY_DIR}/img
    DESTINATION
      ${CMAKE_INSTALL_DATADIR}/chess_mastermind/
  )
endif()
