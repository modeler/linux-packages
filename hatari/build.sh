#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=2.0.0
SOURCE=http://download.tuxfamily.org/hatari/${VERSION}/${PACKAGE}-${VERSION}.tar.bz2

sudo apt -y install cmake portaudio19-dev libportmidi-dev libreadline-dev

wget ${SOURCE}

mv ${PACKAGE}-${VERSION}.tar.bz2 ${PACKAGE}_${VERSION}.orig.tar.bz2
tar xf ${PACKAGE}_${VERSION}.orig.tar.bz2

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
cp ../tos.img src/
dpkg-buildpackage -b

exit 0
