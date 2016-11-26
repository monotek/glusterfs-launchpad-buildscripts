#!/bin/bash
#
# build libvirt with glusterfs support
#

if [ ! -f config ];then
    echo "config missing! create config from config.dist example before running this script!"
    exit 1
fi

#config
OS_VERSION="$1"
GLUSTER_VERSION="$2"
PACKAGE="libvirt"

. "config"

#script
if [ -z ${OS_VERSION} ] || [ -z ${GLUSTER_VERSION} ]; then
    echo -e "need os and gluster version! \nUsage: $0 trusty 3.5"
    exit 1
fi

export DEBFULLNAME=${DEBFULLNAME}

export DEBEMAIL=${DEBEMAIL}

if [ "${3}" == "nodelete" ]; then
    echo "no sync! uploading new version!"
else
    rsync -av --delete ${BUILD_DIR}/#source_downloads/${PACKAGE}/ ${PACKAGEDIR}
fi

cd ${PACKAGEDIR}

cd $(find ${REAL_PATH} -maxdepth 2 -mindepth 2 -type d -iname debian)

debchange -l ${PACKAGE_IDENTIFIER} ${DEBCOMMENT} -D ${OS_VERSION}

cp control control.org

sed 's# netcat-openbsd,# netcat-openbsd,\n glusterfs-common,#g' < control.org > control

rm control.org

if [ "${LAUNCHPAD_UPLOAD}" == "yes" ]; then
    debuild -S

    dput ppa:${PPA_OWNER}/${PPA} $(find ${PACKAGEDIR} -iname ${PACKAGE}*gluster*_source.changes | sort | tail -n 1)
else
    debuild -us -uc -i -I
fi
