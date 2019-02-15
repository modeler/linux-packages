#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=0.4.99.99
SOURCE=https://sourceforge.net/projects/opencbm/files/${PACKAGE}/${PACKAGE}-${VERSION}/${PACKAGE}-${VERSION}.tar.bz2

sudo apt install -y libusb-dev libncurses5-dev libelf-dev cc65

wget ${SOURCE}

mv ${PACKAGE}-${VERSION}.tar.bz2 ${PACKAGE}_${VERSION}.orig.tar.bz2
tar xf ${PACKAGE}_${VERSION}.orig.tar.bz2

cd ${PACKAGE}-${VERSION}
rm -rf debian
dh_make -s -y
sed "s@CHANGEME@$(uname -r)@" ../control > debian/control
sed "s@CHANGEME@$(pwd)@g" ../rules >> debian/rules
sed -i "s/usr\/local/usr/" opencbm/LINUX/config.make
dpkg-buildpackage -b

exit 0
