#!/bin/bash

read -p "Enter the name: " username

if [[ $username == "aman" ]]; then
    echo "It is correct"
else
    echo "It is not correct"
fi
