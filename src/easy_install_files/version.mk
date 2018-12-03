NAME           = sdsc-scipy-easy_install_files_py$(ROLLPYVERSION)
VERSION        = 1.0
RELEASE        = 6
PKGROOT        = /opt/scipy/$(ROLLPYVERSION)

SRC_SUBDIR     = easy_install_files

RPM.EXTRAS     = AutoReq:No\nObsoletes: scipy-easy_install_files_py$(ROLLPYVERSION)
RPM.PREFIX     = $(PKGROOT)
