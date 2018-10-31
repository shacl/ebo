include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY Fortran_BACKTRACE
BRIEF_DOCS
"Toggle backtrace information in Fortran programs"
FULL_DOCS
"This functionality is not universally supported amongst Fortran 
 compilers. This property provides an interface to that functionality
 if available.")

add_library(Fortran_Backtrace INTERFACE)
add_library(Fortran::Backtrace ALIAS Fortran_Backtrace)

include(Fortran/Backtrace/Intel)
include(Fortran/Backtrace/PGI)
include(Fortran/Backtrace/GNU)
# traceback with Flang is default
