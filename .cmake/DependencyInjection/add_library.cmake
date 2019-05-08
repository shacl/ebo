cmake_minimum_required(VERSION 3.12.1)
backup(add_library)

macro(add_library target_)
  push(target)
  set(target ${target_})

  previous_add_library(${target_} "${ARGN}")

  foreach(inc IN LISTS ${target}.injections)
    include(${inc})
  endforeach()

  pop(target)
endmacro()

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/add_library.cmake
  DESTINATION share/cmake/shacl/.cmake/DependencyInjection)
