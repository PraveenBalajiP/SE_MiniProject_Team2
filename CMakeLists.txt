cmake_minimum_required(VERSION 3.16)

project(RailwayReservationSystem
    VERSION 1.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

enable_testing()

add_executable(railway_reservation
    src/main.cpp
)

target_include_directories(railway_reservation
    PRIVATE
        include
)
