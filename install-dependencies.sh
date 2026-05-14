#!/bin/bash

## bashunit
# Download the install script first, then execute it separately (never pipe from internet to shell)
curl -fsSL -o /tmp/bashunit-install.sh https://bashunit.typeddevs.com/install.sh
bash /tmp/bashunit-install.sh lib 0.10.0
rm -f /tmp/bashunit-install.sh
