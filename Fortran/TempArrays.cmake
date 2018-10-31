include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_TEMP_ARRAY_THRESHOLD
  BRIEF_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
  FULL_DOCS
  "A threshold (in kilobytes) above which temporary and automatic arrays should be heap allocated"
)

add_library(Fortran_TempArrays INTERFACE)

include(Fortran/TempArrays/GNU)
# include(Fortran/TempArrays/Flang) # not implemented as of 20180716
include(Fortran/TempArrays/Intel)
include(Fortran/TempArrays/PGI)

add_library(Fortran::TempArrays ALIAS Fortran_TempArrays)
