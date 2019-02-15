#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=2.8.4
SOURCE=https://fs-uae.net/stable/${VERSION}/${PACKAGE}-${VERSION}.tar.gz

sudo apt install -y libsdl2-dev libglib2.0-dev libopenal-dev libfreetype6-dev libxi-dev libpng-dev zlib1g-dev libmpeg2-4-dev libjpeg-dev libglew-dev libxtst-dev

wget ${SOURCE}

mv ${PACKAGE}-${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

cd ${PACKAGE}-${VERSION}
dh_make -s -y
dpkg-buildpackage -b

exit 0
