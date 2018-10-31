# Here we're using the existance of global properties to act as something
# analoguous to C/C++ header guards to ensure the contents of this file are not
# redundantly defined.

get_property(
  git.submodule.packages.cmake
  GLOBAL PROPERTY git.submodule.packages.cmake SET)

if(NOT git.submodule.packages.cmake)
  include(CMakeDependentOption)

  option(git.submodule.packages
    "Enable git submodule support for CMake package" ON)

  CMAKE_DEPENDENT_OPTION(
    git.submodule.update
    "Update git submodule packages tracking branches on configure" ON
    "git.submodule.packages" OFF)

  find_package(Git REQUIRED)
  include(FunctionExtension)
  include(Git/Submodule/Packages/collect_state)
  include(Git/Submodule/Packages/init)
  include(Git/Submodule/Packages/update)
  include(Git/Submodule/Packages/list)
  include(Git/Submodule/Packages/find_package)

  set_property(
    GLOBAL PROPERTY git.packages.cmake
    "This is a header guard")
endif()

git_submodule_list()
