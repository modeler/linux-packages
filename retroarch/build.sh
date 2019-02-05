#!/bin/bash

VERSION=1.7.6
mv v${VERSION}.tar.gz retroarch_${VERSION}.orig.tar.gz
tar xf retroarch_${VERSION}.orig.tar.gz
mv RetroArch-${VERSION} retroarch-${VERSION}
touch retroarch_${VERSION}-1.dsc
cd retroarch-${VERSION}
dh_make
cat ../control > debian/control
cat ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
