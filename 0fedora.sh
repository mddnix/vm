#!/bin/bash

echo "defaultyes=true" >> /etc/dnf/dnf.conf
echo "fastestmirror=true" >> /etc/dnf/dnf.conf
echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf

dnf clean all
dnf makecache

dnf remove -y PackageKit-gstreamer-plugin PackageKit PackageKit-command-not-found gnome-software --noautoremove
rm -rf /var/cache/PackageKit

dnf remove -y libreoffice-*
dnf remove -y nano-default-editor --noautoremove
dnf install -y vim vim-default-editor

sed -i '0,/\<Exec=gnome-terminal\>/{s/\<Exec=gnome-terminal\>/Exec=gnome-terminal --maximize/}' /usr/share/applications/org.gnome.Terminal.desktop

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd

grub2-editenv - unset menu_auto_hide

grubby --remove-args "rhgb" --update-kernel=ALL
