#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=0.37
SOURCE=https://sourceforge.net/projects/tapclean/files/tapclean/TAPClean%200.37/tapclean-${VERSION}-src.tgz/download

wget --content-disposition ${SOURCE}

mv ${PACKAGE}-${VERSION}.tgz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz
mv ${PACKAGE} ${PACKAGE}-${VERSION}

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
cat ../install > debian/install
dpkg-buildpackage -b

exit 0
