#!/bin/bash

source ../pre-build.sh $(dirname $(pwd))

export VERSION=1.7.6
URL=https://github.com/libretro/RetroArch/archive
TARBALL=${URL}/v${VERSION}.tar.gz

case "${DISTRO}" in

arch)
../common.sh
;;

redhat)
wget --content-disposition ${TARBALL} --output-file=~/rpmbuild/SOURCES/${PACKAGE}-${VERSION}.tar.gz
../common.sh
;;

debian)
wget --content-disposition ${TARBALL} -O ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz
mv RetroArch-${VERSION} ${PACKAGE}-${VERSION}
../common.sh
;;

esac

exit 0
