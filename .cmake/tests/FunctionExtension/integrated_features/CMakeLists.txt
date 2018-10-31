cmake_minimum_required( VERSION 2.8 )
project( push_pop_test )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(FunctionExtension)

backup( add_library )

function( add_library )
 previous_add_library( "${ARGN}" )
endfunction()

call( add_library testLib STATIC "" )

target_sources( testLib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/test_source.cpp )
