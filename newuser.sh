#!/bin/bash

# Simple User Add Script. Allows Admin to set username, set password, and add user to a group. 
# Accepts User Input as a variable, verifies the user input, and makes use of IF, Else, and While loops.
# Uses: useradd, passwd, groups, usermod, id, chage

read -p "Enter User Name: " username

# While $username is blank ask for an answer
while [ "$username" = "" ]; do
	read -p "Enter User Name: " username
done

# Create the User
sudo useradd -m $username

# Option to manually set the user password
echo ""
echo "Please note some systems do not support blank Passwords!"
read -p "Do you want to set a Password? (y/n): " addpasswd

# While $addpasswd option is blank ask for an answer
while [ "$addpasswd" != 'y' ] && [ "$addpasswd" != 'n' ]; do
	read -p "Please enter (y)es or (n)o: " addpasswd
done

if [ "$addpasswd" = "y" ]; then
	echo ""
	# Sets the User Password Manually
	sudo passwd $username
	echo ""	
	read -p "Do you want the User to Change their Password? (y/n): " userpasswd
else
	echo ""
	# Deletes the User Password (Making it Blank)
	sudo passwd -d $username
	echo ""
	read -p "Do you want the User to set Password? (y/n): " userpasswd
fi

# While $userpasswd option is blank ask for an answer
while [ "$userpasswd" != "y" ] && [ "$userpasswd" != "n" ]; do
	echo ""
	read -p "Please enter (y)es or (n)o: " userpasswd
done

if [ "$userpasswd" = "y" ]; then
	# Sets the user password to expire upon login so user must change password on login
	echo ""
	echo "User Password will be set to expire upon login!"
	sudo passwd -e $username
fi

# Manually add user to a group
echo ""
read -p "Do you want to add User to a group? (y/n): " addgroup

# While $addgroup option is blank ask for an answer
while [ "$addgroup" != "y" ] && [ "$addgroup" != "n" ]; do
	read -p "Please enter (y)es or (n)o: " addgroup
done

if [ "$addgroup" = "y" ]; then
	echo ""
	# List Groups on System
	echo "List of Groups: "
	sudo groups
	echo ""
	read -p "Add User to which group?: " groupname
       	sudo usermod -a -G $groupname $username	
fi

# Print the New User Information
echo ""
id $username

echo ""
sudo chage -l $username

echo ""
echo "User $username Created Successfully!"
echo ""
