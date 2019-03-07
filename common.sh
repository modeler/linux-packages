#!/bin/bash

# If no name is given for the downloaded file, use the filename as identified by the URL.
if [[ "${ARCHIVE}" == "" ]]; then
  ARCHIVE=$(awk -F/ '{print $NF}' <<< ${URL} )
fi

. ../setup.sh

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
if [[ "$(awk -F. '{print $NF}' <<< ${ARCHIVE} )" == "zip" ]]; then
  test -d ${SOURCE} || unzip ${ARCHIVE}
else
  test -d ${SOURCE} || tar xvf ${ARCHIVE}
fi
# Does the extracted source tree match what Debian wants?
if [[ "${SOURCE}" != "${PACKAGE}-${VERSION}" ]]; then
  mv ${SOURCE} ${PACKAGE}-${VERSION}
fi
# Rename the archive file to match what dh_make is expecting.
mv ${ARCHIVE} $(sed "s/.*-${VERSION}/${PACKAGE}_${VERSION}.orig/" <<< ${ARCHIVE} )
cd ${PACKAGE}-${VERSION}
dh_make -s -y
test -f ../install && cat ../install > debian/install
test -f ../control && cat ../control > debian/control
test -f ../rules && cat ../rules >> debian/rules
# Install dependencies.
DEPENDS=()
for n in $(grep "^Build-Depends:" debian/control | tr -d ","); do
  if [[ ! $(egrep "Build-Depends:|\(.*|[0-9].*\)" <<< ${n}) ]]; then
    DEPENDS+=(${n})
  fi
done
sudo apt install -y ${DEPENDS[*]}
dpkg-buildpackage -b
;;

esac

