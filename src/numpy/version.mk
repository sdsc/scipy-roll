NAME               = numpy_$(ROLLCOMPILER)_py$(PYVERSION)
VERSION            = 1.8.0
RELEASE            = 0
RPM.EXTRAS         = "AutoReq: no"
PKGROOT            = /opt/scipy/$(PYVERSION)

SRC_SUBDIR         = numpy

SOURCE_NAME        = numpy
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
