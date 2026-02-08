cmake_minimum_required(VERSION 4.0)
project(sort_visualizer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

add_executable(
        ${PROJECT_NAME}
        main.cpp
        sorts/sorts.cpp
        utils/utils.cpp
)
