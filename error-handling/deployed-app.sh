#!/bin/bash

# Deploy a Django app using Docker

code_clone() {
    echo "Cloning the git repo"

    if [ -d "django-notes-app" ]; then
        echo "Repository already exists"
        cd django-notes-app || exit 1
        git pull
        cd ..
    else
        git clone https://github.com/LondheShubham153/django-notes-app.git
    fi
}

install_req() {
    echo "Installing dependencies"
    sudo apt-get update -y
    sudo apt-get install docker.io nginx git -y
}

required_restart() {
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo systemctl enable nginx
    sudo systemctl start nginx
}

deploy() {
    cd django-notes-app || exit 1

    echo "Building Docker image..."
    sudo docker build -t notes-app .

    # Stop old container if exists
    if sudo docker ps -a --format '{{.Names}}' | grep -q "notes-app"; then
        echo "Stopping old container..."
        sudo docker stop notes-app
        sudo docker rm notes-app
    fi

    echo "Running container..."
    sudo docker run -d -p 8000:8000 --name notes-app notes-app:latest

    cd ..
}

echo "******** Deployment started ********"

if ! code_clone; then
    echo "Code clone failed"
    exit 1
fi

if ! install_req; then
    echo "Installation failed"
    exit 1
fi

if ! required_restart; then
    echo "Service restart failed"
    exit 1
fi

if ! deploy; then
    echo "Deployment failed"
    exit 1
fi

echo "******** Deployment done successfully ********"
