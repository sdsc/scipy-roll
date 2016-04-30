# $Id$
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 5.6 (Emerald Boa)
# 		         version 6.1 (Emerald Boa)
# 
# Copyright (c) 2000 - 2013 The Regents of the University of California.
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
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
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
# $Log$

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

SETUPOPTS =
ifeq ("$(COMPILERNAME)", "intel")
  SETUPOPTS = "--compiler=intel"
endif

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	$(MODULE_LOAD_PYTHON); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_PYTHON); \
	  $(DESCRIBE_CUDA) \
	) > $@

ADDED_MODULES = singledispatch

LICENSE: $(SRC_DIRS)
	for F in $(ADDED_MODULES); do \
          echo $$F*/PKG-INFO; \
	  cp $$F*/PKG-INFO $(SOURCE_DIR)/$$F-PKG-INFO; \
	done
	$(CHECK_LICENSE_FILES)
	echo "Contiuum Analytics" > $@

CACHE_DIR=$(REDHAT.ROOT)/cache

build: $(SRC_DIRS)
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_CUDA); \
	  $(MODULE_LOAD_PYTHON); \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/lib/python$(PYVERSION)/site-packages
	mkdir -p -m 755 $(CACHE_DIR)/lib/python$(PYVERSION)/site-packages
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_CUDA); \
	  $(MODULE_LOAD_PYTHON); \
          TMPPYTHON=$${PYTHONPATH}; \
          export PYTHONPATH=$${TMPPYTHON}:$(ROOT)/$(PKGROOT)/lib/python$(PYVERSION)/site-packages; \
          cp -r $(SINGLEDISPATCH_DIR) $(SINGLEDISPATCH_DIR)2; \
          cd $(SINGLEDISPATCH_DIR); \
          python setup.py build; \
	  python setup.py install --prefix=$(ROOT)/$(PKGROOT); \
          cd ..; \
          cp -r $(SOURCE_DIR) $(SOURCE_DIR)2; \
	  cd $(SOURCE_DIR); \
	  python setup.py build $(SETUPOPTS); \
	  python setup.py install --prefix=$(ROOT)/$(PKGROOT); \
          export PYTHONPATH=$${TMPPYTHON}:$(CACHE_DIR)/lib/python$(PYVERSION)/site-packages; \
          cd ../$(SINGLEDISPATCH_DIR)2; \
          python setup.py build; \
	  python setup.py install --prefix=$(CACHE_DIR); \
          cd ../$(SOURCE_DIR)2; \
	  python setup.py build $(SETUPOPTS); \
	  python setup.py install --prefix=$(CACHE_DIR); \
          rm -f $(ROOT)/$(PKGROOT)/lib/python$(PYVERSION)/site-packages/easy-install.pth; \
          rm -f $(ROOT)/$(PKGROOT)/lib/python$(PYVERSION)/site-packages/site.py; \
          rm -f $(ROOT)/$(PKGROOT)/lib/python$(PYVERSION)/site-packages/site.pyc; \
          rm -f $(ROOT)/$(PKGROOT)/lib/python$(PYVERSION)/site-packages/site.pyo \
	)
	$(INSTALL_LICENSE_FILES)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR) $(SOURCE_DIR)2 $(SINGLEDISPATCH_DIR) $(SINGLEDISPATCH_DIR)2 DESCRIPTION LICENSE
