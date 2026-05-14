#!/bin/bash

## bashunit
# Download the install script to a temporary file first, then execute it
# separately. Never pipe remote content directly to bash, as that allows
# arbitrary code execution from a remote server without integrity verification.
INSTALL_SCRIPT="$(mktemp)"
trap 'rm -f "${INSTALL_SCRIPT}"' EXIT

curl -fsSL https://bashunit.typeddevs.com/install.sh -o "${INSTALL_SCRIPT}"

bash "${INSTALL_SCRIPT}" lib 0.11.0
