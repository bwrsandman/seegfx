if(APPLE)
  include(FindPackageHandleStandardArgs)

  # Metal
  find_path(
    METAL_INCLUDE_DIR
    NAMES metal/metal.h
    PATHS ${CMAKE_FIND_ROOT_PATH})
  find_library(
    METAL_LIBRARY
    NAMES metal
    PATHS ${CMAKE_FIND_ROOT_PATH})

  # MetalKit
  find_path(
    METALKIT_INCLUDE_DIR
    NAMES metalkit/metalkit.h
    PATHS ${CMAKE_FIND_ROOT_PATH})
  find_library(
    METALKIT_LIBRARY
    NAMES metalkit
    PATHS ${CMAKE_FIND_ROOT_PATH})

  mark_as_advanced(METAL_INCLUDE_DIR METAL_LIBRARY METALKIT_INCLUDE_DIR
                   METALKIT_LIBRARY)

  # Metal::Metal target (if found)
  add_library(Metal::Metal INTERFACE IMPORTED GLOBAL)
  target_include_directories(Metal::Metal INTERFACE ${METAL_INCLUDE_DIR})
  target_link_libraries(
    Metal::Metal INTERFACE ${METAL_LIBRARIES} "-framework Foundation"
                           "-framework Metal")

  # Metal::MetalCpp target
  add_library(Metal::MetalCpp INTERFACE IMPORTED GLOBAL)
  target_sources(
    Metal::MetalCpp
    INTERFACE ${CMAKE_SOURCE_DIR}/3rdParty/metal-cpp/SingleHeader/Metal.cpp)
  target_include_directories(
    Metal::MetalCpp
    INTERFACE ${CMAKE_SOURCE_DIR}/3rdParty/metal-cpp/SingleHeader)
  target_link_libraries(Metal::MetalCpp INTERFACE Metal::Metal)

  # Metal::MetalKit target (if found)
  add_library(Metal::MetalKit INTERFACE IMPORTED GLOBAL)
  target_include_directories(Metal::MetalKit INTERFACE ${METALKIT_INCLUDE_DIR})
  target_link_libraries(
    Metal::MetalKit INTERFACE ${METALKIT_LIBRARIES} "-framework Foundation"
                              "-framework MetalKit")
endif()
