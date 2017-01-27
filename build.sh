#!/bin/bash
#
# build package with glusterfs support
#

if [ ! -f config ];then
    echo "config missing! create config from config.dist example before running this script!"
    exit 1
fi

#script
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ] ; then
    echo -e "need os, package and gluster version! \nUsage: $0 trusty libvirt 3.8.8"
    exit 1
fi

#config
OS_VERSION="$1"
PACKAGE="$2"
GLUSTER_VERSION="$3"

. config

# build
export DEBFULLNAME=${DEBFULLNAME}

export DEBEMAIL=${DEBEMAIL}

if [ "$4" != "nodelete" ]; then

    sudo sh -c "sed "s/#OS_VERSION#/${OS_VERSION}/g" < sources.list.d/ubuntu-src.dist > /etc/apt/sources.list.d/ubuntu-src.list"

    sudo apt-get update

    test -d ${PACKAGEDIR} && rm -r ${PACKAGEDIR}

    mkdir -p ${PACKAGEDIR}

fi

cd ${PACKAGEDIR}

if [ "$4" != "nodelete" ]; then

    apt-get source ${PACKAGE}/${OS_VERSION}

fi

REAL_PATH="$(realpath .)"

cd $(find ${REAL_PATH} -maxdepth 2 -mindepth 2 -type d -iname debian)

debchange -l ${PACKAGE_IDENTIFIER} ${DEBCOMMENT} -D ${OS_VERSION}

if [ "$4" != "nodelete" ]; then

    . ${REAL_PATH}/../../modify_source.sh

fi

if [ "${LAUNCHPAD_UPLOAD}" == "yes" ]; then
    debuild -S
    dput ppa:${PPA_OWNER}/${PPA} $(find ${REAL_PATH} -name ${PACKAGE}*gluster*_source.changes | sort | tail -n 1)
else
    debuild -us -uc -i -I
fi
