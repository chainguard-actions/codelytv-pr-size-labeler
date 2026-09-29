#!/bin/bash
set -euo pipefail

## bashunit
BASHUNIT_INSTALL_SCRIPT="$(mktemp)"
curl -fsSL https://bashunit.com/install.sh -o "$BASHUNIT_INSTALL_SCRIPT"
bash "$BASHUNIT_INSTALL_SCRIPT" lib 0.51.0
rm -f "$BASHUNIT_INSTALL_SCRIPT"
