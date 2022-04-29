#!/bin/bash

git clone https://github.com/Antynea/grub-btrfs.git
cd grub-btrfs/

vim 41_snapshots-btrfs
boot_dir_root_grub=${boot_dir_root_grub//\/root}

vim config
GRUB_BTRFS_GRUB_DIRNAME="/boot/grub2"
GRUB_BTRFS_MKCONFIG=/usr/sbin/grub2-mkconfig
GRUB_BTRFS_SCRIPT_CHECK=grub2-script-check

sudo make install

sudo grub2-mkconfig -o /boot/grub2/grub.cf
sudo systemctl enable --now grub-btrfs.path

