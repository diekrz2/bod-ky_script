# bod-ky_script
Script that installs and sets up conky for Bodhi Linux or Debian 13 with Moksha DE

It installs **conky** and, if the user wants, **picom**. In particular, the script checks if conky is already installed, if not it will proceed with the installation. Then it asks if the user wants to install picom, which helps to correctly display the transparency of conky on Bodhi Linux. Both will be installed from their respective repositories via 'apt' command. The script also offers to apply a custom .conkyrc file I created and to set up conky (and picom, if installed) to launch automatically at startup. You'll need to reboot for the changes to take effect. 

<img width="402" height="246" alt="screenshot1" src="https://github.com/user-attachments/assets/f11b2e41-1537-4c14-84f6-a41ab194a947" />

**Install:**
------------
Download the _bod-ky_script_ folder. Once the folder is downloaded, you can move there with Terminology and run the script with:
```
bash install.sh
```
>[!NOTE]
>To see the .conkyrc file I made press CTRL + H, edit it as you like. By default my configuration should place conky at the top right screen corner. However, it is possible to adjust the distance from the right edge of the screen by changing the 'gap_x' value in the .conkyrc file
