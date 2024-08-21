cmake_minimum_required(VERSION 3.16)


project(chess-mastermind VERSION 0.6 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (UNIX AND NOT APPLE)
    set(LINUX TRUE)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

endif()

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Quick Gui)
find_package(Qt6 REQUIRED COMPONENTS QuickControls2)
qt_standard_project_setup(REQUIRES 6.6)

add_subdirectory(analyzer)
if (LINUX)
    file(COPY ./engines DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/share/chess-mastermind)
    file(COPY ./games DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/share/chess-mastermind)
    file(COPY ./img DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/share/chess-mastermind)
    file(COPY ./main.qml DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/share/chess-mastermind)
    file(COPY ./analyzer/analyzer.qml DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/share/chess-mastermind)
else()
    file(COPY ./engines DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
    file(COPY ./games DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
    file(COPY ./img DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
    file(COPY ./analyzer/analyzer.qml DESTINATION ${CMAKE_CURRENT_BINARY_DIR}/analyzer)
    file(COPY ./main.qml DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
endif()





set(PROJECT_SOURCES
        main.cpp
        #mainwindow.cpp
        #mainwindow.h
        #mainwindow.ui
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(Chess-Mastermind
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
qt_add_qml_module(Chess-Mastermind URI main VERSION 1.0 QML_FILES main.qml
    SOURCES qmlfuncs.h qmlfuncs.cpp
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
target_link_libraries(Chess-Mastermind PRIVATE Qt${QT_VERSION_MAJOR}::Widgets Qt6::Gui Qt6::Quick Qt6::QuickControls2)
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

include(GNUInstallDirs)
install(TARGETS Chess-Mastermind
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(Chess-Mastermind)
endif()

