#!/bin/sh

# Prevent OneNAND SPOR(Sudden Power Off Recovery) problem
# OneNAND & FSR cannot protect from SPOR failure 100%.
# Therefore we need to reduce the possibility when Power Off.
# TDcSystem calls this script(umount_partition.sh) after issuing "sync". It's time just before commanding Power Off to SubMicom

echo "Blocking OneNAND flash writing" > /proc/LinuStoreIII/stl-lock
