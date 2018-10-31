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
