NAME               = cython_py$(PYVERSION)
VERSION            = 0.19.2
RELEASE            = 0
RPM.EXTRAS         = "AutoReq: no"
PKGROOT            = /opt/scipy/$(PYVERSION)

SRC_SUBDIR         = cython

SOURCE_NAME        = Cython
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
