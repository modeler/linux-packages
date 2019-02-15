#!/bin/bash

PACKAGE=$(basename $(pwd))
SOURCE=https://sourceforge.net/projects/opencbm/files/${PACKAGE}/${PACKAGE}-${VERSION}/${PACKAGE}-${VERSION}.tar.bz2

sudo apt install -y subversion 

svn co https://svn.code.sf.net/p/acme-crossass/code-0/trunk acme-crossass-code-0 | tee svn.out
VERSION=$(awk '/^Checked out revision/ {print $4}' svn.out | tr -d .)

mv acme-crossass-code-0/src ./${PACKAGE}-${VERSION}

cd ${PACKAGE}-${VERSION}
dh_make -s -y --createorig
cat ../control > debian/control
cat ../rules >> debian/rules
cat ../install > debian/install
dpkg-buildpackage -b

exit 0
