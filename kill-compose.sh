#!/bin/bash
set -euo pipefail

# get script location
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# location where the user is
INVOCATION_DIR="$PWD"

# kill the podman compose stack
podman compose -f "$SCRIPT_DIR/podman-compose.generated.yml" down
