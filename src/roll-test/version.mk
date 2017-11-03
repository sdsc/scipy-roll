NAME       = sdsc-scipy-roll-test
VERSION    = 1
RELEASE    = 10
PKGROOT    = /root/rolltests

RPM.EXTRAS = AutoReq:No\nObsoletes: scipy-roll-test
RPM.FILES  = $(PKGROOT)/scipy.t
