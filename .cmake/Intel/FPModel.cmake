include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Intel_FLOATING_POINT_MODEL
BRIEF_DOCS
"Intel Fortran floating point model"
FULL_DOCS
"This property specifies the Intel floating-point model to apply.
Options are: precise, fast[=1|2], consistent, strict, source"
)

add_library(Intel_FPModel_C INTERFACE)
add_library(Intel::FPModel_C ALIAS Intel_FPModel_C)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>:"
    "$<$<STREQUAL:Intel,${CMAKE_C_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-model;$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
      "$<$<PLATFORM_ID:Windows>:/fp:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
    ">"
  ">"
)

target_compile_options(Intel_FPModel_C INTERFACE ${generator})

add_library(Intel_FPModel_CXX INTERFACE)
add_library(Intel::FPModel_CXX ALIAS Intel_FPModel_CXX)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>:"
    "$<$<STREQUAL:Intel,${CMAKE_CXX_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-model;$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
      "$<$<PLATFORM_ID:Windows>:/fp:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
    ">"
  ">"
)

target_compile_options(Intel_FPModel_CXX INTERFACE ${generator})

add_library(Intel_FPModel_Fortran INTERFACE)
add_library(Intel::FPModel_Fortran ALIAS Intel_FPModel_Fortran)

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>:"
    "$<$<STREQUAL:Intel,${CMAKE_Fortran_COMPILER_ID}>:"
      "$<$<NOT:$<PLATFORM_ID:Windows>>:-fp-model;$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
      "$<$<PLATFORM_ID:Windows>:/fp:$<TARGET_PROPERTY:Intel_FLOATING_POINT_MODEL>>"
    ">"
  ">"
)

target_compile_options(Intel_FPModel_Fortran INTERFACE ${generator})
