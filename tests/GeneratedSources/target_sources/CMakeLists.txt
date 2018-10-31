include(CTest)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../..)

include(GeneratedSources)

add_library(foo STATIC baz.c)
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/bar.c "")
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/dir/baz.f90 "")
file(WRITE baz.c "")

target_sources(foo GENERATED INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/bar.c)
string(SHA256 sha "GeneratedSources/target_sources")
string(SUBSTRING "${sha}" 0 7 test_string)

if(TARGET foo.${test_string}.bar_c)
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name1" "foo.${test_string}.bar_c")
else()
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name1" "")
endif()

add_test(
  NAME
    target_sources1
  COMMAND
    ${CMAKE_COMMAND} -E compare_files
    "${CMAKE_CURRENT_SOURCE_DIR}/test1"
    "${CMAKE_CURRENT_BINARY_DIR}/target_name1"
    )

target_sources(foo GENERATED INTERFACE ${CMAKE_CURRENT_BINARY_DIR}/dir/baz.f90)

string(SHA256 sha "GeneratedSources/target_sources/dir")
string(SUBSTRING "${sha}" 0 7 test_string)
if(TARGET foo.${test_string}.baz_f90)
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name2" "foo.${test_string}.baz_f90")
else()
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/target_name2" "")
endif()

add_test(
  NAME
    target_sources2
  COMMAND
    ${CMAKE_COMMAND} -E compare_files
    "${CMAKE_CURRENT_SOURCE_DIR}/test2"
    "${CMAKE_CURRENT_BINARY_DIR}/target_name2"
    )
