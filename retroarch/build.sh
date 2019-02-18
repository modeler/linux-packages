#!/bin/bash

VERSION=1.7.6
SOURCE=https://github.com/libretro/RetroArch/archive
PACKAGE=$(basename $(pwd))

sudo apt install -y libavcodec-dev libavdevice-dev libavformat-dev libgbm-dev libglm-dev libjack-jackd2-dev libswscale-dev libusb-1.0-0-dev libv4l-dev libxml2-dev libvulkan-dev python3-dev qt5-default

wget ${SOURCE}/v${VERSION}.tar.gz

mv v${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

mv RetroArch-${VERSION} ${PACKAGE}-${VERSION}

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
