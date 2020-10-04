#!/bin/bash

PACKAGE=xa
VERSION=2.3.11
URL=http://www.floodgap.com/retrotech/xa/dists/${PACKAGE}-${VERSION}.tar.gz
ARCHIVE=
SOURCE=

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
