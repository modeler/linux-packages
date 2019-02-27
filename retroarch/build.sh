#!/bin/bash

source ../pre-build.sh $(dirname $(pwd))

VERSION=1.7.6
URL=https://github.com/libretro/RetroArch/archive
TARBALL=${URL}/v${VERSION}.tar.gz

case "${DISTRO}" in

arch)
makepkg -s --noconfirm
;;

redhat)
wget --content-disposition ${TARBALL} --output-file=~/rpmbuild/SOURCES/${PACKAGE}-${VERSION}.tar.gz
cp ${PACKAGE}.spec ~/rpmbuild/SPECS
cd ~/rpmbuild/SPECS && rpmbuild -bb ${PACKAGE}.spec
;;

debian)
wget --content-disposition ${TARBALL} -O ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz
mv RetroArch-${VERSION} ${PACKAGE}-${VERSION}
cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
sudo apt install -y ${DEPENDS[*]}
dpkg-buildpackage -b
;;

esac

exit 0
