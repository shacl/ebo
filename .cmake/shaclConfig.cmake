include(CMakeFindDependencyMacro)

foreach(component IN LISTS shacl_FIND_COMPONENTS)
  set(DIR "${CMAKE_CURRENT_LIST_DIR}/${component}")
  find_dependency(${component} ${shacl_PACKAGE_VERSION} HINTS "${DIR}")
endforeach()
