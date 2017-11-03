NAME           = sdsc-jupyterhub
VERSION        = 1.0
RELEASE        = 4
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = jupyterhub

SOURCE_NAME    = jupyterhub

RPM.EXTRAS     = AutoReq:No\nObsoletes: jupyterhub
RPM.FILES     = $(PKGROOT)/bin/jupyterhub-singleuser
