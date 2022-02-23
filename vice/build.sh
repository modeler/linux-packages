#!/bin/bash

PACKAGE=vice
VERSION=3.6.1
URL=http://sourceforge.net/projects/vice-emu/files/releases/vice-${VERSION}.tar.gz/download
ARCHIVE=vice-${VERSION}.tar.gz
SOURCE=

export PACKAGE VERSION URL ARCHIVE SOURCE

test -d ~/.fonts || mkdir -p ~/.fonts
fc-cache

../common.sh

exit 0
