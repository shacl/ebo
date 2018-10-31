cmake_minimum_required( VERSION 3.10 )
project( test_parser )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/..)
include(JSONParser)


file( READ ${CMAKE_CURRENT_SOURCE_DIR}/test.json test_info )  
sbeParseJson(test test_info)

# simple mcnp use case
list(APPEND result ${test})

foreach( key IN LISTS test.outer1 )
  list(APPEND result ${key})
  list(APPEND result ${test.outer1.${key}})
endforeach()

list(APPEND result ${test.outer2.key1} )

list(APPEND result ${test.array1})
foreach( item IN LISTS test.array1 )
  list(APPEND result ${test.array1.${item}})
endforeach()

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/test_result "${result}")

add_test(
  NAME
    json_parser
  COMMAND
    ${CMAKE_COMMAND} -E compare_files
    "${CMAKE_CURRENT_SOURCE_DIR}/reference"
    "${CMAKE_CURRENT_BINARY_DIR}/test_result"
    )
