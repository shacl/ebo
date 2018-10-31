include(Backports/IncludeGuard)
include_guard(GLOBAL)

define_property(TARGET PROPERTY LINK_STACK_SIZE
  BRIEF_DOCS "minimum link-time stack size in bytes to be set by the linker"
  FULL_DOCS "minimum link-time stack size in bytes to be set by the linker"
)

add_library(LinkOptions_StackSize INTERFACE)
add_library(LinkOptions::StackSize ALIAS LinkOptions_StackSize)

include(LinkOptions/StackSize/GNU)
include(LinkOptions/StackSize/Intel)
include(LinkOptions/StackSize/PGI)
include(LinkOptions/StackSize/LLVM)
include(LinkOptions/StackSize/MSVC)
