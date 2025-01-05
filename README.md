# bod-ky_script
Script that installs and sets up conky for Bodhi Linux.

Script designed for Bodhi Linux that installs conky and, if the user wants, picom. In particular, the script checks if conky is already installed, if not it will proceed with the installation. Then it asks if you want to install picom, which is necessary to correctly display the transparency of conky on Bodhi Linux. Both will be installed from their respective ubuntu repositories via apt command. The script also asks if you want to replace the default .conkyrc file with my customized one and if you want to set conky and picom (if installed) to start automatically. The changes will take effect after reboot. 

The screenshot was taken on Bodhi Linux 7, the wallpaper is the default one in the "Arc dark" theme.

![screenshot](https://github.com/user-attachments/assets/85e0e8d4-86cb-45fd-9d29-a9f986c17399)

Once the folder is downloaded, you can move there with the terminology and start with "bash install.sh". To see the .conkyrc file I made press CTRL + H, edit it as you like. By default my configuration should place conky at the top right screen corner.

