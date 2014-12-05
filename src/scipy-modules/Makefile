REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

$(VERSION_INC): $(VERSION_SRC)
	/bin/echo VERSION = $(PYVERSION) > $@
 
build:

install:: typical-modulefile-install
	perl -pi -e 's#PYVER#$(PYVERSION)#g' $(ROOT)/$(PKGROOT)/*

clean::
	rm -f $(VERSION_INC)
