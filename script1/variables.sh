#!/bin/bash
 name="aman"
 echo "name is $name and date $(date)"
#insert from the users
read -p "enher the user name " username
echo "name $username"
sudo useradd -m $username
echo "new user added"
