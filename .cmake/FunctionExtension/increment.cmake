cmake_minimum_required(VERSION 3.12.1)
macro(increment n)
  MATH(EXPR ${n} "${${n}}+1")
endmacro()
