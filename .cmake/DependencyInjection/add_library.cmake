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
