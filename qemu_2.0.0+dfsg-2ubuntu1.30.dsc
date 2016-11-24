-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Format: 3.0 (quilt)
Source: qemu
Binary: qemu, qemu-keymaps, qemu-system, qemu-system-common, qemu-system-misc, qemu-system-arm, qemu-system-mips, qemu-system-ppc, qemu-system-sparc, qemu-system-x86, qemu-user, qemu-user-static, qemu-utils, qemu-guest-agent, qemu-kvm, qemu-common, qemu-system-aarch64
Architecture: any all
Version: 2.0.0+dfsg-2ubuntu1.30
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Uploaders: Aurelien Jarno <aurel32@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>
Homepage: http://www.qemu.org/
Standards-Version: 3.9.5
Vcs-Browser: http://anonscm.debian.org/gitweb/?p=pkg-qemu/qemu.git;a=shortlog;h=refs/heads/ubuntu-trusty
Vcs-Git: git://anonscm.debian.org/pkg-qemu/qemu.git -b ubuntu-trusty
Build-Depends: debhelper (>= 9), device-tree-compiler, texinfo, python:any, libaio-dev [linux-any], libasound2-dev [linux-any], libattr1-dev, libbluetooth-dev [linux-any], libbrlapi-dev, libcap-dev [linux-any], libcap-ng-dev [linux-any], libcurl4-gnutls-dev, libfdt-dev, libgnutls-dev, libncurses5-dev, libpixman-1-dev, libpulse-dev, librados-dev [linux-any], librbd-dev [linux-any], libsasl2-dev, libsdl1.2-dev (>> 1.2.1), libseccomp-dev (>> 2.1.0) [linux-amd64 linux-i386], libspice-server-dev (>= 0.12.2~) [linux-amd64 linux-i386], libspice-protocol-dev (>= 0.12.3~) [linux-amd64 linux-i386], libusb-1.0-0-dev (>= 2:1.0.13~) [linux-any], libusbredirparser-dev (>= 0.6~) [linux-any], libx11-dev, libxen-dev [linux-amd64 linux-i386], linux-libc-dev (>= 2.6.34) [linux-any], uuid-dev, xfslibs-dev [linux-any], zlib1g-dev, libpng12-dev
Build-Conflicts: oss4-dev
Package-List: 
 qemu deb otherosfs optional
 qemu-common deb oldlibs optional
 qemu-guest-agent deb otherosfs optional
 qemu-keymaps deb otherosfs optional
 qemu-kvm deb otherosfs optional
 qemu-system deb otherosfs optional
 qemu-system-aarch64 deb otherosfs optional
 qemu-system-arm deb otherosfs optional
 qemu-system-common deb otherosfs optional
 qemu-system-mips deb otherosfs optional
 qemu-system-misc deb otherosfs optional
 qemu-system-ppc deb otherosfs optional
 qemu-system-sparc deb otherosfs optional
 qemu-system-x86 deb otherosfs optional
 qemu-user deb otherosfs optional
 qemu-user-static deb otherosfs optional
 qemu-utils deb otherosfs optional
Checksums-Sha1: 
 b38b4f90c830689f0b5e103b7c15f7ead054e140 5023280 qemu_2.0.0+dfsg.orig.tar.xz
 121938dd61a1aa7495398a82803455d02d40bb67 204840 qemu_2.0.0+dfsg-2ubuntu1.30.debian.tar.gz
Checksums-Sha256: 
 f7eb5fa8f5d8717ed4cd27b5ff71d2b522544b7774800a336bd8a23faa62c420 5023280 qemu_2.0.0+dfsg.orig.tar.xz
 9794aac7b0fdc46f86f2abdc42c88687694cf18424e1f91d5fd713d131907be7 204840 qemu_2.0.0+dfsg-2ubuntu1.30.debian.tar.gz
Files: 
 7e665b511772f2780c755a25ffe3d24c 5023280 qemu_2.0.0+dfsg.orig.tar.xz
 dfd8b6c8e64721d3450f019d475d0761 204840 qemu_2.0.0+dfsg-2ubuntu1.30.debian.tar.gz
Debian-Vcs-Browser: http://anonscm.debian.org/gitweb/?p=pkg-qemu/qemu.git
Debian-Vcs-Git: git://anonscm.debian.org/pkg-qemu/qemu.git
Original-Maintainer: Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJYIRw+AAoJEGVp2FWnRL6T2LwP/j7RbB5WfZJEZNQeEGf6HpQU
mrknbHE5MlHnIL1nUNEkF77py7H8aGBvYpewbi+I5HitPV/3d0+v32z98BI8Dovj
puK0HnpAYskU0nGxcMU1sCznS8Bzk2qSpbxOmtjUIt6+aqTZSecHP+aoxwoGUOLP
i/VHfyxYp1V8pDhPAyN+o9YsMere19dAsrAk167VVRNseGpd2cPe9Lw8wXvJRJxW
UeO73UREzgj0iAolLoSSjDGdq2B5T9l96RLI2m+oYonfkfCQG74F4qtFzGCuOa1O
hv/KozmbECTuZIsjKF5C37+2XASB9YEUjZCHOhrKcc7t1nHLa89u/IhlgA/O2shr
L6IE1pK3JUvCvCDiQzJs1i8HHpG6RdzF3SrIfW/41rTruhC6wYu2t4MZEvQmwzfD
1f9SMBBFYIP0UFKjbffalTR5/NDBoNO3vwSZc1GBhsojUrAvMTExB/+p3mXYI+XK
GdLYWDonxAhDXOQBbq/2lTMU+43ljve0TftRYHXhtbdKpUapWVXb6YwqmluZkJNv
CYIof/ByX3EfjCDVbVReblgsF+NbwN/zA1pbV4TYxrCwJrm1aCQPrQ3EJoyhTpGN
CUsxpEIHkDU2VoZ+8Bx1ZDodMZePKwcm3Hu7/Hs9ml65msBFwdZzd59gEKW4DRtO
FNtcjVi0J6oPEYWmW/Hv
=MxMz
-----END PGP SIGNATURE-----
