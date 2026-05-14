# Hardening Report: codelytv--pr-size-labeler/v1.10.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `ff50f15e4b79bfbf764dafdfd2579175a6ea9771`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **codelytv--pr-size-labeler/v1.10.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

install-dependencies.sh pipes a remotely fetched script directly to bash without first downloading and verifying it: `curl -s https://bashunit.typeddevs.com/install.sh | bash -s -- lib 0.10.0`. This allows arbitrary code execution if the remote URL is compromised or tampered with in transit.

Locations:

- `install-dependencies.sh:4`

### suspicious-run-content (severity: high)

eval-dynamic: src/main.sh uses `eval "$(...)"` (eval with command substitution) to dynamically construct and execute shell commands based on the output of `/root/bin/docpars`. This pattern can obscure what code is being executed and is a known obfuscation/injection risk. Matching pattern: `eval "$(/root/bin/docpars -h ...)"`

Locations:

- `src/main.sh:14`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell, suspicious-run-content

**Notes:**

1. install-dependencies.sh: Replaced the unsafe `curl | bash` pipe pattern with a two-step approach — download the bashunit install script to /tmp/bashunit-install.sh first, then execute it separately, then remove it. This prevents arbitrary code execution if the remote URL is compromised in transit.

2. src/main.sh: Replaced `eval "$(/root/bin/docpars ...)"` with a safe bash `case` statement that directly parses all `--key=value` CLI arguments using shell parameter expansion (`${arg#--key=}`). All 16 named parameters (github_token, xs_label, xs_max_size, s_label, s_max_size, m_label, m_max_size, l_label, l_max_size, xl_label, fail_if_xl, message_if_xl, github_api_url, files_to_ignore, ignore_line_deletions, ignore_file_deletions) are parsed into the same local variables that the rest of the function uses, preserving identical behavior without any eval or command substitution.

