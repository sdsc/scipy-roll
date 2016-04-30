NAME           = sdsc-scipy-easy_install_files_py$(PYVERSION)
VERSION        = 1.0
RELEASE        = 3
PKGROOT        = /opt/scipy/$(PYVERSION)

SRC_SUBDIR     = easy_install_files

RPM.EXTRAS     = AutoReq:No\nObsoletes: scipy-easy_install_files_py$(PYVERSION)
