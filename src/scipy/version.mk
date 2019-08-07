ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLPY
  ROLLPY = python
endif

ifndef ROLLPYVERSION
  ROLLPYVERSION = 2.7
endif

NAME           = sdsc-scipy_py$(ROLLPYVERSION)
VERSION        = 1.3.0
RELEASE        = 0
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = scipy

SOURCE_NAME    = scipy
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: scipy_py$(ROLLPYVERSION)\n%global _python_bytecompile_errors_terminate_build 0
RPM.PREFIX     = $(PKGROOT)
