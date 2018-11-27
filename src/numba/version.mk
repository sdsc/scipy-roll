ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLPY
  ROLLPY = python
endif

ifndef ROLLPYVERSION
  ROLLPYVERSION = 2.6
endif

NAME                   = sdsc-numba_py$(ROLLPYVERSION)
VERSION                = 0.35.0
RELEASE                = 3
PKGROOT                = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR             = numba

SOURCE_NAME            = numba
SOURCE_SUFFIX          = tar.gz
SOURCE_VERSION         = $(VERSION)
SOURCE_PKG             = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR             = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

SINGLEDISPATCH_NAME    = singledispatch
SINGLEDISPATCH_SUFFIX  = tar.gz
SINGLEDISPATCH_VERSION = 3.4.0.3
SINGLEDISPATCH_PKG     = $(SINGLEDISPATCH_NAME)-$(SINGLEDISPATCH_VERSION).$(SINGLEDISPATCH_SUFFIX)
SINGLEDISPATCH_DIR     = $(SINGLEDISPATCH_PKG:%.$(SINGLEDISPATCH_SUFFIX)=%)

TAR_GZ_PKGS            = $(SOURCE_PKG) $(SINGLEDISPATCH_PKG)

RPM.EXTRAS             = AutoReq:No\nObsoletes: numba_py$(ROLLPYVERSION)\n%define __os_install_post /usr/lib/rpm/brp-compress
RPM.PREFIX             = $(PKGROOT)
