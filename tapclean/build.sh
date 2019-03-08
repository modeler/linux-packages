#!/bin/bash

PACKAGE=tapclean
VERSION=0.37
URL=https://sourceforge.net/projects/tapclean/files/tapclean/TAPClean%20${VERSION}/tapclean-${VERSION}-src.tgz/download
ARCHIVE=tapclean-${VERSION}-src.tgz
SOURCE=tapclean

export PACKAGE VERSION URL ARCHIVE SOURCE

../common.sh

exit 0
