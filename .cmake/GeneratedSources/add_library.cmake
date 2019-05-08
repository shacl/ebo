cmake_minimum_required(VERSION 3.12.1)
backup(add_library)

function(add_library)
  previous_add_library("${ARGN}")

  set(target ${ARGV0})

  get_target_property(is_alias ${target} ALIASED_TARGET)
  get_target_property(is_imported ${target} IMPORTED)
  get_target_property(library_type ${target} TYPE)

  if(is_alias OR is_imported)
    return()
  endif()

  set(libraries INTERFACE_LIBRARY STATIC_LIBRARY SHARED_LIBRARY)
  if(NOT library_type IN_LIST libraries)
    return()
  endif()

  previous_add_library(${target}.generated_sources.INTERFACE
    INTERFACE IMPORTED GLOBAL)

  target_link_libraries(${target} INTERFACE
    $<BUILD_INTERFACE:${target}.generated_sources.INTERFACE>)

  if(NOT library_type STREQUAL "INTERFACE_LIBRARY")
    previous_add_library(${target}.generated_sources.PUBLIC
      INTERFACE IMPORTED GLOBAL)

    target_link_libraries(${target} PUBLIC
      $<BUILD_INTERFACE:${target}.generated_sources.PUBLIC>)

    previous_add_library(${target}.generated_sources.PRIVATE
      INTERFACE IMPORTED GLOBAL)

    target_link_libraries(${target} PRIVATE
      $<BUILD_INTERFACE:${target}.generated_sources.PRIVATE>)
  endif()
endfunction()
