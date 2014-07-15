ifndef ROLLPY
  ROLLPY = python
endif

ifndef PYVERSION
  PYVERSION = 2.6
endif

NAME    = scipy-modules_py$(PYVERSION)
VERSION = $(PYVERSION)
RELEASE = 2

RPM.EXTRAS = "AutoReq: no"
