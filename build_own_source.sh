#!/bin/bash
#
# build package with glusterfs support from own sources
#

set -e

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

REAL_PATH="$(realpath .)"

cd $(find ${REAL_PATH} -maxdepth 2 -mindepth 2 -type d -iname debian)

debchange -l ${PACKAGE_IDENTIFIER} ${DEBCOMMENT} -D ${OS_VERSION}

. ${REAL_PATH}/../../modify_source.sh

if [ "${LAUNCHPAD_UPLOAD}" == "yes" ]; then
  debuild -S

  dput ppa:${PPA_OWNER}/${PPA} $(find ${REAL_PATH} -name ${PACKAGE}*gluster*_source.changes | sort | tail -n 1)
else
  debuild -us -uc -i -I
fi
