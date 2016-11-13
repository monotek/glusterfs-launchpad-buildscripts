#!/bin/bash
#
# build samba with glusterfs vfs module
#

if [ ! -f config ];then
    echo "config missing! create config from config.dist example before running this script!"
    exit 1
fi

#config
OS_VERSION="$1"
GLUSTER_VERSION="$2"
PACKAGE="samba"

. "config"

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
    rsync -av --delete ${BUILD_DIR}/#source_downloads/samba/ ${PACKAGEDIR}
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

if [ "${LAUNCHPAD_UPLOAD}" == "yes" ]; then
    debuild -S

    dput ppa:${PPA_OWNER}/${PPA} $(find ${PACKAGEDIR} -name ${PACKAGE}*gluster*_source.changes | sort | tail -n 1)
else
    debuild -us -uc -i -I
fi

