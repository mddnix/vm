#!/bin/bash

BTRFS_MOUNT="$(df -h --output=source / | grep dev)"
if [[ -z ${BTRFS_MOUNT} ]] ; then
        exit
fi

dnf install -y snapper python3-dnf-plugin-snapper
snapper -c root create-config /
echo "UUID=$(lsblk -dno uuid ${BTRFS_MOUNT}) /.snapshots btrfs subvol=root/.snapshots,compress=zstd:1 0 0" >> /etc/fstab
mount -a
systemctl daemon-reload
sed -i 's/ALLOW_USERS=""/ALLOW_USERS="madhu"/' /etc/snapper/configs/root
chown -R :madhu /.snapshots

echo "----------------"
btrfs subvolume list /
echo
cat /etc/fstab
echo
sleep 2
lsblk -p ${BTRFS_MOUNT}
echo
grep "madhu" /etc/snapper/configs/root
echo
snapper ls
