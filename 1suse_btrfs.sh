#!/bin/bash

echo 'SUSE_BTRFS_SNAPSHOT_BOOTING="true"' >> /etc/default/grub
rm -rf /boot/loader/entries/*.conf
kernel-install -v add $(uname -r) /lib/modules/$(uname -r)/vmlinuz
grub2-mkconfig -o /boot/grub2/grub.cfg
btrfs subvolume set-default 256 /
sed -i '1i set btrfs_relative_path="yes"' /boot/efi/EFI/fedora/grub.cfg
sed -i 's#/root/boot/grub2#/boot/grub2#' /boot/efi/EFI/fedora/grub.cfg

echo "----------------"
btrfs subvolume list /
echo
btrfs subvolume get-default /
echo
grubby --info=DEFAULT
echo
cat /boot/efi/EFI/fedora/grub.cfg
