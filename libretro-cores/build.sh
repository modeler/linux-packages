#!/bin/bash

CORES="\
beetle-pce-fast-libretro \
cannonball \
libretro-fceumm \
fbalpha2012 \
fuse-libretro \
gambatte-libretro \
Genesis-Plus-GX \
mame2000-libretro \
mame2003-plus-libretro \
nestopia \
pcsx_rearmed \
picodrive \
libretro-prboom
QuickNES_Core \
snes9x2002 \
snes9x2010 \
stella-libretro \
libretro-uae \
vice-libretro \
"

MAKE="make -j4"

grep -q 'Hardware.\+BCM2835' /proc/cpuinfo && export platform=rpi2

test -d cores || mkdir cores
for core in ${CORES}; do 
  git clone https://github.com/libretro/${core} || exit 1
  cd ${core}
  if [[ "${core}" == "fbalpha2012" ]]; then
    sh ./compile_libretro.sh ${MAKE}
    mv svn-current/trunk/fbalpha2012_libretro.so ../cores/
  elif [[ "${core}" == "nestopia" ]]; then
    cd libretro && ${MAKE}
    mv *.so ../../cores
    cd ..
  else
    ${MAKE} -f Makefile.libretro || make
    mv *.so ../cores/
  fi
  cd ..
done
