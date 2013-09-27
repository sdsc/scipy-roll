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

ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif

PKGROOT = /opt/scipy
SOURCE = scipy-$(VERSION)
REDHAT.ROOT = $(PWD)/../..

ifeq ("$(findstring python=,$(ROLLOPTS))", "")
  PYPATH = python
else
  PYPATH = $(subst python=,,$(filter python=%,$(ROLLOPTS)))
endif
PYVERSION = $(shell $(PYPATH) -c "import sys; print sys.version[:3]")

-include $(ROCKSROOT)/etc/Rules.mk

COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load intel; \
    export MKLLIB=`find $${MKL_ROOT}/lib/* -maxdepth 0 | head -1`; \
    module load $(ROLLCOMPILER); \
  fi

LIBSETUP = \
   if test "$(ROLLCOMPILER)" = "gnu"; then  \
        export BLAS=$(PWD)/$(SOURCE)/libblas.a; \
        export LAPACK=$(PWD)/$(SOURCE)/liblapack.a; \
   fi

COMPILERLIB = /usr/lib64
COMMENTMKL =
CPPCOMP = g++
COMPILE_FLAGS = -O2 -shared -fPIC
SETUPOPTS = --compiler=unix --fcompiler=unix
ifeq ("$(ROLLCOMPILER)", "intel")
  COMPILERLIB = `which icc | sed 's/.icc//'`/../../lib/intel64
  CPPCOMP = icpc
  COMPILE_FLAGS = -xHost -O3 -shared -fPIC -openmp
  SETUPOPTS = --compiler=intel --fcompiler=intelem
endif

build:
	tar zxvf $(SOURCE).tar.gz
	cp patch-files/site.cfg $(SOURCE)
	cp patch-files/libblas.a $(SOURCE); \
	cp patch-files/liblapack.a $(SOURCE); \
	$(COMPILERSETUP); \
        perl -pi -e "s!ROLL_COMMENTMKL\\s*!$(COMMENTMKL)!; s!ROLL_MKLLIB!$${MKLLIB}!; s!ROLL_COMPILERLIB!$(COMPILERLIB)!" $(SOURCE)/site.cfg

install::
	mkdir -p $(ROOT)/$(PKGROOT)
	( \
	  $(COMPILERSETUP); \
          $(LIBSETUP); \
	  echo Using python $(PYPATH) version $(PYVERSION); \
	  if test -d $(REDHAT.ROOT)/src/site-packages-$(ROLLCOMPILER); then \
	    export PYTHONPATH=$(REDHAT.ROOT)/src/site-packages-$(ROLLCOMPILER):$${PYTHONPATH}; \
	  fi; \
	  cd $(SOURCE); \
	  $(PYPATH) setup.py config $(SETUPOPTS) \
	                  build_clib $(SETUPOPTS) \
	                  build_ext $(SETUPOPTS); \
	  for x in csr csc coo bsr dia; do \
	    $(CPPCOMP) $(COMPILE_FLAGS) \
	      build/temp.linux-x86_64-2.4/scipy/sparse/sparsetools/$${x}_wrap.o\
	      -o build/lib.linux-x86_64-2.4/scipy/sparse/sparsetools/_$${x}.so;\
	  done; \
	  $(CPPCOMP) $(COMPILE_FLAGS) \
	    build/temp.linux-x86_64-2.4/scipy/interpolate/src/_interpolate.o \
	    -o build/lib.linux-x86_64-2.4/scipy/interpolate/_interpolate.so; \
	  $(PYPATH) setup.py install --prefix=$(ROOT)/$(PKGROOT) \
	)

clean::
	rm -rf $(SOURCE)
