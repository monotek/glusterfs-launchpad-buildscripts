#!/bin/bash
#
# build qemu with glusterfs vfs module for all os
#

#config
OS_VERSIONS="trusty wily xenial yakkety"
GLUSTER_VERSIONS="3.7.17 3.8.5"
PACKAGE="qemu"


for OS in ${OS_VERSIONS}; do
    for GLUSTER in ${GLUSTER_VERSIONS}; do
	
	echo -e "\n#######################\nbuild glusterfs version ${GLUSTER} for OS ${OS}\n#######################\n"
	
	/bin/bash qemu_meta.sh ${OS} ${GLUSTER}

    done

done
