#!/bin/bash
set -euo pipefail

# get script location
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# location where the user is
INVOCATION_DIR="$PWD"

# Define a usage/help function
usage() {
    echo "Usage: $0 [-b] [-v] [-p MNT_POINT]"
    exit 1
}

# Initialize variables to hold flag values
DO_BUILD=false
NEW_VOLUME=false

# Parse the options
# A colon (:) after a letter means that flag requires an argument
while getopts "bvp:" opt; do
    case "${opt}" in
        b)
            DO_BUILD=true
            ;;
        v)
            NEW_VOLUME=true
            ;;
        p)  MNT_POINT="${OPTARG}"
            ;;
        *)
            usage
            ;;
    esac
done

# if build was specified, we run the build first
if $DO_BUILD; then
    podman build -t pisandbox:latest -f Dockerfile
    if [[ $? -ne 0 ]]; then
        echo "failed to build pisandbox image"
        exit 1
    fi
fi

# check to see if a volume for podman exists already
podman volume exists pi-volume
VOLUME_EXISTS=$?
if [[ $VOLUME_EXISTS -eq 0 ]]; then
    # check if we specified the flag to cleanup the volume
    if $NEW_VOLUME; then
        echo "volume exists, cleaning up the volume..."
        podman volume rm pi-volume
        if [[ $? -ne 0 ]]; then
            echo "Failed to clean up pi-volume"
            exit 1
        fi
        echo "Creating new volume pi-volume"
        podman volume create pi-volume
        if [[ $? -ne 0 ]]; then
            echo "Failed to create pi-volume"
            exit 1
        fi
    fi
else
    # volume doesnt exist, make it
    echo "Creating new volume pi-volume"
    podman volume create pi-volume
    if [[ $? -ne 0 ]]; then
        echo "Failed to create pi-volume"
        exit 1
    fi 
fi

# runs the pi harness image interactively via podman run
podman run --rm -it \
    -v pi-volume:/root/.pi/agent/ \
    --env-file $SCRIPT_DIR/credentials/credentials.env \
    ${MNT_POINT:+"-v$INVOCATION_DIR/$MNT_POINT:/home/workspace:Z"}\
    pisandbox:latest 