NAME           = sdsc-jupyterhub_py$(PYVERSION)
VERSION        = 1.0
RELEASE        = 5
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = jupyterhub

SOURCE_NAME    = jupyterhub

RPM.EXTRAS     = AutoReq:No\nObsoletes: jupyterhub
RPM.FILES     = $(PKGROOT)/bin/jupyterhub-singleuser
