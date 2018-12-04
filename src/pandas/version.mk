override ROLLCOMPILER = gnu
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLPY
  ROLLPY = python
endif

ifndef ROLLPYVERSION
  ROLLPYVERSION = 2.7
endif

NAME           = sdsc-pandas_py$(ROLLPYVERSION)
VERSION        = 0.23.4
RELEASE        = 0
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = pandas

SOURCE_NAME    = pandas
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: pandas_py$(ROLLPYVERSION)
RPM.PREFIX     = $(PKGROOT)
