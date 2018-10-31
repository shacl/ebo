include(Fortran)

file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/use_temp_arrays.F90
              INPUT ${CMAKE_CURRENT_LIST_DIR}/use_temp_arrays.F90.in
)

add_executable(use_temp_arrays ${CMAKE_CURRENT_BINARY_DIR}/use_temp_arrays.F90)
set_target_properties(use_temp_arrays PROPERTIES Fortran_TEMP_ARRAY_THRESHOLD 1024)
target_link_libraries(use_temp_arrays PRIVATE Fortran::TempArrays)

set(expected_GNU "-fmax-stack-var-size=1024000\n")
set(expected_Intel "-heap-arrays 1024\n")
if( WIN32 )
  set(expected_Intel "/heap-arrays:1024\n")
endif()
set(expected_PGI "-Mnostack_arrays\n")

add_test(
  NAME Fortran.TempArrays
  COMMAND use_temp_arrays
)
set_tests_properties(Fortran.TempArrays PROPERTIES
  PASS_REGULAR_EXPRESSION "^${expected_${CMAKE_Fortran_COMPILER_ID}}$"
)
