#!/bin/bash
#
# modify sources
#

echo "modifying source..."

if [ "${PACKAGE}" == "libvirt" ]; then
  sed -i 's# netcat-openbsd,# netcat-openbsd,\n glusterfs-common,\n libacl1-dev,#g' control
elif [ "${PACKAGE}" == "qemu" ]; then
  sed -i 's#\#\#--enable-glusterfs todo#\# --enable-glusterfs\n glusterfs-common,\n libacl1-dev,#g' control
elif [ "${PACKAGE}" == "samba" ]; then
  sed -i 's#bison,#bison,\n               glusterfs-common,\n               libacl1-dev,#' control
elif [ "${PACKAGE}" == "tgt" ]; then
  sed -i -e 's#, libsystemd-dev#, libsystemd-dev, glusterfs-common, libacl1-dev#' -e 's#Package: tgt-dbg#Package: tgt-glusterfs\nArchitecture: linux-any\nDepends: tgt (= ${binary:Version}), ${shlibs:Depends}, ${misc:Depends}\nDescription: Linux SCSI target user-space daemon and tools - GlusterFS support\n The Linux target framework (tgt) allows a Linux system to provide SCSI\n devices (targets) over networked SCSI transports.\n .\n tgt consists of a user-space daemon and user-space tools currently\n supporting the following transports:\n .\n  - iSCSI (SCSI over IP)\n  - iSER (iSCSI over RDMA, using Infiniband)\n .\n tgt also supports different storage types for use as backing stores for SCSI\n Logical Units:\n .\n  - Plain files and block devices\n  - Ceph/RADOS RBD volumes\n  - GlusterFS volumes\n .\n This package enables tgt to use GlusterFS volumes as backing store for SCSI\n Logical Units.\n\nPackage: tgt-dbg#' control
  echo "debian/tgt/usr/lib/tgt/backing-store/bs_glfs.so usr/lib/tgt/backing-store" > tgt-glusterfs.install
  sed -i 's#CEPH_RBD=1#CEPH_RBD=1 GLFS_BD=1#' rules
fi
