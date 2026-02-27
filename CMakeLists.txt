cmake_minimum_required(VERSION 4.0.0)

project(LyriumAPM VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appLyriumAPM
    main.cpp
)

qt_add_qml_module(appLyriumAPM
    URI LyriumAPM
    VERSION 1.0
    QML_FILES
        Main.qml
        TittleBar.qml
        PageTabButton.qml
        TabText.qml
        ImageButton.qml
    RESOURCES
        logo.png
        logo64.png
        icon_cross.png
        icon_dash.png
        icon_maximize.png
)

set_target_properties(appLyriumAPM PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appLyriumAPM
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appLyriumAPM
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
