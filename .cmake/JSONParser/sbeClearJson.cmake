macro(sbeClearJson prefix)
  foreach(json_var ${${prefix}})
    unset(${json_var})
  endforeach()
  
  unset(${prefix})
  unset(json_var)
endmacro()
