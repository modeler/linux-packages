#!/bin/bash

PACKAGE=ucon64
VERSION=2.1.0
URL=https://downloads.sourceforge.net/ucon64/ucon64-${VERSION}-src.tar.gz
ARCHIVE=
SOURCE=ucon64-2.1.0-src

export PACKAGE VERSION URL ARCHIVE SOURCE
export DEB_CFLAGS_STRIP="-Werror=format-security"

../common.sh

exit 0
