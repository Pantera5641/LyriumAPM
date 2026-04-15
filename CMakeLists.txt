cmake_minimum_required(VERSION 4.0.0)

project(LyriumAPM VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appLyriumAPM
    main.cpp
        src/database/database.cpp
        src/database/database.h
        src/database/record.cpp
        src/database/record.h
        src/utils/utils.cpp
        src/utils/utils.h
        src/logic/recordPage/recordPageLogic.cpp
        src/logic/recordPage/recordPageLogic.h
        src/logic/models/tagListModel/tagListModel.cpp
        src/logic/models/tagListModel/tagListModel.h
        src/logic/models/tagListModel/tagItem.h
        src/logic/models/databaseModel/databaseModel.h
        src/database/simpleRecord.h
        src/logic/models/databaseModel/databaseModel.cpp
        src/database/simpleRecord.cpp
)
file(COPY ${CMAKE_SOURCE_DIR}/data DESTINATION ${CMAKE_BINARY_DIR})
file(COPY ${CMAKE_SOURCE_DIR}/logo.png DESTINATION ${CMAKE_BINARY_DIR})
set(QML_DIR "${CMAKE_SOURCE_DIR}/qml")
set(RES_DIR "${CMAKE_SOURCE_DIR}/resources")

file(GLOB_RECURSE QML_FILES "${QML_DIR}/*.qml")
file(GLOB_RECURSE RESOURCES_ABS "${RES_DIR}/*.png")

file(GLOB_RECURSE QML_FILES RELATIVE "${CMAKE_SOURCE_DIR}" "qml/*.qml")
set(QML_FILES_REL "")
foreach(qml_file ${QML_FILES})
    set(QML_FILES_REL ${QML_FILES_REL} "${CMAKE_SOURCE_DIR}/${qml_file}")
    set_source_files_properties("${CMAKE_SOURCE_DIR}/${qml_file}" PROPERTIES
        QT_RESOURCE_ALIAS "${qml_file}"
    )
endforeach()

file(GLOB_RECURSE RESOURCES RELATIVE "${CMAKE_SOURCE_DIR}" "resources/*.png")
set(RESOURCES_ABS "")
foreach(res ${RESOURCES})
    set(RESOURCES_ABS ${RESOURCES_ABS} "${CMAKE_SOURCE_DIR}/${res}")
    set_source_files_properties("${CMAKE_SOURCE_DIR}/${res}" PROPERTIES
        QT_RESOURCE_ALIAS "${res}"
    )
endforeach()

qt_add_qml_module(appLyriumAPM
    URI LyriumAPM
    VERSION 1.0
    QML_FILES
        ${QML_FILES_REL}
    RESOURCES
        ${RESOURCES_ABS}
        resources/zaako.mp4
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
