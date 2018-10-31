include(Backports/IncludeGuard)
include_guard(GLOBAL)

if(CMAKE_VERSION VERSION_LESS 3.9.6)
  list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/MPI")
endif()
