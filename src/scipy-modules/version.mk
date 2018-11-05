PACKAGE     = scipy
CATEGORY    = applications

NAME        = sdsc-$(PACKAGE)-modules_py$(PYVERSION)
RELEASE     = 13
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)

VERSION_SRC = $(REDHAT.ROOT)/src/$(PACKAGE)/version.mk
VERSION_INC = version.inc
include $(VERSION_INC)

RPM.EXTRAS  = AutoReq:No\nObsoletes: $(PACKAGE)-modules_py$(PYVERSION)
RPM.PREFIX  = $(PKGROOT)
