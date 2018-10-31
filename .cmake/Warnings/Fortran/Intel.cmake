add_library(warnings_Fortran_Intel INTERFACE)

string(CONCAT generator
  "$<$<PLATFORM_ID:Windows>:/warn:>"
  "$<$<NOT:$<PLATFORM_ID:Windows>>:-warn;>")

string(CONCAT generator
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>"
   ":${generator}error$<COMMA>stderror"
   ">"
  "$<$<BOOL:$<TARGET_PROPERTY:WARN_ALL>>"
   ":$<$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>:$<COMMA>>"
    "$<$<NOT:$<BOOL:$<TARGET_PROPERTY:WARN_ERROR>>>:${generator}>"
     "all"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_ENABLED_WARNINGS>>"
   ":$<$<PLATFORM_ID:Windows>:/Qdiag-enable:>"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:-diag-enable=>"
    "$<JOIN:$<TARGET_PROPERTY:Intel_ENABLED_WARNINGS>,$<COMMA>>"
   ">;"
  "$<$<BOOL:$<TARGET_PROPERTY:Intel_DISABLED_WARNINGS>>"
   ":$<$<PLATFORM_ID:Windows>:/Qdiag-disable:>"
    "$<$<NOT:$<PLATFORM_ID:Windows>>:-diag-disable=>"
    "$<JOIN:$<TARGET_PROPERTY:Intel_DISABLED_WARNINGS>,$<COMMA>>"
   ">;")

target_compile_options(Warnings_Fortran INTERFACE
  $<$<STREQUAL:${CMAKE_Fortran_COMPILER_ID},Intel>:${generator}>)
