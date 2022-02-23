#!/bin/bash

PACKAGE=zesarux
VERSION=10.0
URL=https://github.com/chernandezba/zesarux/archive/refs/tags/${VERSION}.tar.gz
ARCHIVE=
SOURCE=

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
