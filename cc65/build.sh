#!/bin/bash

PACKAGE=cc65
VERSION=2.16
URL=https://github.com/cc65/cc65/archive/V${VERSION}.tar.gz
ARCHIVE=cc65-2.16.tar.gz
SOURCE=

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
