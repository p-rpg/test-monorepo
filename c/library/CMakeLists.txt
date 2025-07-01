cmake_minimum_required(VERSION 3.10)
project(p_library C)

set(LIB_SOURCES src/library.c)

add_library(p_library_static STATIC ${LIB_SOURCES})
set_target_properties(p_library_static PROPERTIES OUTPUT_NAME "p_library_static")

add_library(p_library_dynamic SHARED ${LIB_SOURCES})
set_target_properties(p_library_dynamic PROPERTIES OUTPUT_NAME "p_library_dynamic")

target_include_directories(p_library_static PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
target_include_directories(p_library_dynamic PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/ DESTINATION include)

install(TARGETS p_library_static
    ARCHIVE DESTINATION lib
)

install(TARGETS p_library_dynamic
    LIBRARY DESTINATION lib       # .so, .dylib
    RUNTIME DESTINATION bin       # Windows .dll
)
