grep -q 'Hardware.\+BCM2835' /proc/cpuinfo && export platform=rpi2

CORES="\
beetle-pce-fast-libretro \
libretro-fceumm \
fbalpha2012 \
fuse-libretro \
gambatte-libretro \
Genesis-Plus-GX
mame2003-plus-libretro \
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

mkdir cores
for core in ${CORES}; do 
  git clone https://github.com/libretro/${core}
  cd ${core}
  if [[ "${core}" == "fbalpha2012" ]]; then
    sh ./compile_libretro.sh make
  else
    make -f Makefile.libretro || make
  fi
  mv *.so ../cores
  cd ..
done
