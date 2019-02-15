#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=4.2
ARCH=$(uname -a | awk '{print $9}')
SOURCE=http://www.softpres.org/_media/files:ipflib42_linux-${ARCH}.tar.gz

wget ${SOURCE}

mv files\:ipflib42_linux-${ARCH}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz
mv ${ARCH}-linux-gnu-capsimage ${PACKAGE}-${VERSION}

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
cat ../install >> debian/install
dpkg-buildpackage -b

exit 0
