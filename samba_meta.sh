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
    echo -e "need os and gluster version! \nUsage: $0 trusty 3.7.1"
    exit 1
fi

export DEBFULLNAME=${DEBFULLNAME}
export DEBEMAIL=${DEBEMAIL}

sudo sh -c "sed "s/#OS_VERSION#/${OS_VERSION}/g" < sources.list.d/ubuntu-src.dist > /etc/apt/sources.list.d/ubuntu-src.list"

sudo apt-get update

apt-get source ${PACKAGE}/${OS_VERSION}

test -d ${PACKAGEDIR} && rm -r ${PACKAGEDIR}

mkdir -p ${PACKAGEDIR}

cd ${PACKAGEDIR}

cd $(find ${PACKAGEDIR} -maxdepth 1 -mindepth 1 -type d -name "*samba*")/debian

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
