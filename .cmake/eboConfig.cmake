include(CMakeFindDependencyMacro)
find_dependency(shacl REQUIRED COMPONENTS trait)

include("${CMAKE_CURRENT_LIST_DIR}/eboTargets.cmake")
