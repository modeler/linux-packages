#!/bin/bash

#
# 4th. Runs common tasks that are consistent between packages. Does the
# actual packaging.
#

case "${DISTRO}" in

arch)
makepkg -s --noconfirm
;;

redhat)
cp ${PACKAGE}.spec ~/rpmbuild/SPECS
cd ~/rpmbuild/SPECS && rpmbuild -bb ${PACKAGE}.spec
;;

debian)
mv ${TARBALL} ${PACKAGE}_${VERSION}.orig.tar.gz
cd ${SOURCE}
dh_make -s -y
test -f ../install && cat ../install > debian/install
test -f ../control && cat ../control > debian/control
test -f ../rules && cat ../rules >> debian/rules
sudo apt install -y ${DEPENDS[*]}
dpkg-buildpackage -b
;;

esac
