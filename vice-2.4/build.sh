#!/bin/bash

VERSION=2.4
SOURCE=http://sourceforge.net/projects/vice-emu/files/releases/vice-${VERSION}/tar.gz/download
PACKAGE=vice

wget ${SOURCE}/v${VERSION}.tar.gz

mv v${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
