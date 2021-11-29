#!/bin/bash

PACKAGE=disk-utilities
VERSION=2021.03.20
URL=https://github.com/keirf/Disk-Utilities/archive/refs/tags/${VERSION}.zip
ARCHIVE=${VERSION}.zip
SOURCE=Disk-Utilities-${VERSION}

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
