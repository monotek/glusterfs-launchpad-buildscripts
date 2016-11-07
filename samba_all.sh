#!/bin/bash
#
# build samba with glusterfs vfs module
#

#config
OS_VERSIONS="trusty wily xenial yakkety"
GLUSTER_VERSIONS="3.7.17 3.8.5"

for OS in ${OS_VERSIONS}; do
    for GLUSTER in ${GLUSTER_VERSIONS}; do

	echo -e "\n#######################\nbuild samba with glusterfs version ${GLUSTER} for OS ${OS}\n#######################\n"

	/bin/bash samba_meta.sh ${OS} ${GLUSTER}

    done

done
