target_sources(ebo INTERFACE "${prefix}/shacl/ebo.hpp")

if(shacl.ebo.tests)
  add_subdirectory(ebo/test)
endif()
