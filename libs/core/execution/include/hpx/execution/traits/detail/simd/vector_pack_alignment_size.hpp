//  Copyright (c) 2021 Srinivas Yadav
//  Copyright (c) 2016-2017 Hartmut Kaiser
//
//  SPDX-License-Identifier: BSL-1.0
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

#pragma once

#include <hpx/config.hpp>

#if defined(HPX_HAVE_DATAPAR_STD_EXPERIMENTAL_SIMD)
#include <cstddef>
#include <type_traits>

#include <experimental/simd>

///////////////////////////////////////////////////////////////////////////////
namespace hpx { namespace parallel { namespace traits {
    ///////////////////////////////////////////////////////////////////////////
    template <typename T>
    struct is_vector_pack<std::experimental::native_simd<T>> : std::true_type
    {
    };

    template <typename T>
    struct is_vector_pack<T> : std::false_type
    {
    };

    ///////////////////////////////////////////////////////////////////////////
    template <typename T>
    struct is_scalar_vector_pack<std::experimental::native_simd<T>>
      : std::false_type
    {
    };

    template <typename T>
    struct is_scalar_vector_pack<T> : std::true_type
    {
    };

    ///////////////////////////////////////////////////////////////////////////
    template <typename T, typename Enable>
    struct vector_pack_alignment
    {
        static std::size_t const value = sizeof(T);
    };

    template <typename T, typename Abi>
    struct vector_pack_alignment<std::experimental::simd<T, Abi>>
    {
        static std::size_t const value = std::experimental::memory_alignment_v<
            std::experimental::simd<T, Abi>>;
    };

    ///////////////////////////////////////////////////////////////////////////
    template <typename T, typename Enable>
    struct vector_pack_size
    {
        static std::size_t const value = 1;
    };

    template <typename T, typename Abi>
    struct vector_pack_size<std::experimental::simd<T, Abi>>
    {
        static std::size_t const value =
            std::experimental::simd<T, Abi>::size();
    };
}}}    // namespace hpx::parallel::traits

#endif
