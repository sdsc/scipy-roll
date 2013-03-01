#
# $Id$
#
# @Copyright@
#
# 				Rocks(tm)
# 		         www.rocksclusters.org
# 		        version 4.3 (Mars Hill)
#
# Copyright (c) 2000 - 2011 The Regents of the University of California.
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
# 	"This product includes software developed by the Rocks(tm)
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

# Although this package isn't compiler-dependent, it relies on numpy, and we
# have to do compiler setup to find the dynamic libraries numpy uses.
ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif

PKGROOT = /opt/scipy
SOURCE = pyfits-$(VERSION)
REDHAT.ROOT = $(PWD)/../..

-include $(ROCKSROOT)/etc/Rules.mk

COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load $(ROLLCOMPILER); \
  fi

build:
	tar zxvf $(SOURCE).tar.gz
	cp patch-files/distribute_setup.py $(SOURCE)

install::
	( \
	  $(COMPILERSETUP); \
	  pypath=`echo python=python $(ROLLOPTS) | grep -o 'python=[^ ]*' | tail -1 | sed 's/.*=//'`; \
	  echo "Using python $$pypath"; \
	  pylib=`echo 'import sys; print "\n".join(sys.path)' | $$pypath | grep -m 1 '/lib.*site-packages$$'`; \
	  echo "Using python library $$pylib"; \
	  export PYTHONPATH=`dirname $$pylib`:$${PYTHONPATH}; \
	  if test -d $(REDHAT.ROOT)/src/site-packages-$(ROLLCOMPILER); then \
	    export PYTHONPATH=$(REDHAT.ROOT)/src/site-packages-$(ROLLCOMPILER):$${PYTHONPATH}; \
	  fi; \
	  version=`$$pypath -c "import sys; print sys.version[:3]"`; \
          sitepath=$(ROOT)/$(PKGROOT)/lib/python$${version}/site-packages; \
	  mkdir -p $(ROOT)/$(PKGROOT)/lib64/python$${version}/site-packages; \
	  export PYTHONPATH=$(ROOT)/$(PKGROOT)/lib64/python$${version}/site-packages:$${PYTHONPATH}; \
	  cd $(SOURCE); \
          $$pypath setup.py install --prefix $(ROOT)/$(PKGROOT) --install-lib $(ROOT)/$(PKGROOT)/lib64/python$${version}/site-packages; \
          rm -rf $${sitepath}/easy_install-2.6; \
          rm -rf $${sitepath}/easy_install; \
	)

clean::
	rm -rf $(SOURCE)
