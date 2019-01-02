NAME       = sdsc-scipy-roll-test
VERSION    = 2
RELEASE    = 2
PKGROOT    = /root/rolltests

RPM.EXTRAS = AutoReq:No\nObsoletes: scipy-roll-test
RPM.FILES  = $(PKGROOT)/scipy.t
