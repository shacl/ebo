# This macro accepts a target name as an argument and creates a variable called
# `stripped_target_name` in the scope of the calling context. This variable can
# be dereference to provide the input target name without namespace prefixes
# expected of alias and imported targets
macro( stripped target_name )
  string(REPLACE ":" ";" split_target_name "${target_name}")
  list(GET split_target_name -1 stripped_target_name)
  unset(split_target_name)
endmacro()
