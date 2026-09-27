# Pi-Sandbox
Environment Sandbox for running the Pi Agent Harness. You need some container runtime like podman or docker. 

## Rootless
For my setup, I am running this image with a rootless podman setup.
This will ensure that the process does not have priviledged access on the host. 

## File Access
The agent only has access to modify the volumes which are mounted by the user in the configuration. 

## Network Access
We use an application-level guard and an http proxy to prevent unwanted network requests made by the pi harness. 

The pi-permission-system will be setup to inspect outgoing requests to make sure they are following the https standard and are not fishy. 

The squid forward http proxy will forward all requests from the pi agent after checking against the allowlist specified in the squid configuration.  

## Dockerfile setup
We rely on the debian trixy slim node image as a base and install other dependencies the agent might need.
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
the credentials/credentials.env file includes exports for API Keys to use with pi harness.

Look at the credentials.env.example accordingly. These env variables are loaded into the process via podman run flags and not included at image build time. 

## run-compose.sh Usage
this script provides options to build and run the pi harness stack I have defined

### arguments
Host directory locations can be passed as argument to be mounted in the pi-agent container under the /home/workspace location. 

i.e ```./run-compose.sh "PATH/TO/Dir1" "PATH/TO/DIR2" ...```

## kill-compose.sh
This will tear down the pi harness stack based on the compose file.
