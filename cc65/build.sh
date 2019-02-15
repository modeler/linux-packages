#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=2.16
SOURCE=https://github.com/${PACKAGE}/${PACKAGE}/archive/V${VERSION}.tar.gz

wget ${SOURCE}

mv V${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
export prefix=/usr
dpkg-buildpackage -b

exit 0
