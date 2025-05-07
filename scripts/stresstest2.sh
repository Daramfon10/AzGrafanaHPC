#!/bin/bash

WORKDIR=$(pwd)/workspace/
NCCL_TEST_BIN=${WORKDIR}nccl-tests/build/all_reduce_perf
TRAIN_RESNET_BIN=${WORKDIR}train_resnet.py

echo $NCCL_TEST_BIN
while true; do
  #echo "Step 1: Starting dd write at $(date)..."
  #dd if=/dev/zero of=${WORKDIR}da-nfs-mount5/testfile bs=1M count=1024 oflag=direct

  #echo "Step 2: Starting dd read at $(date)..."
  #dd if=${WORKDIR}da-nfs-mount5/testfile of=/dev/null bs=1M iflag=direct
  #rm -f ${WORKDIR}da-nfs-mount5/testfile

  echo "Step 3: Starting NCCL test at $(date)..."
  $NCCL_TEST_BIN -b 8 -e 512M -f 2 -g 8 -t 120
  echo "Step 4: Finished NCCL at $(date)"

  echo "Sleeping for 10s..."
  sleep 10

  echo "Step 5: Starting TensorFlow training at $(date)..."
  python3 $TRAIN_RESNET_BIN
  echo "Step 6: Finished TensorFlow training at $(date)"

  echo "Completed one full cycle at $(date)... Sleeping 30s."
  sleep 30
done

