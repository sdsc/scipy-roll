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
RELEASE        = 2
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = scipy

SOURCE_NAME    = scipy
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

SOURCE_27_NAME    = scipy
SOURCE_27_SUFFIX  = tar.gz
SOURCE_27_VERSION = 1.2.2
SOURCE_27_PKG     = $(SOURCE_27_NAME)-$(SOURCE_27_VERSION).$(SOURCE_27_SUFFIX)
SOURCE_27_DIR     = $(SOURCE_27_PKG:%.$(SOURCE_27_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG) $(SOURCE_27_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: scipy_py$(ROLLPYVERSION)\n%global _python_bytecompile_errors_terminate_build 0
RPM.PREFIX     = $(PKGROOT)
