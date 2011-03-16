////////////////////////////////////////////////////////////////////////////////
//  Copyright (c) 2011 Bryce Lelbach
//
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
////////////////////////////////////////////////////////////////////////////////

#if !defined(HPX_1CA2FF5A_2757_440C_8D2D_240A48191E63)
#define HPX_1CA2FF5A_2757_440C_8D2D_240A48191E63

#include <boost/cstdint.hpp>

extern "C" boost::uint64_t HPX_posix_x86_32_hardware_tick();

namespace hpx { namespace util { namespace hardware
{

inline boost::uint64_t tick() {
  return HPX_posix_x86_32_hardware_tick(); 
}

}}}

#endif // HPX_1CA2FF5A_2757_440C_8D2D_240A48191E63

