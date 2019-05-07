cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

include(Intel/FortranAssumptions)
include(Intel/FortranStandardAdherence)
include(Intel/FPModel)
include(Intel/FPSpeculation)

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/Intel.cmake
  DESTINATION share/cmake/shacl/.cmake)
