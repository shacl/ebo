include(Backports/IncludeGuard)
include_guard(GLOBAL)

add_library(Fortran_NoBackslashEscape INTERFACE)
add_library(Fortran::NoBackslashEscape ALIAS Fortran_NoBackslashEscape)

include(Fortran/NoBackslashEscape/Flang)
include(Fortran/NoBackslashEscape/PGI)
