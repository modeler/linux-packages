#!/bin/bash

PACKAGE=retroarch
VERSION=1.9.3
URL=https://github.com/libretro/RetroArch/archive/v${VERSION}.tar.gz
ARCHIVE=RetroArch-${VERSION}.tar.gz
SOURCE=RetroArch-${VERSION}

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
