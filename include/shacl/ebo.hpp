#ifndef SHACL_EBO_HPP
#define SHACL_EBO_HPP

#include "shacl/trait.hpp"

#include <type_traits>

namespace shacl {
namespace ebo {

template<int i>
using Index = std::integral_constant<int, i>;

template<int i>
static constexpr Index<i> index{};

namespace detail {

template<typename T>
static constexpr bool shouldInherit =
  std::is_empty<T>::value and not std::is_final<T>::value;

template<typename... Ts>
struct Implementation;

template<>
struct Implementation<>{
  template<typename...>
  struct type {
    constexpr type() = default;
    constexpr auto operator==(const type&) const { return true; }
    constexpr auto operator!=(const type&) const { return false; }
  };
};

template<typename T, typename... Ts>
struct Implementation<T, Ts...> {
  using Recursion = typename Implementation<Ts...>::template type<>;

  /**
   * Why is there an unused type in this template?
   * =============================================
   *
   * Within the context of a class template definition (in this case the
   * `Implementation` class template), a nested template (e.g.,
   * `Implementation`'s nested `type` class template) may not be fully
   * specialized. To work around this limitation, we introduce an
   * additional (unused) template parmeter and partially specialize.
   *
   **/
  template<typename = void, bool = shouldInherit<T>>
  class type;

  template<typename dummy>
  class type<dummy, true> : Recursion, T {
  public:
    template<typename Arg,
             typename... Args,
             std::enable_if_t
             <std::is_constructible<T, Arg>::value
              and std::is_constructible<Recursion, Args...>::value,
              bool> = true>
    constexpr type(Arg&& arg, Args&&... args)
    noexcept(std::is_nothrow_constructible<T, Arg>::value
             and std::is_nothrow_constructible<Recursion, Args...>::value) :
                 Recursion(std::forward<Args>(args)...),
      T(std::forward<Arg>(arg)){}

    constexpr T& get(Index<0>) & noexcept {
      return *this;
    }

    constexpr const T& get(Index<0>) const & noexcept {
      return *this;
    }

    constexpr T&& get(Index<0>) &&  noexcept {
      return std::move(*this);
    }

    constexpr const T&& get(Index<0>) const &&  noexcept {
      return std::move(*this);
    }

    /**
     * This method calls into a method that doesn't exist in the base case.
     *
     * Why does this compile?
     * =======================
     *
     * Note that member functions for class templates are only generated
     * if they're used. As such, the nested `type` class of the single
     * parameter instantiation of `Implementation` need not define this
     * method, so long as the function is not invoked.
     *
     **/
    template<int i>
    constexpr decltype(auto) get(Index<i>) & noexcept {
      return Recursion::get(index<i - 1>);
    }

    template<int i>
    constexpr decltype(auto) get(Index<i>) const & noexcept {
      return Recursion::get(index<i - 1>);
    }

    template<int i>
    constexpr decltype(auto) get(Index<i>) && noexcept {
      return static_cast<Recursion&&>(*this).get(index<i - 1>);
    }

    template<int i>
    constexpr decltype(auto) get(Index<i>) const && noexcept {
      return static_cast<Recursion&&>(*this).get(index<i - 1>);
    }

    template<typename R = Recursion,
             std::enable_if_t<trait::EqualityComparable_v<R>, bool> = true>
    constexpr bool operator==(const type& other) const {
      return
        static_cast<const R&>(*this) == static_cast<const R&>(other);
    }

    template<typename U = Recursion,
             std::enable_if_t<trait::EqualityComparable_v<U>, bool> = true>
    constexpr bool operator!=(const type& other) const {
      return not (*this == other);
    }
  };

  template<typename dummy>
  class type<dummy, false> : Recursion {
    T t;

  public:
    template<typename Arg, typename... Args,
             std::enable_if_t
             <std::is_constructible<T, Arg>::value
              and std::is_constructible<Recursion, Args...>::value,
              bool> = true>
    constexpr type(Arg&& arg, Args&&... args)
    noexcept(std::is_nothrow_constructible<T, Arg>::value
             and std::is_nothrow_constructible<Recursion, Args...>::value) :
      Recursion(std::forward<Args>(args)...),
      t(std::forward<Arg>(arg)){}

    constexpr T& get(Index<0>) & noexcept { return this->t; }
    constexpr const T& get(Index<0>) const & noexcept { return this->t; }
    constexpr T&& get(Index<0>) && noexcept { return std::move(this->t); }
    constexpr const T&& get(Index<0>) const && noexcept { return std::move(this->t); }

    template<int i>
    constexpr decltype(auto) get(Index<i>) & noexcept {
      return Recursion::get(index<i - 1>);
    }

    template<int i>
    constexpr decltype(auto) get(Index<i>) const & noexcept {
      return Recursion::get(index<i - 1>);
    }

    template<int i>
    constexpr decltype(auto) get(Index<i>) && noexcept {
      return static_cast<Recursion&&>(*this).get(index<i - 1>);
    }

    template<int i>
    constexpr decltype(auto) get(Index<i>) const && noexcept {
      return static_cast<const Recursion&&>(*this).get(index<i - 1>);
    }

    template<typename R = Recursion,
             std::enable_if_t<trait::EqualityComparable_v<R>
                              and std::is_empty<T>::value, bool> = true>
    bool operator==(const type& other) const {
      return
        static_cast<const R&>(*this) == static_cast<const R&>(other);
    }

    template<typename R = Recursion,
             std::enable_if_t<trait::EqualityComparable_v<R>
                              and not std::is_empty<T>::value
                              and trait::EqualityComparable_v<T>, bool> = true>
    bool operator==(const type& other) const {
      return
        static_cast<const R&>(*this) == static_cast<const R&>(other)
        and this->get(index<0>) == other.get(index<0>);
    }

    template<typename U = Recursion,
             std::enable_if_t<trait::EqualityComparable_v<U>
                              and (trait::EqualityComparable_v<T>
                                   or std::is_empty<T>::value), bool> = true>
    bool operator!=(const type& other) const {
      return not (*this == other);
    }
  };
};

} // namespace detail


template<typename T, typename... Ts>
using Type = typename detail::Implementation<T, Ts...>::template type<>;

} // namespace ebo
} // namespace shacl

#endif // #indef SHACL_EBO_HPP
