#!/bin/bash

echo ">>> Enabling virutalization support"
sudo dnf install @virtualization -y
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
if lsmod | grep -q -E 'kvm_(amd|intel)'; then
	echo ">>> Successfully enabled!"
else
	echo ">>> Error: Something went wrong..."
fi
