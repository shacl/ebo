include(Fortran)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_no_backslash_escape.F90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_no_backslash_escape.F90.in
)

add_executable(use_no_backslash_escape ${CMAKE_CURRENT_BINARY_DIR}/use_no_backslash_escape.F90)

target_link_libraries(use_no_backslash_escape PRIVATE Fortran::NoBackslashEscape)

set(expected "")

if( "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "PGI" )
  set(expected "-Mbackslash\n")
elseif( "${CMAKE_Fortran_COMPILER_ID}" STREQUAL "Flang" )
  set(expected "-fno-backslash\n")
endif()

add_test(
  NAME no_backslash_escape
  COMMAND use_no_backslash_escape
)
set_tests_properties(no_backslash_escape PROPERTIES PASS_REGULAR_EXPRESSION "^${expected}$")
