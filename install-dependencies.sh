#!/bin/bash

## bashunit
# Download the install script to a temporary file before executing it
# to avoid piping untrusted remote content directly into bash.
_bashunit_install_script="$(mktemp)"
curl -fsSL https://bashunit.typeddevs.com/install.sh -o "$_bashunit_install_script"
bash "$_bashunit_install_script" lib 0.11.0
rm -f "$_bashunit_install_script"
