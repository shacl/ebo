include(Backports/IncludeGuard)
include_guard(GLOBAL)

include(Fortran/NoBackslashEscape)
include(Intel/FortranAssumptions)

add_library(Fortran_StandardAdherence INTERFACE)
add_library(Fortran::StandardAdherence ALIAS Fortran_StandardAdherence)

target_link_libraries(Fortran_StandardAdherence INTERFACE
  Fortran::NoBackslashEscape
  Intel::FortranStandardAdherence)

