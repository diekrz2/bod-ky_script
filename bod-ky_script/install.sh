#!/bin/bash


# Script that installs and sets up conky for Bodhi Linux.
# Copyright (C) 2025 diekrz2 diekrz2@protonmail.com 

# "bod-ky_script" is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# "bod-ky_script" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# variable that tracks the user's choice in the 'install_picom' function.

pic_choice="yes"

# function that checks if bash is being used

check_bash(){

if [ -z "$BASH_VERSION" ]; then
   echo "This script requires bash to run. Try again using bash."
   exit 1
fi
}

# function that checks if 'conky' is installed, if not installs it. Accepts "y", "Y", "n" and "N" as answers

install_conky(){

	echo "Checking if 'conky' is already installed..."
 	echo
	sleep 2
	
	if ! command -v conky &>/dev/null; then
		
		echo "'conky' is not installed. Installing..."
  		echo
		sleep 2

		sudo apt update
		sudo apt install conky-all -y
  		echo

		if [ $? -eq 0 ]; then
			echo "'conky' has been installed."
   			echo
		else
			echo "Error during 'conky' installation"
			exit 1
		fi
	
 	else
		echo "'conky' is already installed"
  		echo
	fi
}

# function that checks if 'picom' is installed, if not it suggests to install it. Accepts "y", "Y", "n" and "N" as answers

install_picom(){

	echo "Checking if 'picom' is already installed..."
 	echo
	sleep 2
	
	if ! command -v picom &>/dev/null; then
		
		echo "'picom' is not installed. The compositor helps to display conky transparency correctly. Proceed? (Y/n)"
  		echo
		read -r pic_install
  		echo
		if [[ "$pic_install" =~ ^[yY]$ ]]; then				

		sudo apt install picom -y
  		echo

			if [ $? -eq 0 ]; then
				echo "'picom' has been installed."
    				echo
			else
				echo "Error during 'picom' installation"
				exit 1
			fi

		elif [[ "$pic_install" =~ ^[nN]$ ]]; then

			echo "Operation cancelled"
   			echo
   			pic_choice="no"

  		else
			echo "Invalid input. Please respond with 'y' or 'n'."
 			echo
		
  		fi

  
	else
		echo "'picom' is already installed"
  		echo
	fi
}

# function that asks whether to replace the default .conkyrc file with the one included with the script. Accepts "y", "Y", "n" and "N" as answers

replace_conkyrc(){

	local source_file=".conkyrc"
	local target_file="$HOME/.conkyrc"

	echo "Do you want to use the '.conkyrc' configuration file included with this script? (Y/n)"
	echo
	read -r replace
 	echo

	if [[ "$replace" =~ ^[yY]$ ]]; then
		if [ -f "$source_file" ]; then
			cp "$source_file" "$target_file"
			echo "The file .conkyrc has been replaced"
   			echo
			sleep 2
		else	
			echo "Error: conky configuration file not found"		
			exit 1
		fi
	elif [[ "$replace" =~ ^[nN]$ ]]; then
		echo "Operation cancelled"
  		echo
	else
		echo "Invalid input. Please respond with 'y' or 'n'."
  		echo

	fi

}


# function that asks whether to launch 'conky and 'picom' at PC startup. Intended for Moksha DE. Accepts "y", "Y", "n" and "N" as answers

enable_autostart(){

	local startup_file="$HOME/.e/e/applications/startup/startupcommands"

	echo "Do you want to enable 'conky' and 'picom' (if you decided to install it) on startup? (Y/n)"
 	echo
	read -r autostart
 	echo

	if [[ "$autostart" =~ ^[yY]$ ]]; then
		mkdir -p "$(dirname "$startup_file")"
		touch "$startup_file"

	   if ! grep -qx "conky" "$startup_file"; then
		echo "conky" >> "$startup_file"
		echo "'conky' has been configured to start automatically"
  		echo

	   else
		echo "'conky' is already configured to start automatically"
  		echo
	   fi

	   if [[ "$pic_choice" == "yes" ]]; then
			if ! grep -qx "picom" "$startup_file"; then
				echo "picom" >> "$startup_file"
				echo "'picom' has been configured to start automatically"
				echo

				else
				echo "'picom' is already configured to start automatically"
				echo
			fi
  
	   fi
  

	elif [[ "$autostart" =~ ^[nN]$ ]]; then
		echo "Operation cancelled"
  		echo
	else
		echo "Invalid input. Please respond with 'y' or 'n'."
  		echo
		
	fi
}

# main function to execute the other functions in order. 

main(){

check_bash
install_conky
install_picom
replace_conkyrc
enable_autostart

}

main

# code section that suggests restarting the PC at the end of the script. If you choose to not restart, you will need to start conky and picom manually.

echo "Operations completed successfully"
echo
sleep 2
echo "Do you want to restart the PC now? (Y/n)"
echo
read -r answ
echo

if [[ "$answ" =~ ^[yY]$ ]]; then
	sudo reboot
elif [[ "$answ" =~ ^[nN]$ ]]; then
	echo "Operation cancelled"
else
	echo "Invalid input. Please respond with 'y' or 'n'."
 	echo
fi

