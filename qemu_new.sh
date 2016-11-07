#!/bin/bash
#
# build qemu with glusterfs support
#

#config
OS_VERSION="$1"
GLUSTER_VERSION="$2"
BUILD_DIR="$(grep build-dir < config.yml | sed 's/build-dir: //')"
APT_SRC_LIST="/etc/apt/src_${OS_VERSION}.list"
PACKAGE="qemu"
PACKAGE_IDENTIFIER="glusterfs${GLUSTER_VERSION}${OS_VERSION}"
PPA="qemu-glusterfs-$(echo ${GLUSTER_VERSION} | cut -c 1-3)"
PPA_OWNER="$(grep ppa-owner < config.yml | sed 's/ppa-owner: //')"
PACKAGEDIR="${BUILD_DIR}/${PACKAGE}_new/"
DEBFULLNAME="$(grep name < config.yml | sed 's/name: //')"
DEBEMAIL="$(grep email < config.yml | sed 's/email: //')"

DEBCOMMENT="with glusterfs ${GLUSTER_VERSION} support"

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
    rsync -av --delete ~/build/#source_downloads/qemu/ ${PACKAGEDIR}
fi

cd ${PACKAGEDIR}

cd $(find ${PACKAGEDIR} -maxdepth 1 -mindepth 1 -type d -name "*${PACKAGE}*")/debian

debchange -l ${PACKAGE_IDENTIFIER} ${DEBCOMMENT} -D ${OS_VERSION}

cp control control.org

#sed 's#\#\#--enable-glusterfs todo#\# --enable-glusterfs\n glusterfs-common,#g' < control.org > control
sed 's#\#\#--enable-glusterfs todo#\# --enable-glusterfs\n glusterfs-common,\n libacl1-dev,#g' < control.org > control

rm control.org

#debuild -us -uc -i -I

debuild -S

dput ppa:${PPA_OWNER}/${PPA} $(find ${PACKAGEDIR} -name qemu*_source.changes)

