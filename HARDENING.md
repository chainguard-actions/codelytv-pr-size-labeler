# Hardening Report: codelytv--pr-size-labeler/v1.10.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `ff50f15e4b79bfbf764dafdfd2579175a6ea9771`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **codelytv--pr-size-labeler/v1.10.1** was hardened automatically. 1 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

install-dependencies.sh pipes remote content directly to bash: `curl -s https://bashunit.typeddevs.com/install.sh | bash -s -- lib 0.11.0`. This allows arbitrary code execution from a remote server without any integrity verification. The script should be downloaded first, its checksum verified, and then executed separately.

Locations:

- `install-dependencies.sh:4`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed install-dependencies.sh: replaced `curl ... | bash` pipe pattern with a download-then-execute approach. The script now downloads the bashunit install.sh to a temporary file using `curl -fsSL ... -o`, sets up a trap for cleanup, and executes the downloaded script separately with `bash "${INSTALL_SCRIPT}" lib 0.11.0`. This eliminates the unsafe pipe-to-bash pattern that allowed arbitrary code execution from a remote server without integrity verification.

### Iteration 1

**Fixes applied:** suspicious-run-content

**Notes:**

Replaced the unsafe `eval "$(/root/bin/docpars ...)"` argument parsing pattern in src/main.sh with a safe explicit `case`-based argument parser. The new code iterates over `"$@"` and uses bash parameter expansion (`${arg#--name=}`) to extract values from `--name=value` style arguments. This eliminates all use of `eval` and command substitution on user-controlled input, while preserving identical functionality: the same local variables (github_token, xs_label, xs_max_size, etc.) are populated and passed to the rest of the main() function unchanged.

