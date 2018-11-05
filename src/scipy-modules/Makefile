REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

$(VERSION_INC): $(VERSION_SRC)
	/bin/echo VERSION = $(firstword  $(PYVERSION)) > $@
 
build:

install:: scipy-modulefile-install

clean::
	rm -f $(VERSION_INC)

scipy-modulefile-install:
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	for V in $(PYVERSION); do \
          cp *.module $(ROOT)/$(PKGROOT)/$$V; \
          cp *.version $(ROOT)/$(PKGROOT)/.version.$$V; \
          perl -pi -e 's#COMPILERNAME#$(COMPILERNAME)#g;' \
                   -e 's#MPINAME#$(MPINAME)#g;' \
                   -e 's#ROLLCOMPILER#$(ROLLCOMPILER)#g;' \
                   -e 's#ROLLMPI#$(ROLLMPI)#g;' \
                   -e 's#ROLLOPTS#$(ROLLOPTS)#g;' \
                   -e 's#ROLLPY#$(ROLLPY)#g;' \
                   -e "s#VERSION#$$V#g;" \
            $(ROOT)/$(PKGROOT)/.version.$$V $(ROOT)/$(PKGROOT)/$$V; \
        done

