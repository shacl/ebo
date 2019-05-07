cmake_minimum_required(VERSION 3.12.1)
backup(add_executable)

macro(add_executable target_)
  push(target)
  set(target ${target_})

  previous_add_executable(${target} "${ARGN}")

  foreach(inc IN LISTS ${target}.injections)
    include(${inc})
  endforeach()

  pop(target)
endmacro()

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/add_executable.cmake
  DESTINATION share/cmake/shacl/.cmake/DependencyInjection)
