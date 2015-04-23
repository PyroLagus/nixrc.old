#!/run/current-system/sw/bin/bash

#
# This script automates configuration and installation of NixOS. It is intended
# to be run from the within the NixOS live boot medium. Filesystems creation
# and network configuration must be done beforehand, followed by running
# 'nixos-generate-config --root /mnt' (see the NixOS manual).
#

HOSTNAME_FILE="/mnt/etc/nixos/hostname"
NIXRC="/mnt/nixrc"
NIXOS_CONFIG="/mnt/etc/nixos"
UUID_FILE="/sys/class/dmi/id/product_uuid"

# Check for files created by nixos-generate-config first.
if [ ! -d $NIXOS_CONFIG ]; then
  echo "Error: Could not find /mnt/etc/nixos."
  echo "Run 'nixos-generate-config --root /mnt' and review output first."
  exit 1
fi

# Clone the git repository containing the NixOS configuration.
if [ ! -d $NIXRC ]; then
  nix-env --install git
  cd /mnt/
  git clone "https://github.com/C0DEHERO/nixrc" --recursive
fi

# Determine the hostname from either UUID or MAC address.
if grep --quiet "74:d0:2b:ba:da:5b" "/sys/class/net/enp3s0/address"; then
  echo -n "wheatley" > $HOSTNAME_FILE
else
  echo -n "nixos" > $HOSTNAME_FILE
fi

# Rsync files from the git repository to their final destination.
rsync --filter="protect /hardware-configuration.nix" \
           --filter="protect /hostname" \
           --filter="protect /private" \
           --filter="exclude,s *.gitignore" \
           --filter="exclude,s *.gitmodules" \
           --filter="exclude,s *.git" \
           --filter="exclude .*.swp" \
           --filter="exclude Session.vim" \
           --delete --recursive --perms \
           $NIXRC/ $NIXOS_CONFIG/
nixos-install && rm -rf /mnt/nixrc && reboot
