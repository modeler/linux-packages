#!/bin/bash

. ../setup.sh

# If no name is given for the downloaded file, use the filename as identified by the URL.
if [[ "${ARCHIVE}" == "" ]]; then
  ARCHIVE=$(awk -F/ '{print $NF}' <<< ${URL} )
fi

if [[ "${VERSION}" == "svn" ]]; then
  svn co ${URL} tmp | tee svn.log
  # Redefine version based on SVN commit.
  VERSION=$(awk '/^Checked out revision/ {print $4}' svn.log | tr -d .)
  # Redefine the name of the source directory based on new version info.
  SOURCE=${PACKAGE}-${VERSION}
  mv tmp/${ARCHIVE} ${SOURCE}
  # Redefine the name of the archive file based on new version info.
  ARCHIVE=${PACKAGE}-${VERSION}.tar.gz
  # Create an archive file from source code we pulled from SVN.
  tar cf - ${SOURCE} | gzip > ${ARCHIVE}
  rm -rf tmp .svn svn.log
else
  test -f ${ARCHIVE} || wget --content-disposition ${URL}
fi

# If no name has been given to the source directory yet, set it to default.
# This needs to be done after SVN mangling, as VERSION may have been redifined.
if [[ "${SOURCE}" == "" ]]; then
  SOURCE=${PACKAGE}-${VERSION}
fi

case "${DISTRO}" in

arch)
makepkg -s --noconfirm
;;

redhat)
cp ${ARCHIVE} ~/rpmbuild/SOURCES
cp ${PACKAGE}.spec ~/rpmbuild/SPECS
cd ~/rpmbuild/SPECS && rpmbuild -bb ${PACKAGE}.spec
;;

debian)
# Untar or unzip if required, since Debian doesn't do this automatically.
FILETYPE=$(awk -F. '{print $NF}' <<< ${ARCHIVE} )
if [[ "${FILETYPE}" == "zip" ]]; then
  test -d ${SOURCE} || unzip ${ARCHIVE}
elif [[ "${FILETYPE}" == "bz2" ]]; then
  test -d ${SOURCE} || tar xvf ${ARCHIVE}
  # Create a backup file to match what dh_make is expecting.
  cp ${ARCHIVE} ${PACKAGE}_${VERSION}.orig.tar.bz2
else
  test -d ${SOURCE} || tar xvf ${ARCHIVE}
  # Create a backup file to match what dh_make is expecting.
  cp ${ARCHIVE} ${PACKAGE}_${VERSION}.orig.tar.gz
fi
# Does the extracted source tree match what Debian wants?
if [[ "${SOURCE}" != "${PACKAGE}-${VERSION}" ]]; then
  mv ${SOURCE} ${PACKAGE}-${VERSION}
fi
cd ${PACKAGE}-${VERSION}
dh_make -s -y
test -f ../install && cat ../install > debian/install
test -f ../control && sed "s@_KERNEL_@$(uname -r)@g" ../control > debian/control
test -f ../rules && sed "s@_BUILDROOT_@$(pwd)@g" ../rules >> debian/rules
test -f ../pre_build && bash ../pre_build
# Install dependencies.
DEPENDS=()
for n in $(grep "^Build-Depends:" debian/control | tr -d ","); do
  if [[ ! $(egrep "Build-Depends:|\(.*|[0-9].*\)" <<< ${n}) ]]; then
    DEPENDS+=(${n})
  fi
done
sudo apt-get -y install ${DEPENDS[*]} || exit 1
dpkg-buildpackage -b
;;

esac

