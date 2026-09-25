# Pi-Sandbox
Environment Sandbox for running the Pi Agent Harness

## Rootless
For my setup, I am running this image with a rootless podman setup.
This will ensure that the process does not have priviledged access on the host. 

## Network Access
todo, look into wrapping network access based on domain
i.e dont need to ask for permission to hit the AI hosting domain or something like wikipedia

## Dockerfile setup
We rely on the debian trixy slim node image as a base and install other dependencies the agent might need
The entrypoint is the Pi harness CLI itself

## Current dependencies installed in the image
1) @earendil-works/pi-coding-agent
2) sudo
3) git
4) curl
5) jq
6) python3 + pip

## Pi harness extension configuration
These are the extensions that I will be using with Pi

## credential setup
todo, need to mount pi harness provider credentials