list(APPEND CTEST_CUSTOM_COVERAGE_EXCLUDE
  ".*catch.*"
  ".*test.*"
  ".*c[+][+]"
  ".*shacl/trait.*hpp")

list(APPEND CTEST_EXTRA_COVERAGE_GLOB ".*shacl/ebo.*hpp")
