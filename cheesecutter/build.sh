#!/bin/bash

export VERSION=2.9b3
URL=https://github.com/theyamo/CheeseCutter/archive
FILE=v2.9-beta-3.tar.gz

source ../pre-build.sh $(dirname $(pwd))

wget ${URL}/${FILE}
tar xf ${FILE}
mv CheeseCutter-2.9-beta-3 ${SOURCE}
test -f ${TARBALL} || tar cf - ${SOURCE} | gzip > ${TARBALL}

case "${DISTRO}" in

arch)
../common.sh
;;

redhat)
../common.sh
;;

debian)
sed -i '21iimport std.algorithm : sort;' ${SOURCE}/src/ui/dialogs.d
../common.sh
;;

esac

exit 0
