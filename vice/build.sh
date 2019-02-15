#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=3.2
SOURCE=http://sourceforge.net/projects/vice-emu/files/releases/${PACKAGE}-${VERSION}.tar.gz/download

sudo apt install -y yasm libgtk2.0-dev libgtkglext1-dev libx264-dev libmp3lame-dev libxaw7-dev libreadline-dev libavresample-dev ffmpeg

wget --content-disposition ${SOURCE}

mv ${PACKAGE}-${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
sed "s@CHANGEME@$(pwd)@g" ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
