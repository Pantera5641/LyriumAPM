cmake_minimum_required(VERSION 3.16)

project(LyriumAPM VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5 REQUIRED COMPONENTS Core Quick Qml)

add_executable(LyriumAPM
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

        resources.qrc
)

target_link_libraries(LyriumAPM PRIVATE Qt5::Core Qt5::Quick Qt5::Qml)

#set_target_properties(LyriumAPM PROPERTIES WIN32_EXECUTABLE TRUE)

include(GNUInstallDirs)

install(TARGETS LyriumAPM RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})