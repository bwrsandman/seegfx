cmake_minimum_required(VERSION 3.23)

list(APPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

project(seegfx)

# Options
set(SEEGFX_LIBRARY_TYPE
    "STATIC"
    CACHE STRING "Linking type for library")
set_property(CACHE SEEGFX_LIBRARY_TYPE PROPERTY STRINGS STATIC SHARED)

add_library(seegfx ${SEEGFX_LIBRARY_TYPE})
target_sources(seegfx PRIVATE include/seegfx.h src/seegfx.cpp)
set_property(TARGET seegfx PROPERTY CXX_STANDARD 20)
set_property(TARGET seegfx PROPERTY CXX_STANDARD_REQUIRED ON)
set_property(TARGET seegfx PROPERTY CXX_EXTENSIONS OFF)

if(APPLE)
  find_package(Metal REQUIRED COMPONENTS MetalCpp)
  target_link_libraries(seegfx PRIVATE Metal::MetalCpp)
endif()
