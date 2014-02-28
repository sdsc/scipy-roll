NAME               = setuptools_nose_pytz_pyfits_$(ROLLCOMPILER)_py$(PYVERSION)
VERSION            = 0.6c11
RELEASE            = 0
RPM.EXTRAS         = "AutoReq: no"
PKGROOT            = /opt/scipy/$(PYVERSION)

SRC_SUBDIR         = setuptools_nose_pytz_pyfits

SOURCE_SUFFIX      = tar.gz

NOSE_NAME          = nose
NOSE_VERSION       = 1.3.0
NOSE_PKG           = $(NOSE_NAME)-$(NOSE_VERSION).$(SOURCE_SUFFIX)
NOSE_DIR           = $(NOSE_PKG:%.$(SOURCE_SUFFIX)=%)

PYFITS_NAME        = pyfits
PYFITS_VERSION     = 3.2
PYFITS_PKG         = $(PYFITS_NAME)-$(PYFITS_VERSION).$(SOURCE_SUFFIX)
PYFITS_DIR         = $(PYFITS_PKG:%.$(SOURCE_SUFFIX)=%)

PYTZ_NAME          = pytz
PYTZ_VERSION       = 2013.9
PYTZ_PKG           = $(PYTZ_NAME)-$(PYTZ_VERSION).$(SOURCE_SUFFIX)
PYTZ_DIR           = $(PYTZ_PKG:%.$(SOURCE_SUFFIX)=%)

SETUPTOOLS_NAME     = setuptools
SETUPTOOLS_VERSION  = 0.6c11
SETUPTOOLS_PKG      = $(SETUPTOOLS_NAME)-$(SETUPTOOLS_VERSION).$(SOURCE_SUFFIX)
SETUPTOOLS_DIR      = $(SETUPTOOLS_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(NOSE_PKG) $(PYFITS_PKG) $(PYTZ_PKG) $(SETUPTOOLS_PKG)

