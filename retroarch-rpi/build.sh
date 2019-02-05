#!/bin/bash

VERSION=1.7.6
SOURCE=https://github.com/libretro/RetroArch/archive
PACKAGE=$(basename $(pwd))

wget ${SOURCE}/v${VERSION}.tar.gz

mv v${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

mv RetroArch-${VERSION} retroarch-${VERSION}

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
