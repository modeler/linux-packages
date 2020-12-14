#!/bin/bash

PACKAGE=makemkv-bin
VERSION=1.15.4
URL=http://www.makemkv.com/download/makemkv-bin-${VERSION}.tar.gz
ARCHIVE=
SOURCE=

export PACKAGE VERSION URL ARCHIVE SOURCE

curl https://www.makemkv.com/forum/viewtopic.php?t=1053 2> /dev/null | awk -F".code>" '/^The current beta key is/ { print $2 }' | tr -d '<' > beta_key.txt

../common.sh

exit 0
