ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLPY
  ROLLPY = python
endif

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME           = sdsc-libxml2_py$(PYVERSION)
VERSION        = 2.9.2
RELEASE        = 1
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = libxml2

SOURCE_NAME    = libxml2
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No

RPM.EXTRAS  = Obsoletes: libxml2_py$(PYVERSION)
