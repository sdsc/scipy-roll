ifndef ROLLPY
  ROLLPY = python
endif

ifndef ROLLPYVERSION
  ROLLPYVERSION = 2.7
endif

IPYTHON_PACKAGES = wcwidth-0.1.7 ptyprocess-0.6.0 ipython_genutils-0.2.0 prompt_toolkit-2.0.7 pathlib2-2.3.3 pexpect-4.6.0 pickleshare-0.7.5 decorator-4.3.0 Pygments-2.3.1 backports.shutil_get_terminal_size-1.0.0 traitlets-4.3.2 backcall-0.1.0


NAME               = sdsc-ipython_py$(ROLLPYVERSION)
VERSION            = 7.2.0
RELEASE            = 0
PKGROOT            = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR         = ipython

SOURCE_NAME        = ipython
SOURCE_SUFFIX      = tar.gz
SOURCE_VERSION     = $(VERSION)
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

$(IPYTHON_PACKAGES):
	$(eval PYTHON_PACKAGE  = $(shell echo $@ |sed 's/-[[:digit:]].[[:digit:]].[[:digit:]]\+//g'))
	$(eval PYTHON_PACKAGE_VERSION  = $(shell echo $@ | sed 's/$(PYTHON_PACKAGE)-//'))
	$(eval UPPER = $(shell echo $(PYTHON_PACKAGE) |tr a-z A-Z))
	$(eval $(UPPER)_NAME  = $(PYTHON_PACKAGE))
	$(eval $(UPPER)_SUFFIX = tar.gz)
	$(eval $(UPPER)_VERSION = $(PYTHON_PACKAGE_VERSION))
	$(eval $(UPPER)_PKG = $($(UPPER)_NAME)-$($(UPPER)_VERSION).$($(UPPER)_SUFFIX))
	$(eval $(UPPER)_DIR = $($(UPPER)_PKG:%.$($(UPPER)_SUFFIX)=%))
	$(eval IPYTHON_PKGS  += $($(UPPER)_PKG))
	$(eval IPYTHON_DIRS  += $($(UPPER)_DIR))
	echo "##### $(IPYTHON_DIRS) #####"


TAR_GZ_PKGS: $(IPYTHON_PACKAGES)

TAR_GZ_PKGS        = $(SOURCE_PKG)

RPM.EXTRAS         = AutoReq:No\nObsoletes: ipython_py$(ROLLPYVERSION)\n%global _python_bytecompile_errors_terminate_build 0
RPM.PREFIX         = $(PKGROOT)

