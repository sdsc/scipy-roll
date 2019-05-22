ifndef ROLLPY
  ROLLPY = python
endif

ifndef ROLLPYVERSION
  ROLLPYVERSION = 2.7
endif

JUPYTER_PACKAGES = tornado-4.5.2 backports_abc-0.5 bleach-3.0.2 Data-Stag-0.14 defusedxml-0.5.0 entrypoints-0.2.3 IO-String-1.08 ipywidgets-7.4.2 Jinja2-2.10 jsonschema-2.6.0 jupyter_client-5.2.4 jupyter_console-6.0.0 jupyter_core-4.4.0 ipykernel-5.1.0 ipyparallel-6.2.3 MarkupSafe-1.1.0 mistune-0.8.4 nbconvert-5.4.0 nbformat-4.4.0 notebook-5.7.4 pandocfilters-1.4.2 prometheus_client-0.5.0 pyzmq-17.1.2 qtconsole-4.4.3 Send2Trash-1.5.0 terminado-0.8.1 testpath-0.4.2 webencodings-0.5.1 widgetsnbextension-3.4.2 jupyter-1.0.0


NAME               = sdsc-jupyter_py$(ROLLPYVERSION)
VERSION            = 1.0.0
RELEASE            = 3
PKGROOT            = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR         = jupyter

SOURCE_DIR         = jupyter-$(VERSION)

$(JUPYTER_PACKAGES):
	$(eval PYTHON_PACKAGE  = $(shell echo $@ |sed 's/-[[:digit:]][[:digit:]].[[:digit:]].[[:digit:]]\+//g'|sed 's/-[[:digit:]].[[:digit:]][[:digit:]].[[:digit:]]\+//g'|sed 's/-[[:digit:]].[[:digit:]].[[:digit:]]\+//g' |sed 's/-[[:digit:]].[[:digit:]]\+//g' ))
	$(eval PYTHON_PACKAGE_VERSION  = $(shell echo $@ | sed 's/$(PYTHON_PACKAGE)-//'))
	$(eval UPPER = $(shell echo $(PYTHON_PACKAGE) |tr a-z A-Z))
	$(eval $(UPPER)_NAME  = $(PYTHON_PACKAGE))
	$(eval $(UPPER)_SUFFIX = tar.gz)
	$(eval $(UPPER)_VERSION = $(PYTHON_PACKAGE_VERSION))
	$(eval $(UPPER)_PKG = $($(UPPER)_NAME)-$($(UPPER)_VERSION).$($(UPPER)_SUFFIX))
	$(eval $(UPPER)_DIR = $($(UPPER)_PKG:%.$($(UPPER)_SUFFIX)=%))
	$(eval JUPYTER_PKGS  += $($(UPPER)_PKG))
	$(eval JUPYTER_DIRS  += $($(UPPER)_DIR))
	$(eval JUPYTER_NAMES  += $($(UPPER)_NAME))


RPM.EXTRAS         = AutoReq:No\n%global _python_bytecompile_errors_terminate_build 0
RPM.PREFIX         = $(PKGROOT)

