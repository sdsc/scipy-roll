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

NAME           = sdsc-matplotlib_py$(ROLLPYVERSION)
VERSION        = 3.0.2
RELEASE        = 0
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = matplotlib

SOURCE_NAME    = matplotlib
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

CYCLER_NAME    = cycler
CYCLER_SUFFIX  = tar.gz
CYCLER_VERSION = 0.10.0
CYCLER_PKG     = $(CYCLER_NAME)-$(CYCLER_VERSION).$(CYCLER_SUFFIX)
CYCLER_DIR     = $(CYCLER_PKG:%.$(CYCLER_SUFFIX)=%)

KIWISOLVER_NAME    = kiwisolver
KIWISOLVER_SUFFIX  = tar.gz
KIWISOLVER_VERSION = 1.0.1
KIWISOLVER_PKG     = $(KIWISOLVER_NAME)-$(KIWISOLVER_VERSION).$(KIWISOLVER_SUFFIX)
KIWISOLVER_DIR     = $(KIWISOLVER_PKG:%.$(KIWISOLVER_SUFFIX)=%)


TAR_GZ_PKGS    = $(SOURCE_PKG) $(CYCLER_PKG) $(KIWISOLVER_PKG)

RPM.EXTRAS     = AutoReq:No\nObsoletes: matplotlib_py$(ROLLPYVERSION)\n%global _python_bytecompile_errors_terminate_build 0
RPM.PREFIX     = $(PKGROOT)
