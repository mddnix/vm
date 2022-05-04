#!/bin/bash

grub2-mkconfig -o /boot/grub2/grub.cfg
systemctl enable --now grub-btrfs.path
