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

NAME           = sdsc-libxml2_py$(ROLLPYVERSION)
VERSION        = 2.9.3
RELEASE        = 5
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = libxml2

SOURCE_NAME    = libxml2
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: libxml2_py$(ROLLPYVERSION)
RPM.PREFIX     = $(PKGROOT)
