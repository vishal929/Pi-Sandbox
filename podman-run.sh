#!/bin/bash
set -euo pipefail
# if build was specified, we run the build first
if [[ -n "$1" ]]; then
    podman build -t pisandbox:latest -f Dockerfile
fi

# runs the pi harness image interactively via podman run
podman run -it pisandbox:latest