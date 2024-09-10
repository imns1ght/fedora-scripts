#!/bin/bash

echo ">>> Installing updates before installing the Nvidia driver"
# Perform the update and capture output
update_output=$(sudo dnf update -y)
# Inform the user about the update completion
echo ">>> Update completed"
# Check if there were any updates applied
if echo "$update_output" | grep -q 'Upgraded:'; then
  echo ">>> Updates were installed. The system will restart now."
  echo "Restarting in 10 seconds..."
  sleep 10
  # Restart the system
  sudo shutdown -r now
else
  echo ">>> No updates were applied. No need to restart."
fi

echo ">>> Preparing to enable Secure Boot"
sudo dnf install kmodtool akmods mokutil openssl -y
echo ">>> Generating key"
echo ">>> Please insert the password when prompted"
sudo kmodgenca -a
echo ">>> Importing the key"
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
echo ">>> Restarting in 10 seconds"
sleep 10
sudo shutdown -r now

echo ">>> Installing Nvidia drivers"
sudo dnf install akmod-nvidia -y             # Use kmod-nvidia for RHEL/CentOS
sudo dnf install xorg-x11-drv-nvidia-cuda -y # Optional for CUDA support
# Check if the Nvidia module is loaded and has a version
if modinfo -F version nvidia >/dev/null 2>&1; then
  echo ">>> Nvidia driver installation successful. The system will restart now."
  echo "Restarting in 10 seconds..."
  sleep 10
  # Restart the system
  sudo shutdown -r now
else
  echo ">>> Nvidia driver installation failed or the driver is not loaded. Please check the installation logs."
fi

## Should add nvidia.NVreg_EnableGpuFirmware=0 to improve 555 driver version performance.
