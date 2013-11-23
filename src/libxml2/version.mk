NAME               = libxml2_$(ROLLCOMPILER)_py$(PYVERSION)
VERSION            = 2.9.1
RELEASE            = 0
RPM.EXTRAS         = "AutoReq: no"
PKGROOT            = /opt/scipy/$(PYVERSION)

SRC_SUBDIR         = libxml2

SOURCE_NAME        = libxml2
SOURCE_VERSION     = $(VERSION)
SOURCE_SUFFIX      = tar.gz
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS        = $(SOURCE_PKG)
