#!/bin/bash

VERSION=1.7.6
URL=https://github.com/libretro/RetroArch/archive
PACKAGE=$(basename $(pwd))
TARBALL=${URL}/v${VERSION}.tar.gz

if [[ $(which pacman) ]]; then
  DISTRO=arch
elif [[ $(which rpm) ]]; then
  DISTRO=redhat
else
  DISTRO=debian
fi

case "${DISTRO}" in

arch)
makepkg -s --noconfirm
;;

redhat)
wget --content-disposition ${TARBALL} --output-file=~/rpmbuild/SOURCES/${PACKAGE}-${VERSION}.tar.gz
cp ${PACKAGE}.spec ~/rpmbuild/SPECS
cd ~/rpmbuild/SPECS && rpmbuild -bb ${PACKAGE}.spec
;;

*)
wget --content-disposition ${TARBALL} -O ${PACKAGE}_${VERSION}.orig.tar.gz
sudo apt install -y libavcodec-dev libavdevice-dev libavformat-dev libgbm-dev libglm-dev libjack-jackd2-dev libswscale-dev libusb-1.0-0-dev libv4l-dev libxml2-dev libvulkan-dev python3-dev qt5-default
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz
mv RetroArch-${VERSION} ${PACKAGE}-${VERSION}
cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
dpkg-buildpackage -b
;;

esac

exit 0
