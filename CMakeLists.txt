cmake_minimum_required(VERSION 3.8)

set(subproject OFF)
if(DEFINED PROJECT_NAME)
  set(subproject ON)
endif()

project(ebo VERSION 0.1.0 LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/.cmake")

include(CTest)
include(CMakeDependentOption)
include(Git/Submodule/Packages)

CMAKE_DEPENDENT_OPTION(ebo.tests
  "Build the ebo tests and integrate with ctest"
  ON "BUILD_TESTING; NOT subproject" OFF)

CMAKE_DEPENDENT_OPTION(ebo.examples
  "Build the ebo example and integrate with ctest"
  ON "NOT subproject" OFF)

add_library(ebo INTERFACE)
add_library(shacl::ebo ALIAS ebo)

find_package(shacl REQUIRED COMPONENTS trait)
target_link_libraries(ebo INTERFACE shacl::trait)

target_include_directories(ebo INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
  $<INSTALL_INTERFACE:include>)

target_compile_features(ebo INTERFACE cxx_std_14)

if(ebo.tests)
  include(Warnings)
  include(Sanitizers)

  find_package(Catch2)

  set(CMAKE_CXX_EXTENSIONS OFF)

  add_library(testing INTERFACE)
  add_library(shacl::ebo::testing ALIAS testing)

  set_target_properties(testing PROPERTIES
    INTERFACE_WARN_ALL ON
    INTERFACE_WARN_ERROR ON)

  set_property(TARGET testing APPEND PROPERTY COMPATIBLE_INTERFACE_BOOL
    WARN_ALL WARN_ERROR)

  target_link_libraries(testing INTERFACE
    Catch2::Catch2
    Warnings::Warnings_CXX
    shacl::sanitizers_CXX
    shacl::ebo)
endif()

add_subdirectory(src/shacl)

if(ebo.examples)
  add_subdirectory(examples/1)
endif()

install(TARGETS ebo EXPORT eboTargets)

install(EXPORT eboTargets
  FILE eboTargets.cmake
  NAMESPACE shacl::
  DESTINATION share/cmake/shacl/ebo)

install(DIRECTORY src/ DESTINATION include
  PATTERN "*test*" EXCLUDE
  PATTERN "*CMakeLists.txt" EXCLUDE
  PATTERN "*~" EXCLUDE)

include(CMakePackageConfigHelpers)
write_basic_package_version_file("eboConfigVersion.cmake"
  VERSION ${ebo_VERSION}
  COMPATIBILITY SameMajorVersion)

install(FILES
  "${ebo_SOURCE_DIR}/.cmake/eboConfig.cmake"
  "${ebo_BINARY_DIR}/eboConfigVersion.cmake"
  DESTINATION share/cmake/shacl/ebo)

install(FILES
  "${ebo_SOURCE_DIR}/.cmake/shaclConfig.cmake"
  DESTINATION share/cmake/shacl)

if(NOT subproject)
  include(InstallRequiredSystemLibraries)
  set(CPACK_PACKAGE_VENDOR "Los Alamos National Laboratory")
  set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
  set(CMAKE_PROJECT_HOMEPAGE_URL "https://xcp-stash.lanl.gov/projects/SCL/repos/ebo")
  set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "A library for composition via Empty Base Optimization")
  set(CPACK_PACKAGE_CONTACT "amccartney@lanl.gov")
  include(CPack)
endif()
