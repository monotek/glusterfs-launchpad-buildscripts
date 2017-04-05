#!/bin/bash
#
# build all packages with glusterfs support for all os versions
#

if [ ! -f config ];then
  echo "config missing! create config from config.dist example before running this script!"
  exit 1
fi

#config
. "config"

for PACKAGE in ${PACKAGES}; do
  for OS in ${OS_VERSION_ALL}; do
    if [ "${PACKAGE}" == "tgt" ] && [ "${OS}" == "trusty" ]; then
      echo "don't build tgt for trusty..."
    else
      for GLUSTER in ${GLUSTER_VERSION_ALL}; do
        echo -e "\n#######################\nbuild ${PACKAGE} with GlusterFS version ${GLUSTER} for OS ${OS}\n#######################\n"
        /bin/bash build.sh ${OS} ${PACKAGE} ${GLUSTER}
      done
    fi
  done
done
