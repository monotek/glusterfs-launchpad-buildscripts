#!/bin/bash
#
# build package with glusterfs support from own sources
#

if [ ! -f config ];then
    echo "config missing! create config from config.dist example before running this script!"
    exit 1
fi

#script
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] ; then
    echo -e "need os and gluster version! \nUsage: $0 trusty libvirt 3.8.6"
    exit 1
fi

#config
OS_VERSION="$1"
PACKAGE="$2"
GLUSTER_VERSION="$3"

. "config"

# build
export DEBFULLNAME=${DEBFULLNAME}

export DEBEMAIL=${DEBEMAIL}

test -d ${SRC_DOWNLOAD_DIR} || mkdir -p ${SRC_DOWNLOAD_DIR}

if [ ! -d "${SRC_DOWNLOAD_DIR}/${PACKAGE}/" ]; then
    echo "no source downloads found. download sources to ${SRC_DOWNLOAD_DIR}/${PACKAGE}/ first!"
    exit 1
fi

if [ "${4}" == "nodelete" ]; then
    echo "no sync! uploading new version!"
else
    rsync -av --delete ${SRC_DOWNLOAD_DIR}/${PACKAGE}/ ${PACKAGEDIR}
fi

cd ${PACKAGEDIR}

cd $(find ${PACKAGEDIR} -maxdepth 1 -mindepth 1 -type d -name "*${PACKAGE}*")/debian

debchange -l ${PACKAGE_IDENTIFIER} ${DEBCOMMENT} -D ${OS_VERSION}

cp control control.org

if [ "${PACKAGE}" == "libvirt" ]; then
    sed 's# netcat-openbsd,# netcat-openbsd,\n glusterfs-common,\n libacl1-dev,#g' < control.org > control
elif [ "${PACKAGE}" == "qemu" ]; then
    sed 's#\#\#--enable-glusterfs todo#\# --enable-glusterfs\n glusterfs-common,\n libacl1-dev,#g' < control.org > control
elif [ "${PACKAGE}" == "samba" ]; then
    sed 's#bison,#bison,\n               glusterfs-common,\n               libacl1-dev,#' < control.org > control
fi

rm control.org

if [ "${LAUNCHPAD_UPLOAD}" == "yes" ]; then
    debuild -S

    dput ppa:${PPA_OWNER}/${PPA} $(find ${PACKAGEDIR} -name ${PACKAGE}*gluster*_source.changes | sort | tail -n 1)
else
    debuild -us -uc -i -I
fi
