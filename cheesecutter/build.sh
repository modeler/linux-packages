#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=2.9b3
SOURCE=https://github.com/theyamo/CheeseCutter/archive/v2.9-beta-3.tar.gz

wget ${SOURCE}

mv v2.9-beta-3.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz
mv CheeseCutter-2.9-beta-3 ${PACKAGE}-${VERSION}

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
cat ../rules >> debian/rules
cat ../install > debian/install
sed -i '21iimport std.algorithm : sort;' src/ui/dialogs.d
dpkg-buildpackage -b

exit 0
