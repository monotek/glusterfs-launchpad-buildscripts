#!/bin/bash
#
# build samba with glusterfs vfs module for all os versions
#

if [ ! -f config ];then
    echo "config missing! create config from config.dist example before running this script!"
    exit 1
fi

#config
. "config"

for OS in ${OS_VERSION_ALL}; do
    for GLUSTER in ${GLUSTER_VERSION_ALL}; do
	echo -e "\n#######################\nbuild samba with glusterfs version ${GLUSTER} for OS ${OS}\n#######################\n"
	/bin/bash samba_meta.sh ${OS} ${GLUSTER}
    done
done
