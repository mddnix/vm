#!/bin/bash


sudo make install

sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo systemctl enable --now grub-btrfs.path

