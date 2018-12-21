NAME       = sdsc-scipy-roll-test
VERSION    = 2
RELEASE    = 1
PKGROOT    = /root/rolltests

RPM.EXTRAS = AutoReq:No\nObsoletes: scipy-roll-test
RPM.FILES  = $(PKGROOT)/scipy.t
