shacl::ebo
==================

## Introduction ##

> I made this letter longer only because I have not had the leisure to make it shorter.

When working with higher level functions in C++, object composition
can be many levels deep. In some cases, the function objects
may have no state, and are referred to as empty classes. Captureless lambda
objects are a example of this circumstance common in practice. Composition of
instances of these classes as member variables incur memory overhead, despite
the fact that these objects store no data.

## Why? ##

The memory footprint of an instance of an empty classes is not permitted to be
less than one byte, prior to C++20. This restriction is a consequence of the
language's lineage from C.

The C standard mandates that a conforming implementation may not introduce
padding between consecutive elements of an array. If an object were allowed
to occupy zero bytes in memory, consecutive elements of an array of an empty
type would reside at the same location in memory. This possibility is
problematic given the iteration conventions in the language, which assume
the addresses to the beginning and (exclusive) end of an array are distinct.

## How does this effect me? ##

The introduction of a byte of memory may seem inconsequential. However, in the
context of object composition, when considered with the memory footprint
introduced by alignment requirements (which, as an aside, is also a consequence
of the aforementioned C mandate), the effect can be substantial.

Consider the following example:

```c++
#include <iostream>
#include <cstdint>

struct A {};
struct B { std::int64_t data; };
struct C {};

struct Composite {
  A a;
  B b;
  C c;
};

int main(){
  std::cout << "A size: " << sizeof(A) << '\n'
            << "B size: " << sizeof(B) << '\n'
            << "C size: " << sizeof(C) << '\n' << '\n'
            << "Composite size: " << sizeof(Composite) << '\n';
}
```

This program has the following output:

```
A size: 1
B size: 8
C size: 1

Composite size: 24
```

Ellision of this memory footprint is available by way of the
'empty base class optimization' or EBO, which is guaranteed as of
C++11. This optimization occurs when a class inherits from a base
class with no member variables. Rewriting the previous example,
we can see that, by leveraging EBO, the overhead of the empty classes
`A` and `C` are eliminated entirely.

```c++
#include <iostream>
#include <cstdint>

struct A {};
struct B { std::int64_t data; };
struct C {};

struct Composite : A, C {
  B b;
};

int main(){
  std::cout << "A size: " << sizeof(A) << '\n'
            << "B size: " << sizeof(B) << '\n'
            << "C size: " << sizeof(C) << '\n' << '\n'
            << "Composite size: " << sizeof(Composite) << '\n';
}
```

This program has the following output:

```
A size: 1
B size: 8
C size: 1

Composite size: 8
```

Given an arbitrary object of type `T`, composition via EBO should be
preferred given `T` is a

+ a non-final class
+ with no member variables

This decision making is somewhat difficult in the case of multiple
composition in a generic context. Given `N` composition parameters,
there are `2^N` possible instantiations based on whether each parameter
is composed via EBO or as a member variable. The `shacl::ebo::Type`
class alias encapsulates this decision-making for generic contexts.
