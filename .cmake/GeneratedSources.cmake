include(Backports/IncludeGuard)
include_guard(GLOBAL)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

include(FunctionExtension)
include(GeneratedSources/ListBinaryDir)
include(GeneratedSources/stripped)
include(GeneratedSources/add_library)
include(GeneratedSources/add_executable)
include(GeneratedSources/target_sources)

