#!/bin/bash

# Debug: Print the current directory
echo "Current directory: $(pwd)"

# Navigate to the project directory update with your path from ~/.local/share/applications/
cd /home/fh/code/Dev/playground/foxPOS

# Debug: Print the new current directory
echo "Navigated to directory: $(pwd)"

# Check if docker-compose.prod.yml exists
if [ ! -f docker-compose.prod.yml ]; then
  echo "docker-compose.prod.yml not found in the directory. Please check the path."
  exit 1
fi

# stop the running container
echo "Stopping the running container..."
sudo docker-compose -f docker-compose.prod.yml down

# Start Docker Compose using the production configuration
echo "Starting Docker Compose..."
sudo docker-compose -f docker-compose.prod.yml --env-file .env  up --build

# Wait for the application to start (adjust the sleep time if necessary)
echo "Waiting for the application to start..."
sleep 15


# Manually launch the PWA
# Debug: Check if the application is running
# echo "Checking if the application is running..."
# if curl --output /dev/null --silent --head --fail http://localhost:3000; then
#   echo "Application is running. Launching the PWA..."
#   # Launch the installed PWA
#   gtk-launch FoxPos
# else
#   echo "Application is not running. Please check the Docker logs."
#   exit 1
# fi
