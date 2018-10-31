string(CONCAT generator
  "$<$<OR:$<AND:$<STREQUAL:Fortran,$<TARGET_PROPERTY:LINKER_LANGUAGE>>,"
               "$<STREQUAL:GNU,${CMAKE_Fortran_COMPILER_ID}>>,"
         "$<AND:$<STREQUAL:C,$<TARGET_PROPERTY:LINKER_LANGUAGE>>,"
                "$<C_COMPILER_ID:GNU>>,"
         "$<AND:$<STREQUAL:CXX,$<TARGET_PROPERTY:LINKER_LANGUAGE>>,"
                "$<CXX_COMPILER_ID:GNU>>>:"
    "$<$<BOOL:$<TARGET_PROPERTY:LINK_STACK_SIZE>>:"
      "$<$<OR:$<PLATFORM_ID:Darwin>,$<PLATFORM_ID:CYGWIN>>:-Wl$<COMMA>"
        "$<$<PLATFORM_ID:Darwin>:-stack_size$<COMMA>>"
        "$<$<PLATFORM_ID:CYGWIN>:--stack$<COMMA>>"
        "$<TARGET_PROPERTY:LINK_STACK_SIZE>"
      ">"
    ">"
  ">"
)

target_link_libraries(LinkOptions_StackSize INTERFACE ${generator})
