cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

include(Fortran/Backtrace)
include(Fortran/Standard)
include(Fortran/TempArrays)
include(Fortran/NoBackslashEscape)
include(Fortran/Integer)
include(Fortran/Real)
include(Fortran/StandardAdherence)
include(Fortran/ModuleDirectory)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Fortran.cmake
  DESTINATION share/cmake/shacl/.cmake)
