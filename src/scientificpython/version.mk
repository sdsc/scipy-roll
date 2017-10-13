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

NAME           = sdsc-scientificpython_py$(PYVERSION)
VERSION        = 2.9.4
RELEASE        = 6
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = scientificpython

SOURCE_NAME    = ScientificPython
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: scientificpython_py$(PYVERSION)
RPM.PREFIX     = $(PKGROOT)
