#
# $Id$
#
# @Copyright@
#
#                               Rocks(r)
#                        www.rocksclusters.org
#                        version 7.0 (Manzanita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
#       "This product includes software developed by the Rocks(r)
#       Cluster Group at the San Diego Supercomputer Center at the
#       University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@
#


REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk
.PHONY: $(JUPYTER_PACKAGES)

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_PYTHON); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_PYTHON) \
	) > $@


LICENSE: jupyterdownload
	for F in $(JUPYTER_NAMES); do \
           if test -e $${F}-*/LICENSE; then \
               cp $${F}-*/LICENSE $(SOURCE_DIR)/$$F-LICENSE; \
           fi; \
           if test -e $${F}-*/PKG-INFO; then \
               cp $${F}-*/PKG-INFO $(SOURCE_DIR)/$$F-PKG-INFO; \
           fi; \
        done
	$(CHECK_LICENSE_FILES)
	echo Python and BSD and MIT > $@



CACHE_DIR=$(REDHAT.ROOT)/cache

jupyterdownload : $(JUPYTER_PACKAGES)
	for PYTHON_PACKAGE in $(JUPYTER_PKGS); do \
           echo "::: Downloading $(DL.SERVER)/$(DL.PATH)/$${PYTHON_PACKAGE} :::"; \
           if [ -f $${PYTHON_PACKAGE} ]; then \
                echo "::: $${PYTHON_PACKAGE} exists. Skipping... :::" ; \
           else \
                $(DL.CMD) $(DL.OPTS) $(DL.SERVER)/$(DL.PATH)/$${PYTHON_PACKAGE} ; \
                echo "::: Verifying size of $${PYTHON_PACKAGE} :::" ; \
                $(GREP.CMD) `$(STAT.CMD) --printf="%s" $${PYTHON_PACKAGE}` $(VERIFY.HASHES) ; \
                echo "::: Verifying hash of $${PYTHON_PACKAGE} :::" ; \
                $(GREP.CMD) `$(VERIFY.CMD) $(VERIFY.OPTS) $${PYTHON_PACKAGE} ` $(VERIFY.HASHES) ; \
                echo "" ; \
           fi; \
           echo "::: Unbundling $${PYTHON_PACKAGE} :::"; \
           $(TAR.CMD) $(TGZ.OPTS) $${PYTHON_PACKAGE}; \
           echo ""; \
        done




build: $(SRC_DIRS) jupyterdownload
	patch $(JUPYTER_CLIENT_DIR)/setup.py patch-files/jupyter_client.setup.py.patch
	patch $(IPYKERNEL_DIR)/setup.py patch-files/ipykernel.setup.py.patch
	patch $(NBCONVERT_DIR)/setup.py patch-files/nbconvert.setup.py.patch
	patch $(NOTEBOOK_DIR)/setup.py patch-files/notebook.setup.py.patch
	patch $(IPYPARALLEL_DIR)/setup.py patch-files/ipyparallel.setup.py.patch
	@echo "::: Package $(NAME) build complete :::"
	
install:: $(JUPYTER_PACKAGES)
	mkdir -p $(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages
	( \
          if  (( $$(echo "$(ROLLPYVERSION) < 3.5" |bc -l) )); then \
              perl -pi -e '$$_ = "" if m/$(NAME)/' $(REDHAT.ROOT)/nodes/scipy-common.xml; \
              exit; \
          fi; \
	  $(MODULE_LOAD_PYTHON); \
          for PYTHON_DIR in $(JUPYTER_DIRS); do \
             cd $${PYTHON_DIR}; \
             export PYTHONPATH=$(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages:$(CACHE_DIR)/lib/python$(ROLLPYVERSION)/site-packages; \
             python$(ROLLPYVERSION) setup.py build; \
	     python$(ROLLPYVERSION) setup.py install --prefix=$(ROOT)/$(PKGROOT); \
             export PYTHONPATH=$(CACHE_DIR)/lib/python$(ROLLPYVERSION)/site-packages; \
	     python$(ROLLPYVERSION) setup.py install --prefix=$(CACHE_DIR); \
             cd ..; \
          done; \
          cd $(SOURCE_DIR); \
          export PYTHONPATH=$(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages:$(CACHE_DIR)/lib/python$(ROLLPYVERSION)/site-packages; \
          python$(ROLLPYVERSION) setup.py build; \
	  python$(ROLLPYVERSION) setup.py install --prefix=$(ROOT)/$(PKGROOT); \
          export PYTHONPATH=$(CACHE_DIR)/lib/python$(ROLLPYVERSION)/site-packages; \
	  python$(ROLLPYVERSION) setup.py install --prefix=$(CACHE_DIR); \
	  rm -f $(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages/easy-install.pth; \
	  rm -f $(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages/site.py; \
	  rm -f $(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages/site.pyc; \
	  rm -f $(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages/site.pyo; \
          rm -rf $(ROOT)/$(PKGROOT)/lib/python$(ROLLPYVERSION)/site-packages/__pycache_; \
          find $(ROOT)/$(PKGROOT) -perm 0777 -exec chmod 0755 {} \;; \
          find $(ROOT)/$(PKGROOT) -perm 0666 -exec chmod 0644 {} \; \
	)
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf DESCRIPTION LICENSE $(JUPYTER_PACKAGES)

