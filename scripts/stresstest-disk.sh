#!/bin/bash

WORKDIR=$(pwd)/
while true; do
  dd if=/dev/zero of=${WORKDIR}da-nfs-mount5/testfile bs=1M count=1024 oflag=direct
  dd if=${WORKDIR}da-nfs-mount5/testfile of=/dev/null bs=1M iflag=direct
  rm -f ${WORKDIR}da-nfs-mount5/testfile
  sleep 10
done

