#!/bin/bash
#
# build samba with glusterfs vfs module
#

#config
OS_VERSION="$1"
GLUSTER_VERSION="$2"
PACKAGE="samba-vfs-modules"
PACKAGE_IDENTIFIER="glusterfs${GLUSTER_VERSION}${OS_VERSION}"
PPA="samba-vfs-glusterfs-$(echo ${GLUSTER_VERSION} | cut -c 1-3)"
PPA_OWNER="$(grep ppa-owner < config.yml | sed 's/ppa-owner: //')"
PACKAGEDIR="~/build/${PACKAGE}_new/"
DEBFULLNAME="$(grep name < config.yml | sed 's/name: //')"
DEBEMAIL="$(grep email < config.yml | sed 's/email: //')"
DEBCOMMENT="with vfs module for ${PACKAGE_IDENTIFIER}"

#script
if [ -z ${OS_VERSION} ] || [ -z ${GLUSTER_VERSION} ]; then
    echo -e "need os and gluster version! \nUsage: $0 trusty 3.5.4"
    exit 1
fi

export DEBFULLNAME=${DEBFULLNAME}

export DEBEMAIL=${DEBEMAIL}

export QUILT_PATCHES=debian/patches

if [ "${3}" == "nodelete" ]; then
    echo "no sync! uploading new version!"
else
    rsync -av --delete /home/abauer/build/#source_downloads/samba/ ${PACKAGEDIR}
fi

#cd $(find ${PACKAGEDIR} -maxdepth 1 -mindepth 1 -type d -name "*samba-*")
#export QUILT_PATCHES=debian/patches
#quilt new bug_11115_vfs_glusterfs_fix
#quilt add source3/smbd/service.c
# In source3/smbd/service.c::close_cnum(), vfs_ChDir() is called after SMB_VFS_DISCONNECT(). This can cause the problem for other vfs modules.
#mcedit source3/smbd/service.c
#quilt refresh -p ab

cd $(find ${PACKAGEDIR} -maxdepth 1 -mindepth 1 -type d -name "*samba-*")/debian

debchange -l ${PACKAGE_IDENTIFIER} ${DEBCOMMENT} -D ${OS_VERSION}

cp control control.org

sed 's#bison,#bison,\n               glusterfs-common,#' < control.org > control

rm control.org

#debuild -us -uc -i -I

debuild -S

dput ppa:${PPA_OWNER}/${PPA} $(find ${PACKAGEDIR} -name samba*_source.changes | sort | tail -n1)

