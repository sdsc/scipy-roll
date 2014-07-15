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
include pull.mk

COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module=`module avail 2>&1 | grep -o -m1 "\<$(ROLLCOMPILER)\>"`; \
    if test "$${module}" != "$(ROLLCOMPILER)"; then \
      echo *** ERROR: Compiler $(ROLLCOMPILER) not found; \
      exit 2; \
    fi; \
    module load $(ROLLCOMPILER); \
  fi; \
  export SETUPOPTS="--compiler=unix --fcompiler=unix"; \
  if test "$(COMPILERNAME)" = "intel"; then \
    export SETUPOPTS="--compiler=intel --fcompiler=intelem"; \
  fi; \
  export COMMENTMKL='\#'; \
  if test -n "$${MKL_ROOT}"; then \
    export MKLLIB=`find $${MKL_ROOT}/lib/* -maxdepth 0 | head -1`; \
    export MKLLINK="-L$${MKLLIB} -lmkl_rt"; \
    export COMMENTMKL=''; \
  else \
    export BLAS=$(PWD)/$(SOURCE_DIR)/libblas.a; \
    export LAPACK=$(PWD)/$(SOURCE_DIR)/liblapack.a; \
  fi
PYSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module=`module avail 2>&1 | grep -o -m1 "\<$(ROLLPY)\>"`; \
    if test "$${module}" != "$(ROLLPY)"; then \
      echo *** ERROR: Python $(ROLLPY) not found; \
      exit 2; \
    fi; \
    module load $(ROLLPY); \
  fi

CPPCOMP = g++
COMPILE_FLAGS = -O2 -shared -fPIC
ifeq ("$(COMPILERNAME)", "intel")
  CPPCOMP = icpc
  COMPILE_FLAGS = -xHost -O3 -shared -fPIC -openmp
endif

build: $(SRC_DIRS)
	cp patch-files/site.cfg $(SOURCE_DIR)
	cp libblas.a $(SOURCE_DIR); \
	cp liblapack.a $(SOURCE_DIR); \
	( \
	  $(COMPILERSETUP); \
	  $(PYSETUP); \
	  perl -pi -e "s!ROLL_COMMENTMKL\\s*!$${COMMENTMKL}!;s!ROLL_MKLLIB!$${MKLLIB}!;s!ROLL_MKLROOT!$${MKL_ROOT}!" $(SOURCE_DIR)/site.cfg; \
	  cd $(SOURCE_DIR); \
	  python setup.py config $${SETUPOPTS} \
	                  build_clib $${SETUPOPTS} \
	                  build_ext $${SETUPOPTS}; \
	  for x in csr csc coo bsr dia; do \
	    $(CPPCOMP) $(COMPILE_FLAGS) \
	      build/temp.linux-x86_64-*/scipy/sparse/sparsetools/$${x}_wrap.o\
	      -o build/lib.linux-x86_64-*/scipy/sparse/sparsetools/_$${x}.so;\
	  done; \
	  $(CPPCOMP) $(COMPILE_FLAGS) \
	    build/temp.linux-x86_64-*/scipy/interpolate/src/_interpolate.o \
	    -o build/lib.linux-x86_64-*/scipy/interpolate/_interpolate.so; \
	)
	@echo "::: Package $(NAME) build complete :::"
	
install::
	mkdir -p $(ROOT)/$(PKGROOT)
	( \
	  $(PYSETUP); \
	  cd $(SOURCE_DIR); \
	  python setup.py install --prefix=$(ROOT)/$(PKGROOT); \
	)
	@echo "::: Package $(NAME) install complete :::"

clean::

