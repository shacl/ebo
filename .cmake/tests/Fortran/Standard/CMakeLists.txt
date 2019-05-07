include(Fortran)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_standard.f90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_standard.f90.in)

add_executable(use_standard ${CMAKE_CURRENT_BINARY_DIR}/use_standard.f90)
set_target_properties(use_standard PROPERTIES Fortran_STANDARD 2008)
target_link_libraries(use_standard PRIVATE Fortran::Standard)

set(expected_GNU "-std=f2008")
set(expected_Intel "-stand=f08")
if( WIN32 )
  set(expected_Intel "/stand:f08")
endif()
set( expected_Flang "" ) 
set( expected_PGI "-Mstandard" ) 

add_test(
  NAME shacl.cmake.Fortran.Standard
  COMMAND use_standard
)
set_tests_properties(shacl.cmake.Fortran.Standard
PROPERTIES
  PASS_REGULAR_EXPRESSION "^${expected_${CMAKE_Fortran_COMPILER_ID}}\n$"
)
