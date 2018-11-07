NAME           = sdsc-jupyterhub_py$(ROLLPYVERSION)
VERSION        = 1.0
RELEASE        = 5
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = jupyterhub

SOURCE_NAME    = jupyterhub

RPM.EXTRAS     = AutoReq:No\nObsoletes: jupyterhub
RPM.FILES     = $(PKGROOT)/bin/jupyterhub-singleuser
