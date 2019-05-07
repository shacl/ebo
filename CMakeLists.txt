cmake_minimum_required(VERSION 3.12)

set(subproject OFF)
if(DEFINED PROJECT_NAME)
  set(subproject ON)
endif()

project(shacl-ebo
  VERSION 1.0.0
  DESCRIPTION "A library for composition via Empty Base Optimization"
  HOMEPAGE_URL "https://xcp-stash.lanl.gov/projects/SCL/repos/ebo"
  LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/.cmake")
include(Git/Submodule/Packages)
include(CMakePackageConfigHelpers)
include(CMakeDependentOption)
include(CTest)

if(EXISTS "${PROJECT_SOURCE_DIR}/cmake/specification.cmake")
  set(git.submodule.packages.specification
    "${PROJECT_SOURCE_DIR}/cmake/specification.cmake" CACHE FILEPATH
    "(READ ONLY) Path to consumed git submodule packages specification file" FORCE)
  include("${PROJECT_SOURCE_DIR}/cmake/specification.cmake")
endif()

CMAKE_DEPENDENT_OPTION(shacl.ebo.tests
  "Build the ebo tests and integrate with ctest"
  ON "BUILD_TESTING; NOT subproject" OFF)

CMAKE_DEPENDENT_OPTION(shacl.ebo.examples
  "Build the ebo example and integrate with ctest"
  ON "NOT subproject" OFF)

add_library(ebo INTERFACE)
add_library(shacl::ebo ALIAS ebo)

if(shacl.ebo.tests)
  include(Warnings)
  include(Sanitizers)

  configure_file(
    "${PROJECT_SOURCE_DIR}/cmake/CTestCustom.cmake"
    "${PROJECT_BINARY_DIR}/CTestCustom.cmake"
    COPYONLY)

  set(CMAKE_CXX_EXTENSIONS OFF)

  add_library(shacl::ebo::testing IMPORTED INTERFACE)

  set_target_properties(shacl::ebo::testing PROPERTIES
    INTERFACE_WARN_ALL ON
    INTERFACE_WARN_ERROR ON)

  set_property(TARGET shacl::ebo::testing APPEND PROPERTY
    COMPATIBLE_INTERFACE_BOOL
    WARN_ALL WARN_ERROR)

  find_package(Catch2)
  target_link_libraries(shacl::ebo::testing INTERFACE
    Catch2::Catch2
    shacl::cmake::Warnings_CXX
    shacl::cmake::Sanitizers_CXX
    shacl::ebo)
endif()

target_compile_features(ebo INTERFACE cxx_std_14)

find_package(shacl REQUIRED COMPONENTS trait)
target_link_libraries(ebo INTERFACE shacl::trait)

include(GNUInstallDirs)

string(CONCAT prefix
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>"
  "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>")

target_include_directories(ebo INTERFACE "${prefix}")

add_subdirectory(include/shacl)

if(ebo.examples)
  add_subdirectory(examples/1)
endif()

install(DIRECTORY include/
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  FILES_MATCHING PATTERN "*.hpp"
  PATTERN "*test*" EXCLUDE)

install(FILES
  "${CMAKE_CURRENT_SOURCE_DIR}/.cmake/shacl-config.cmake"
  DESTINATION share/cmake/shacl)

install(TARGETS ebo EXPORT eboTargets)

install(EXPORT eboTargets
  FILE shacl-ebo-targets.cmake
  NAMESPACE shacl::
  DESTINATION share/cmake/shacl-ebo)

write_basic_package_version_file("shacl-ebo-config-version.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

install(FILES
  "${PROJECT_SOURCE_DIR}/cmake/shacl-ebo-config.cmake"
  "${PROJECT_BINARY_DIR}/shacl-ebo-config-version.cmake"
  DESTINATION share/cmake/shacl-ebo)

if(NOT subproject)
  set(CPACK_PACKAGE_VENDOR "Los Alamos National Laboratory")
  set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
  set(CPACK_PACKAGE_CONTACT "amccartney@lanl.gov")
  include(CPack)
endif()
