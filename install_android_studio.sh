#!/bin/bash
pathToFile=$(ls ~/Downloads | grep 'android-studio')
desktopEntryFile="/usr/share/applications/android-studio.desktop"

if [ -n "$pathToFile" ]; then
  sudo mkdir -p /opt/android-studio
	sudo tar -zxvf ~/Downloads/"$pathToFile" -C /opt ## should extract to /opt/android-studio using root permissions
	
	sudo ln -sf /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio

	sudo bash -c "cat > $desktopEntryFile <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Android Studio
Comment=Android Studio IDE
Exec=/opt/android-studio/bin/studio.sh %f
Icon=/opt/android-studio/bin/studio.png
Categories=Development;IDE;
Terminal=false
StartupNotify=true
StartupWMClass=jetbrains-android-studio
EOF"
	
	sudo chmod +x $desktopEntryFile
	echo ">>> Android Studio has been installed and a desktop entry has been created."

else
	echo ">>> You should download android-studio: https://developer.android.com/studio"
fi
