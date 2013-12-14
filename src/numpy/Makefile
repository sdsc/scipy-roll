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

ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif

ifndef PYPATH
  PYPATH = python
endif
PYVERSION = $(shell $(PYPATH) -c "from __future__ import print_function;import sys;print(sys.version[:3])")

REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include pull.mk

COMMENTMKL = \#
COMPILERLIB = /usr/lib64
COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load $(ROLLCOMPILER); \
  fi
SETUPOPTS = --compiler=unix --fcompiler=unix
ifeq ("$(ROLLCOMPILER)", "intel")
  COMMENTMKL =
  COMPILERLIB = `which icc | sed 's/.icc//'`/../../lib/intel64
  COMPILERSETUP += ;\
    export MKL_HOME=$${MKL_ROOT}; \
    export MKLLIB=`find $${MKL_ROOT}/lib/* -maxdepth 0 | head -1`
  SETUPOPTS = --compiler=intelem --fcompiler=intelem
endif

build: $(SRC_DIRS)
	cp patch-files/site.cfg $(SOURCE_DIR)
	cp patch-files/intelccompiler.py $(SOURCE_DIR)/numpy/distutils
	cp patch-files/intel.py $(SOURCE_DIR)/numpy/distutils/fcompiler
	cp patch-files/system_info.py $(SOURCE_DIR)/numpy/distutils
	( \
	  $(COMPILERSETUP); \
	  echo Using python $(PYPATH) version $(PYVERSION); \
	  cd $(SOURCE_DIR); \
	  perl -pi -e "s!ROLL_COMMENTMKL\\s*!$(COMMENTMKL)!; s!ROLL_MKLLIB!$${MKLLIB}!; s!ROLL_COMPILERLIB!$(COMPILERLIB)!; s!ROLL_MKLROOT!$${MKL_HOME}!" site.cfg; \
	  $(PYPATH) setup.py build_src \
			  config $(SETUPOPTS) \
			  build_clib $(SETUPOPTS) \
			  build_ext $(SETUPOPTS) \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p $(ROOT)/$(PKGROOT)
	( \
	  $(COMPILERSETUP); \
	  cd $(SOURCE_DIR); \
	  $(PYPATH) setup.py install --prefix=$(ROOT)/$(PKGROOT); \
	)
	-mkdir -p $(REDHAT.ROOT)/src/site-packages-$(ROLLCOMPILER)/$(PYVERSION)
	/bin/cp -r `find $(ROOT)/$(PKGROOT) -name site-packages`/* $(REDHAT.ROOT)/src/site-packages-$(ROLLCOMPILER)/$(PYVERSION)
	@echo "::: Package $(NAME) install complete :::"

clean::
	rm -rf $(SOURCE_DIR)

