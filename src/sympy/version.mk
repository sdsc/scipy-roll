ifndef ROLLPY
  ROLLPY = python
endif

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME           = sdsc-sympy_py$(PYVERSION)
VERSION        = 0.7.6.1
RELEASE        = 0
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = sympy

SOURCE_NAME    = sympy
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: sympy_py$(PYVERSION)
