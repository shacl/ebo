cmake_minimum_required(VERSION 3.12.1)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_FLOATING_POINT_SPECULATION
BRIEF_DOCS
"Intel Fortran floating point speculation model"
FULL_DOCS
"This property specifies the Intel floating-point speculation approach.
Options are: fast, safe, strict, off")

add_library(shacl::cmake::Intel::FloatingPoint::Speculation_C
  INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
add_library(Intel_FPSpeculation_C ALIAS
  shacl::cmake::Intel::FloatingPoint::Speculation_C)
add_library(Intel::FPSpeculation_C ALIAS
  shacl::cmake::Intel::FloatingPoint::Speculation_C)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>:"
    "$<$<STREQUAL:Intel,${CMAKE_C_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-speculation=$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>"
      "$<$<PLATFORM_ID:Windows>:/Qfp-speculation:$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>"
    ">"
  ">")

target_compile_options(shacl::cmake::Intel::FloatingPoint::Speculation_C
   INTERFACE ${generator})

add_library(shacl::cmake::Intel::FloatingPoint::Speculation_CXX
  INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
add_library(Intel_FPSpeculation_CXX ALIAS
  shacl::cmake::Intel::FloatingPoint::Speculation_CXX)

add_library(Intel::FPSpeculation_CXX ALIAS
  shacl::cmake::Intel::FloatingPoint::Speculation_CXX)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>:"
    "$<$<STREQUAL:Intel,${CMAKE_CXX_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-speculation=$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>"
      "$<$<PLATFORM_ID:Windows>:/Qfp-speculation:$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>"
    ">"
  ">")

target_compile_options(shacl::cmake::Intel::FloatingPoint::Speculation_CXX
  INTERFACE ${generator})

add_library(shacl::cmake::Intel::FloatingPoint::Speculation_Fortran
  INTERFACE IMPORTED GLOBAL)

# These aliases are provided for short term backwards compatability.
#
# Please don't not use in new work and update existing work to use the
# the imported target defined above as soon as reasonably possible.
#
add_library(Intel_FPSpeculation_Fortran ALIAS
  shacl::cmake::Intel::FloatingPoint::Speculation_Fortran)

add_library(Intel::FPSpeculation_Fortran ALIAS
  shacl::cmake::Intel::FloatingPoint::Speculation_Fortran)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-speculation=$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>"
      "$<$<PLATFORM_ID:Windows>:/Qfp-speculation:$<TARGET_PROPERTY:Intel_FLOATING_POINT_SPECULATION>>"
    ">"
  ">")

target_compile_options(shacl::cmake::Intel::FloatingPoint::Speculation_Fortran
  INTERFACE ${generator})

install(FILES
  ${CMAKE_CURRENT_LIST_DIR}/FPSpeculation.cmake
  DESTINATION share/cmake/shacl/.cmake/Intel)
