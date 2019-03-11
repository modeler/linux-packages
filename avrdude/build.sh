#!/bin/bash

PACKAGE=avrdude
VERSION=6.3
URL=http://download.savannah.gnu.org/releases/avrdude/avrdude-${VERSION}.tar.gz
ARCHIVE=
SOURCE=

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
