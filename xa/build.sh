#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=2.3.9
SOURCE=http://www.floodgap.com/retrotech/xa/dists/${PACKAGE}-${VERSION}.tar.gz

wget ${SOURCE}

mv ${PACKAGE}-${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
