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

NAME           = sdsc-d2to1_pytz_pyfits_stsci_py$(PYVERSION)
VERSION        = 0.6c11
RELEASE        = 4
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = setuptools_nose_pytz_pyfits

SOURCE_NAME    = d2to1
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = 0.2.11
SOURCE_PKG     = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

PYFITS_NAME    = pyfits
PYFITS_SUFFIX  = tar.gz
PYFITS_VERSION = 3.3
PYFITS_PKG     = $(PYFITS_NAME)-$(PYFITS_VERSION).$(PYFITS_SUFFIX)
PYFITS_DIR     = $(PYFITS_PKG:%.$(PYFITS_SUFFIX)=%)

PYTZ_NAME      = pytz
PYTZ_SUFFIX    = tar.gz
PYTZ_VERSION   = 2014.7
PYTZ_PKG       = $(PYTZ_NAME)-$(PYTZ_VERSION).$(PYTZ_SUFFIX)
PYTZ_DIR       = $(PYTZ_PKG:%.$(PYTZ_SUFFIX)=%)

STSCI_NAME     = stsci.distutils
STSCI_SUFFIX   = tar.gz
STSCI_VERSION  = 0.3.7
STSCI_PKG      = $(STSCI_NAME)-$(STSCI_VERSION).$(STSCI_SUFFIX)
STSCI_DIR      = $(STSCI_PKG:%.$(STSCI_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG) $(PYFITS_PKG) $(PYTZ_PKG) $(STSCI_PKG)

RPM.EXTRAS     = AutoReq:No
