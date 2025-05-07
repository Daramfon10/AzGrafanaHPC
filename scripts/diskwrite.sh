#!/bin/bash
while true; do
  dd if=/dev/zero of=/home/daramfon/da-nfs-mount5/testfile bs=1M count=1024 oflag=direct
  dd if=/home/daramfon/da-nfs-mount5/testfile of=/dev/null bs=1M iflag=direct
  rm -f /home/daramfon/da-nfs-mount5/testfile
done

