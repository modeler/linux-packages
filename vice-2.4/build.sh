#!/bin/bash

VERSION=2.4
SOURCE=http://sourceforge.net/projects/vice-emu/files/releases/vice-${VERSION}.tar.gz/download
PACKAGE=vice

wget --content-disposition ${SOURCE}

mv ${PACKAGE}-${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
sed "s@CHANGEME@$(pwd)@g" ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
