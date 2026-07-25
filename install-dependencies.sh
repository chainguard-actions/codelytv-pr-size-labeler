#!/bin/bash

## bashunit
INSTALL_SCRIPT="$(mktemp)"
curl -fsSL -o "$INSTALL_SCRIPT" https://bashunit.typeddevs.com/install.sh
bash "$INSTALL_SCRIPT" lib 0.11.0
rm -f "$INSTALL_SCRIPT"
