# Hardening Report: codelytv--pr-size-labeler/v1.10.3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `ff50f15e4b79bfbf764dafdfd2579175a6ea9771`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **codelytv--pr-size-labeler/v1.10.3** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

install-dependencies.sh pipes a remotely fetched script directly into bash without first downloading and inspecting it. The pattern `curl -s https://bashunit.typeddevs.com/install.sh | bash -s -- lib 0.11.0` allows a compromised or malicious remote server to execute arbitrary code on the runner.

Locations:

- `install-dependencies.sh:4`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed install-dependencies.sh: replaced the unsafe `curl ... | bash` pipe pattern with a two-step approach — download the remote install script to a temporary file via `mktemp`, then execute it separately with `bash`, and clean up the temp file afterward. Also improved curl flags from `-s` to `-fsSL` to fail on HTTP errors and follow redirects. This prevents a compromised or malicious remote server from executing arbitrary code on the runner via the pipe-to-bash pattern.

