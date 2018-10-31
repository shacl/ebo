# shacl::ebo

## Introduction

> I made this letter longer only because I have not had the leisure to make it shorter.

When working with higher level functions in C++, object composition
is often times many levels deep. In some cases, the function objects
may have no state, and are referred to as empty classes. Niave
Ecomposition as member variables incur memory overhead; the footprint
of empty classes (one byte rounded up to the alignment requirement) cannot
be elided under composititon in C++14.

Ellision of this memory footprint is available by way of the
'empty base class optimization' or EBO, which is guaranteed as of
C++11. This optimization occurs when a class inherits from a base
class with no member variables.

Given an arbitrary object of type `T`, composition via EBO should be
preferred given `T` is a

+ a non-final class
+ with no member variables

This decision making is somewhat difficult in the case of multiple
composition in a generic context. Given `N` composition parameters,
there are `2^N` possible instantiations based on whether each parameter
is composed via EBO or as a member variable. The `shacl::ebo::Type`
class alias encapsulates this decision making for generic contexts.
