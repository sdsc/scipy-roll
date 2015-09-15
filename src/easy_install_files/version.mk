NAME           = sdsc-scipy-easy_install_files_py$(PYVERSION)
VERSION        = 1.0
RELEASE        = 1
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = easy_install_files

RPM.EXTRAS     = AutoReq:No
RPM.EXTRAS  = Obsoletes: scipy-easy_install_files_py$(PYVERSION)
