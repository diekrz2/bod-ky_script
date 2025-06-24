# bod-ky_script
Script that installs and sets up conky for Bodhi Linux.

Script intended for Bodhi Linux. It installs conky and, if the user wants, picom. In particular, the script checks if conky is already installed, if not it will proceed with the installation. Then it asks if the user wants to install picom, which helps to correctly display the transparency of conky on Bodhi Linux. Both will be installed from their respective repositories via 'apt' command. The script also asks if the user wants to use the .conkyrc file customized by me and to set conky and picom (if installed) to run automatically at startup. The changes will take effect after reboot. 

The screenshot was taken on Bodhi Linux 7, the wallpaper is the default one in the "Arc dark" theme.

![screenshot](https://github.com/user-attachments/assets/85e0e8d4-86cb-45fd-9d29-a9f986c17399)

**Install:**

Download the "bod-ky_script" folder. Once the folder is downloaded, you can move there with Terminology and run the script with "bash install.sh". To see the .conkyrc file I made press CTRL + H, edit it as you like. By default my configuration should place conky at the top right screen corner. However, it is possible to adjust the distance from the right edge of the screen by changing the 'gap_x' value in the .conkyrc file

conky: https://github.com/brndnmtthws/conky

picom: https://github.com/yshui/picom

Bodhi Linux: https://www.bodhilinux.com
