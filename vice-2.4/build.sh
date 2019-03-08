#!/bin/bash

PACKAGE=vice
VERSION=2.4
URL=http://sourceforge.net/projects/vice-emu/files/releases/vice-${VERSION}.tar.gz/download
ARCHIVE=vice-${VERSION}.tar.gz
SOURCE=

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
