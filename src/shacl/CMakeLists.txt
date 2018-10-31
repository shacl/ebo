target_sources(ebo INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/ebo.hpp>
  $<INSTALL_INTERFACE:include/shacl/ebo.hpp>)

if(ebo.tests)
  add_subdirectory(ebo/test)
endif()
