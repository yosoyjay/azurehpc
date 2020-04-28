#!/bin/bash

HOSTLIST=$1
REPLICA=$2

GLUSTERFS_VOL_NAME=gv0
mkdir -p /mnt/brick1/$GLUSTERFS_VOL_NAME

mkdir 

if [ "$PSSH_NODENUM" = "0" ]; then
   for host in `cat hostlists/$HOSTLIST`
   do
      hosts_str=${host_str}"$host:/mnt/brick1/$GLUSTERFS_VOL_NAME "
   done
   echo $hosts_str

   replica_str=""
   if [ $REPLICA -gt 0 ]; then
      replica_str="replica $REPLICA"
   fi

   gluster volume create $GLUSTERFS_VOL_NAME $replica_str $hosts_str

   gluster volume start $GLUSTERFS_VOL_NAME

   gluster volume info
fi
