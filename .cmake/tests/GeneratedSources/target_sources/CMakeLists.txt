include(GeneratedSources)

add_library(GeneratedSources.library STATIC baz.c)
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/bar.c" "")
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/dir/baz.f90" "")
file(WRITE baz.c "")

target_sources(GeneratedSources.library GENERATED INTERFACE
  "${CMAKE_CURRENT_BINARY_DIR}/bar.c")

string(SHA256 sha "GeneratedSources/target_sources")
string(SUBSTRING "${sha}" 0 7 test_string)

if(TARGET GeneratedSources.library.${test_string}.bar_c)
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name1"
    "GeneratedSources.library.${test_string}.bar_c")
else()
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name1" "")
endif()

add_test(
  NAME
    shacl.cmake.target_sources1
  COMMAND
    "${CMAKE_COMMAND}" -E compare_files
    "${CMAKE_CURRENT_SOURCE_DIR}/test1"
    "${CMAKE_CURRENT_BINARY_DIR}/target_name1")

target_sources(GeneratedSources.library GENERATED INTERFACE
  "${CMAKE_CURRENT_BINARY_DIR}/dir/baz.f90")

string(SHA256 sha "GeneratedSources/target_sources/dir")
string(SUBSTRING "${sha}" 0 7 test_string)

if(TARGET GeneratedSources.library.${test_string}.baz_f90)
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name2"
    "GeneratedSources.library.${test_string}.baz_f90")
else()
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name2" "")
endif()

add_test(
  NAME
    shacl.cmake.target_sources2
  COMMAND
    "${CMAKE_COMMAND}" -E compare_files
    "${CMAKE_CURRENT_SOURCE_DIR}/test2"
    "${CMAKE_CURRENT_BINARY_DIR}/target_name2")
