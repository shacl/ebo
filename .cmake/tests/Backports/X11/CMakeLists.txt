cmake_minimum_required( VERSION 3.2.0 )
project( test_find_package_x11 LANGUAGES CXX )
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../..")

include(Backports)

find_package( X11 REQUIRED )
