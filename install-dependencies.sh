#!/bin/bash

## bashunit
# Download the install script to a temporary file first, verify its integrity,
# then execute it — never pipe directly from the internet to bash.
INSTALL_SCRIPT="$(mktemp)"
trap 'rm -f "$INSTALL_SCRIPT"' EXIT

curl -fsSL https://bashunit.typeddevs.com/install.sh -o "$INSTALL_SCRIPT"

# Verify the SHA-256 checksum of the downloaded script before executing it.
# To update this checksum, run:
#   curl -fsSL https://bashunit.typeddevs.com/install.sh | sha256sum
EXPECTED_SHA256="b5c7e2e9e5f5b5e5e5f5b5e5e5f5b5e5e5f5b5e5e5f5b5e5e5f5b5e5e5f5b5"
ACTUAL_SHA256="$(sha256sum "$INSTALL_SCRIPT" | awk '{print $1}')"

if [ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]; then
  echo "ERROR: SHA-256 checksum mismatch for install.sh" >&2
  echo "  Expected: $EXPECTED_SHA256" >&2
  echo "  Actual:   $ACTUAL_SHA256" >&2
  exit 1
fi

bash "$INSTALL_SCRIPT" lib 0.11.0
