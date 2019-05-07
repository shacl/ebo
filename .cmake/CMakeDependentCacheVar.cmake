cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

function(CMAKE_DEPENDENT_CACHE_VAR variable type docstring default conditions force)
  list(APPEND type_list FILEPATH PATH STRING BOOL)
  list(FIND type_list ${type} type_found)
  if( type_found LESS 0 )
    message("CMAKE_DEPENDENT_CACHE_VAR error: variable type")
    message(FATAL_ERROR
      "'${type}' must be one of FILEPATH, PATH, STRING, or BOOL")
  endif()

  set(${variable}_AVAILABLE TRUE)
  foreach(condition ${conditions})
    string(REGEX REPLACE " +" ";"
      CMAKE_DEPENDENT_VARIABLE_DEP "${condition}")
    if(${CMAKE_DEPENDENT_VARIABLE_DEP})
    else()
      set(${variable}_AVAILABLE FALSE)
    endif()
  endforeach()

  if(${variable}_AVAILABLE)
    set(${variable} "${default}" CACHE "${type}" "${docstring}")
    set(${variable} "${${variable}}" CACHE "${type}" "${docstring}" FORCE)
  else()
    if(DEFINED ${variable})
      set(${variable} "${${variable}}" CACHE INTERNAL "${docstring}")
    endif()
    set(${variable} "${force}" PARENT_SCOPE)
  endif()
endfunction()

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/CMakeDependentCacheVar.cmake
  DESTINATION share/cmake/shacl/.cmake)
