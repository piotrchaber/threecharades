cmake_minimum_required(VERSION 3.5...3.23)

project(szarada LANGUAGES CXX)

#set(Qt5_DIR C:/Qt/5.15.2/mingw81_32/lib/cmake)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(Qt5 COMPONENTS Core Quick Widgets REQUIRED)

set(UTILS_SOURCES
  utils/DataFile.h
  utils/DataFile.cpp
  utils/ResultFile.h
  utils/ResultFile.cpp
)

add_library(DataFile STATIC
  ${UTILS_SOURCES}
)

target_include_directories(DataFile PUBLIC
  utils
  ${Qt5Widgets_INCLUDE_DIRS}
)

target_link_directories(DataFile PUBLIC
  Qt5::Widgets
)

function(create_app_target appname)
    add_executable(${appname}
        main.cpp qml.qrc)

    target_link_libraries(${appname} PRIVATE
        DataFile
        Qt5::Core
        Qt5::Quick)
endfunction()

create_app_target("szarada")
