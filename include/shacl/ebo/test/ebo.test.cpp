#define CATCH_CONFIG_MAIN
#include <iostream>
#include "shacl/ebo.hpp"
#include "catch2/catch.hpp"

struct Empty {};
struct AlsoEmpty {};
struct NontrivialEmpty {
  ~NontrivialEmpty(){}
};

struct Final final {};
struct NonEmpty{
  int data;
  //bool operator==(const NonEmpty&) const = delete;
};

struct NonEmptyEqualityComparable{
  int data;
  bool operator==(const NonEmpty& other) const {
    return this->data == other.data;
  }

  bool operator!=(const NonEmpty& other) const {
    return this->data != other.data;
  }
};

SCENARIO("Automated Empty base class optimization with multiple inheritance"){
  GIVEN("a single class"){
    GIVEN("the class is Empty and trivially destructible"){
      using Type = shacl::ebo::Type<Empty>;

      THEN("the resulting type will be empty"){
        REQUIRE(std::is_empty<Type>::value);
      }

      THEN("the resulting type will be equality comparable"){
        REQUIRE(shacl::trait::EqualityComparable_v<Type>);
      }

      THEN("the resulting type will be the size of the parameter type"){
        REQUIRE(sizeof(Type) == sizeof(Empty));
      }

      THEN("an instance provides access to an instance of the parameter class"){
        WHEN("instance is an lvalue"){
          const auto instance = Type{Empty{}};
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const Empty&>::value);
        }

        WHEN("instance is an rvalue"){
          auto instance = Type{Empty{}};
          using GetResult_t =
            decltype(std::move(instance).get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, Empty&&>::value);
        }
      }
    }

    GIVEN("the class is Empty and not trivially destructible"){
      using Type = shacl::ebo::Type<NontrivialEmpty>;
      static_assert(not std::is_trivially_destructible<NontrivialEmpty>::value, "");
      THEN("the resulting type type will be empty"){
        REQUIRE(std::is_empty<Type>::value);
      }

      THEN("the resulting type will be equality comparable"){
        REQUIRE(shacl::trait::EqualityComparable_v<Type>);
      }

      THEN("the resulting type will be the size of the parameter type"){
        REQUIRE(sizeof(Type) == sizeof(NontrivialEmpty));
      }

      THEN("an instance provides access to an instance of the parameter class"){
        WHEN("instance is an lvalue"){
          const auto instance = Type{NontrivialEmpty{}};
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const NontrivialEmpty&>::value);
        }

        WHEN("instance is an rvalue"){
          auto instance = Type{NontrivialEmpty{}};
          using GetResult_t =
            decltype(std::move(instance).get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, NontrivialEmpty&&>::value);
        }
      }
    }

    GIVEN("the class is NonEmpty but not equality comparable"){
      using Type = shacl::ebo::Type<NonEmpty>;

      THEN("the resulting type type will be not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be equality comparable"){
        REQUIRE(not shacl::trait::EqualityComparable_v<Type>);
      }

      THEN("the resulting type will be the size of the parameter type"){
        REQUIRE(sizeof(Type) == sizeof(NonEmpty));
      }

      THEN("an instance provides access to an instance of the parameter class"){
        WHEN("instance is an lvalue"){
          const auto instance = Type{NonEmpty{5}};
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const NonEmpty&>::value);
          REQUIRE(instance.get(shacl::ebo::index<0>).data == 5);
        }

        WHEN("instance is an rvalue"){
          auto instance = Type{NonEmpty{5}};
          using GetResult_t =
            decltype(std::move(instance).get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, NonEmpty&&>::value);
          REQUIRE(std::move(instance).get(shacl::ebo::index<0>).data == 5);
        }
      }
    }

    GIVEN("the class is final and empty"){
      using Type = shacl::ebo::Type<Final>;

      THEN("the resulting type type will not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be equality comparable"){
        REQUIRE(shacl::trait::EqualityComparable_v<Type>);
      }

      THEN("the resulting type will be the size of the parameter type"){
        REQUIRE(sizeof(Type) == sizeof(Final));
      }

      THEN("an instance provides access to an instance of the parameter class"){
        WHEN("instance is an lvalue"){
          const auto instance = Type{Final{}};
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const Final&>::value);
        }

        WHEN("instance is an rvalue"){
          auto instance = Type{Final{}};
          using GetResult_t =
            decltype(std::move(instance).get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, Final&&>::value);
        }
      }
    }
  }

  GIVEN("multiple classes"){
    GIVEN("all classes NonEmpty"){
      using Type = shacl::ebo::Type<NonEmpty, NonEmpty>;

      THEN("the resulting type type will not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size"
           " of the sum of the (non-empty) parameter type sizes"){
        REQUIRE(2 * sizeof(NonEmpty) == sizeof(Type));
      }

      THEN("an instance provides access to an instance of the parameter classes"){
        auto instance = Type{NonEmpty{5}, NonEmpty{10}};

        WHEN("querying for the first type"){
          WHEN("instance is an lvalue"){
            using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
            REQUIRE(std::is_same<GetResult_t, NonEmpty&>::value);
            REQUIRE(instance.get(shacl::ebo::index<0>).data == 5);
          }

          WHEN("instance is an rvalue"){
            using GetResult_t =
              decltype(std::move(instance).get(shacl::ebo::index<0>));
            REQUIRE(std::is_same<GetResult_t, NonEmpty&&>::value);
            REQUIRE(std::move(instance).get(shacl::ebo::index<0>).data == 5);
          }
        }

        WHEN("querying for the second type"){
          WHEN("instance is an lvalue"){
            using GetResult_t = decltype(instance.get(shacl::ebo::index<1>));
            REQUIRE(std::is_same<GetResult_t, NonEmpty&>::value);
            REQUIRE(instance.get(shacl::ebo::index<1>).data == 10);
          }

          WHEN("instance is an rvalue"){
            using GetResult_t =
              decltype(std::move(instance).get(shacl::ebo::index<1>));
            REQUIRE(std::is_same<GetResult_t, NonEmpty&&>::value);
            REQUIRE(std::move(instance).get(shacl::ebo::index<1>).data == 10);
          }
        }
      }
    }

    GIVEN("one class empty and one class non-empty"){
      using Type = shacl::ebo::Type<NonEmpty, Empty>;

      THEN("the resulting type type will not be empty"){
        REQUIRE(not std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size"
           " of the sum of the (non-empty) parameter type sizes"){
        REQUIRE(sizeof(NonEmpty) == sizeof(Type));
      }

      THEN("an instance provides access to an instance of the parameter classes"){
        const auto instance = Type{NonEmpty{5}, Empty{}};

        WHEN("querying for the first type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const NonEmpty&>::value);
          REQUIRE(instance.get(shacl::ebo::index<0>).data == 5);
        }

        WHEN("querying for the second type"){
          WHEN("instance is an lvalue"){
            using GetResult_t = decltype(instance.get(shacl::ebo::index<1>));
            REQUIRE(std::is_same<GetResult_t, const Empty&>::value);
          }

          WHEN("instance is an rvalue"){
            using GetResult_t = decltype(std::move(instance).get(shacl::ebo::index<1>));
            REQUIRE(std::is_same<GetResult_t, const Empty&&>::value);
          }
        }
      }
    }

    GIVEN("one class empty and one class non-empty"){
      using Type = shacl::ebo::Type<Empty, AlsoEmpty>;

      THEN("the resulting type type will be empty"){
        REQUIRE(std::is_empty<Type>::value);
      }

      THEN("the resulting type will be the size that of an empty type"){
        REQUIRE(sizeof(Empty) == sizeof(Type));
      }

      THEN("an instance provides access to an instance of the parameter classes"){
        const auto instance = Type{Empty{}, AlsoEmpty{}};

        WHEN("querying for the first type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<0>));
          REQUIRE(std::is_same<GetResult_t, const Empty&>::value);
        }

        WHEN("querying for the second type"){
          using GetResult_t = decltype(instance.get(shacl::ebo::index<1>));
          REQUIRE(std::is_same<GetResult_t, const AlsoEmpty&>::value);
        }
      }
    }
  }
}
