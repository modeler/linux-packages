#!/bin/bash

source ../pre-build.sh $(dirname $(pwd))

svn co https://svn.code.sf.net/p/acme-crossass/code-0/trunk acme-crossass-code-0 | tee svn.out
export VERSION=$(awk '/^Checked out revision/ {print $4}' svn.out | tr -d .)
TARBALL=${PACKAGE}-${VERSION}.tar.gz

mv acme-crossass-code-0/src ./${PACKAGE}-${VERSION}
tar cf - ${PACKAGE}-${VERSION} | gzip > ${TARBALL}

case "${DISTRO}" in

debian)
mv ${TARBALL} ${PACKAGE}_${VERSION}.orig.tar.gz
../common.sh
;;

esac

exit 0
