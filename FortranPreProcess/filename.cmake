# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  FortranPreProcess.filename.cmake
  GLOBAL PROPERTY FortranPreProcess.filename.cmake SET)

if(NOT FortranPreProcess.filename.cmake)
  function(FortranPreProcess_filename input output)
    get_filename_component(directory "${input}" DIRECTORY)
    get_filename_component(root "${input}" NAME_WE)
    get_filename_component(old_extension "${input}" EXT)
    string(TOLOWER ${old_extension} new_extension)
    set(${output} "${directory}${root}${new_extension}" PARENT_SCOPE)
  endfunction()
endif()
