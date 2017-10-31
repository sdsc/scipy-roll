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

NAME           = sdsc-llvmlite_py$(PYVERSION)
VERSION        = 0.20.0
RELEASE        = 0
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = llvmlite

SOURCE_NAME    = llvmlite
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

ENUM34_NAME    = enum34
ENUM34_SUFFIX  = tar.gz
ENUM34_VERSION = 1.1.6
ENUM34_PKG     = $(ENUM34_NAME)-$(ENUM34_VERSION).$(ENUM34_SUFFIX)
ENUM34_DIR     = $(ENUM34_PKG:%.$(ENUM34_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG) $(ENUM34_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: llvmlite_py$(PYVERSION)
RPM.PREFIX     = $(PKGROOT)
