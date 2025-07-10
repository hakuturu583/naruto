#!/bin/bash
set -e

# Function to pull Docker image if specified
pull_docker_image() {
    if [ -n "$DOCKER_IMAGE_TO_PULL" ]; then
        echo "Pulling Docker image: $DOCKER_IMAGE_TO_PULL"
        # Start Docker daemon if not running
        if ! docker info >/dev/null 2>&1; then
            echo "Starting Docker daemon..."
            dockerd &
            # Wait for Docker daemon to start
            timeout=30
            while ! docker info >/dev/null 2>&1; do
                if [ $timeout -eq 0 ]; then
                    echo "Error: Docker daemon failed to start"
                    exit 1
                fi
                sleep 1
                timeout=$((timeout - 1))
            done
            echo "Docker daemon started successfully"
        fi

        # Pull the specified image
        if docker pull "$DOCKER_IMAGE_TO_PULL"; then
            echo "Successfully pulled Docker image: $DOCKER_IMAGE_TO_PULL"
        else
            echo "Warning: Failed to pull Docker image: $DOCKER_IMAGE_TO_PULL"
        fi
    else
        echo "No Docker image specified (DOCKER_IMAGE_TO_PULL is not set)"
    fi
}

# Pull Docker image if specified
pull_docker_image

# Execute the original command
exec "$@"
