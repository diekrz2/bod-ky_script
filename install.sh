#!/bin/bash


# Script that installs and sets up conky for Bodhi Linux.
# Copyright (C) 2025 diekrz2

# "bod-ky_script" is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# "bod-ky_script" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.


#function that checks if bash is being used

check_bash(){

if [ -z "$BASH_VERSION" ]; then
   echo "This script requires bash to run. Try again using bash."
   exit 1
fi
}

#function that checks if 'conky' is installed, if not installs it. Accepts "y", "Y", "n" and "N" as answers

install_conky(){

	echo "Checking if 'conky' is already installed..."
	sleep 2
	
	if ! command -v conky &>/dev/null; then
		
		echo "'conky' is not installed. Installing..."
		sleep 2

		sudo apt update
		sudo apt install conky-all -y

		if [ $? -eq 0 ]; then
			echo "'conky' has been installed."
		else
			echo "Error during 'conky' installation"
			exit 1
		fi
	else
		echo "'conky' is already installed"
	fi
}

#function that checks if 'picom' is installed, if not it suggests to install it. Accepts "y", "Y", "n" and "N" as answers

install_picom(){

	echo "Checking if 'picom' is already installed..."
	sleep 2
	
	if ! command -v picom &>/dev/null; then
		
		echo "'picom' is not installed. If you are using Bodhi Linux it's recommended to install it. Proceed? (Y/n)"
		read -r pic_install
		if [[ "$pic_install" =~ ^[yY]$ ]]; then				

		sudo apt install picom -y

			if [ $? -eq 0 ]; then
				echo "'picom' has been installed."
			else
				echo "Error during 'picom' installation"
				exit 1
			fi

		elif [[ "$pic_install" =~ ^[nN]$ ]]; then

			echo "Operation cancelled"
		fi
	else
		echo "'picom' is already installed"
	fi
}

#function that asks whether to replace the default .conkyrc file with the one included with the script. Accepts "y", "Y", "n" and "N" as answers

replace_conkyrc(){

	local source_file=".conkyrc"
	local target_file="$HOME/.conkyrc"

	echo "Do you want to use the '.conkyrc' configuration file included with this script? (Y/n)"
	
	read -r replace

	if [[ "$replace" =~ ^[yY]$ ]]; then
		if [ -f "$source_file" ]; then
			cp "$source_file" "$target_file"
			echo "The file .conkyrc has been replaced"
			sleep 2
		else	
			echo "Error: conky configuration file not found"		
			exit 1
		fi
	elif [[ "$replace" =~ ^[nN]$ ]]; then
		echo "Operation cancelled"
	else
		echo "Invalid input. Please respond with 'y' or 'n'."

	fi

}


#function that asks whether to launch 'conky and 'picom' at PC startup. Intended for Moksha DE. Accepts "y", "Y", "n" and "N" as answers

enable_autostart(){

	local startup_file="$HOME/.e/e/applications/startup/startupcommands"

	echo "Do you want to enable 'conky' and 'picom' (if you decided to install it) on startup? (Y/n)"
	read -r autostart

	if [[ "$autostart" =~ ^[yY]$ ]]; then
		mkdir -p "$(dirname "$startup_file")"
		touch "$startup_file"

	   if ! grep -qx "conky" "$startup_file"; then
		echo "conky" >> "$startup_file"
		echo "'conky' has been configured to start automatically"

	   else
		echo "'conky' is already configured to start automatically"
	   fi

	   if ! grep -qx "picom" "$startup_file"; then
		echo "picom" >> "$startup_file"
		echo "'picom' has been configured to start automatically"

	   else
		echo "'picom' is already configured to start automatically"
	   fi
  

	elif [[ "$autostart" =~ ^[nN]$ ]]; then
		echo "Operation cancelled"
	else
		echo "Invalid input. Please respond with 'y' or 'n'."
		
	fi
}

#main function to execute the other functions in order. 

main(){

check_bash
install_conky
install_picom
replace_conkyrc
enable_autostart

}

main

#code section that suggests restarting the PC at the end of the script. If you choose to not restart, you will need to start conky and picom manually.

echo "Operations completed successfully"
sleep 3
echo "Do you want to restart the PC now? (Y/n)"
read -r answ

if [[ "$answ" =~ ^[yY]$ ]]; then
	reboot
elif [[ "$answ" =~ ^[nN]$ ]]; then
	echo "Operation cancelled"
else
	echo "Invalid input. Please respond with 'y' or 'n'."
fi





