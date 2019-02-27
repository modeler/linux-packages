#!/bin/bash

#
# 2nd. Calls setup.sh, sets default package name and works out dependencies
# for Debian / apt based distributions.
#

if [[ -n ${1} ]]; then
  DIR=${1}
else
  DIR=.
fi

source ${DIR}/setup.sh

export PACKAGE=$(basename $(pwd))

case "${DISTRO}" in

debian)
DEPENDS=()
for n in $(grep "^Build-Depends:" control | tr -d ","); do
  if [[ ! $(egrep "Build-Depends:|\(.*|[0-9].*\)" <<< ${n}) ]]; then
    DEPENDS+=(${n})
  fi
done
export ${DEPENDS}
;;

esac
