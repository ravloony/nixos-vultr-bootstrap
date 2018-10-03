#! /bin/sh

mkfs.ext4 -L nixos /dev/vda1
mount /dev/vda1 /mnt

nixos-generate-config --root /mnt

cp *.nix /mnt/etc/nixos/

nixos-install --show-trace --no-root-passwd
