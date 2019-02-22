Name:           retroarch
Version:        1.7.5
Release:        1%{?dist}
Summary:        Simple frontend for the libretro library

Group:          Applications/Emulators
License:        GPLv3
URL:            http://www.retroarch.com/
Source0:        v1.7.5.tar.gz

BuildRequires:  alsa-lib-devel, pulseaudio-libs-devel, vulkan-devel, jack-audio-connection-kit-devel, qt5-qtbase-devel, libxml2-devel, libv4l-devel, wayland-devel
#Requires:

%description
RetroArch is an open source, multi-platform frontend for the libretro API. It
can be used as a modular multi emulator system, game engine, media player and
3D technical demonstration. These features are available through libretro
cores.

It provides three built-in GUI: RGUI, XMB and GLUI.


%prep
%setup -q -n RetroArch-1.7.5


%build
./configure --prefix=/usr
make %{?_smp_mflags}


%install
make install DESTDIR=%{buildroot}


%files
   /etc/retroarch.cfg
   /usr/bin/retroarch
   /usr/bin/retroarch-cg2glsl
   /usr/share/applications/retroarch.desktop
   /usr/share/pixmaps/retroarch.svg
%doc
   /usr/share/doc/retroarch/COPYING
   /usr/share/doc/retroarch/README.md
   /usr/share/man/man6/retroarch-cg2glsl.6.gz
   /usr/share/man/man6/retroarch.6.gz


%changelog
