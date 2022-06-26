#!/bin/bash

PACKAGE=opencbm
VERSION=0.4.99.104
URL=https://github.com/OpenCBM/OpenCBM/archive/refs/tags/v${VERSION}.tar.gz
ARCHIVE=
SOURCE=OpenCBM-${VERSION}

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
