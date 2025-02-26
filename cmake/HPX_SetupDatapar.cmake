# Copyright (c) 2022 Srinivas Yadav
#
# SPDX-License-Identifier: BSL-1.0
# Distributed under the Boost Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

# ##############################################################################
# HPX datapar configuration
# ##############################################################################
set(DATAPAR_BACKEND "NONE")
hpx_option(
  HPX_WITH_DATAPAR_BACKEND
  STRING
  "Define which vectorization library should be used. Options are: VC, EVE, STD_EXPERIMENTAL_SIMD, NONE"
  ${DATAPAR_BACKEND}
  STRINGS "VC;EVE;STD_EXPERIMENTAL_SIMD;NONE"
)
include(HPX_AddDefinitions)

# ##############################################################################
# HPX Vc configuration
# ##############################################################################
if("${HPX_WITH_DATAPAR_BACKEND}" STREQUAL "VC")
  hpx_option(
    HPX_WITH_DATAPAR_VC_NO_LIBRARY BOOL
    "Don't link with the Vc static library (default: OFF)" OFF ADVANCED
  )
  hpx_warn(
    "Vc support is deprecated. This option will be removed in a future release. It will be replaced with SIMD support from the C++ standard library"
  )

  include(HPX_SetupVc)
  hpx_option(
    HPX_WITH_DATAPAR BOOL
    "Enable data parallel algorithm support using Vc library (default: ON)" ON
    ADVANCED
  )
  hpx_add_config_define(HPX_HAVE_DATAPAR)
  hpx_add_config_define(HPX_HAVE_DATAPAR_VC)
endif()

# ##############################################################################
# HPX Eve configuration
# ##############################################################################
if("${HPX_WITH_DATAPAR_BACKEND}" STREQUAL "EVE")
  hpx_option(
    HPX_WITH_FETCH_EVE
    BOOL
    "Use FetchContent to fetch Eve. By default an installed Eve will be used. (default: OFF)"
    OFF
    CATEGORY "Build Targets"
    ADVANCED
  )
  hpx_option(
    HPX_WITH_EVE_TAG STRING "Eve repository tag or branch" "v2022.03.0"
    CATEGORY "Build Targets"
    ADVANCED
  )

  if(HPX_WITH_FETCH_EVE)
    include(HPX_SetupEve)
  else()
    find_package(Eve)
  endif()
  hpx_option(
    HPX_WITH_DATAPAR BOOL
    "Enable data parallel algorithm support using Eve library (default: ON)" ON
    ADVANCED
  )
  hpx_add_config_define(HPX_HAVE_DATAPAR_EVE)
  hpx_add_config_define(HPX_HAVE_DATAPAR)
endif()

# ##############################################################################
# HPX STD_EXPERIMENTAL_SIMD configuration
# ##############################################################################
if("${HPX_WITH_DATAPAR_BACKEND}" STREQUAL "STD_EXPERIMENTAL_SIMD")
  if(HPX_WITH_CXX20_EXPERIMENTAL_SIMD)
    hpx_option(
      HPX_WITH_DATAPAR
      BOOL
      "Enable data parallel algorithm support using std experimental/simd (default: ON)"
      ON
      ADVANCED
    )
    hpx_add_config_define(HPX_HAVE_DATAPAR_STD_EXPERIMENTAL_SIMD)
    hpx_add_config_define(HPX_HAVE_DATAPAR)
  else()
    hpx_error(
      "Could not find std experimental/simd. Use CXX COMPILER GCC 11 OR CLANG 12 AND ABOVE "
    )
  endif()
endif()

if(HPX_WITH_DATAPAR)
  hpx_info("Using datapar backend: ${HPX_WITH_DATAPAR_BACKEND}")
endif()
