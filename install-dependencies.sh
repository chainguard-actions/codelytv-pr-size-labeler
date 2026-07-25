#!/bin/bash

## bashunit
curl -fsSL -o /tmp/bashunit-install.sh https://bashunit.typeddevs.com/install.sh
bash /tmp/bashunit-install.sh lib 0.11.0
rm -f /tmp/bashunit-install.sh
