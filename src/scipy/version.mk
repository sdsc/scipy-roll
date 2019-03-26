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
VERSION        = 1.1.0
RELEASE        = 1
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = scipy

SOURCE_NAME    = scipy
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

PYTEST_NAME    = pytest
PYTEST_SUFFIX  = tar.gz
PYTEST_VERSION = 3.8.2
PYTEST_PKG     = $(PYTEST_NAME)-$(PYTEST_VERSION).$(PYTEST_SUFFIX)
PYTEST_DIR     = $(PYTEST_PKG:%.$(PYTEST_SUFFIX)=%)


TAR_GZ_PKGS    = $(SOURCE_PKG) $(PYTEST_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: scipy_py$(ROLLPYVERSION)\n%global _python_bytecompile_errors_terminate_build 0
RPM.PREFIX     = $(PKGROOT)
