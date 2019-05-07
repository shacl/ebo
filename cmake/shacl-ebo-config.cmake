include(CMakeFindDependencyMacro)

if (NOT TARGET shacl::trait)
  find_dependency(shacl-trait HINTS "${CMAKE_CURRENT_LIST_DIR}/../shacl-trait")
endif()

include("${CMAKE_CURRENT_LIST_DIR}/shacl-ebo-targets.cmake")
