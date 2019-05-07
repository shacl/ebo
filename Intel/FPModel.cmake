cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_FLOATING_POINT_MODEL
BRIEF_DOCS
"Intel Fortran floating point model"
FULL_DOCS
"This property specifies the Intel floating-point model to apply.
Options are: precise, fast[=1|2], consistent, strict, source")

add_library(shacl::cmake::Intel::FloatingPoint::Model_C
  INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
add_library(Intel_FPModel_C ALIAS shacl::cmake::Intel::FloatingPoint::Model_C)
add_library(Intel::FPModel_C ALIAS shacl::cmake::Intel::FloatingPoint::Model_C)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>:"
    "$<$<STREQUAL:Intel,${CMAKE_C_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-model=$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
      "$<$<PLATFORM_ID:Windows>:/fp:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
    ">"
  ">")

target_compile_options(shacl::cmake::Intel::FloatingPoint::Model_C
  INTERFACE ${generator})

add_library(shacl::cmake::Intel::FloatingPoint::Model_CXX
  INTERFACE IMPORTED GLOBAL)

add_library(Intel_FPModel_CXX ALIAS
  shacl::cmake::Intel::FloatingPoint::Model_CXX)

add_library(Intel::FPModel_CXX ALIAS
  shacl::cmake::Intel::FloatingPoint::Model_CXX)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>:"
    "$<$<STREQUAL:Intel,${CMAKE_CXX_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-model=$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
      "$<$<PLATFORM_ID:Windows>:/fp:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
    ">"
  ">")

target_compile_options(shacl::cmake::Intel::FloatingPoint::Model_CXX
  INTERFACE ${generator})

add_library(shacl::cmake::Intel::FloatingPoint::Model_Fortran
  INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
add_library(Intel_FPModel_Fortran ALIAS
  shacl::cmake::Intel::FloatingPoint::Model_Fortran)

add_library(Intel::FPModel_Fortran ALIAS
  shacl::cmake::Intel::FloatingPoint::Model_Fortran)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-model=$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
      "$<$<PLATFORM_ID:Windows>:/fp:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
    ">"
  ">")

target_compile_options(shacl::cmake::Intel::FloatingPoint::Model_Fortran
  INTERFACE ${generator})

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/FPModel.cmake
  DESTINATION share/cmake/shacl/.cmake/Intel)
