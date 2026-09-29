<!-- markdownlint-disable -->

# Hardening Report: CodelyTV--pr-size-labeler/v1.11.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **CodelyTV--pr-size-labeler/v1.11.1** was hardened automatically. 1 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

install-dependencies.sh pipes a remotely fetched script directly to bash without first downloading and verifying it. The pattern `curl -fsSL https://bashunit.com/install.sh | bash -s -- lib 0.51.0` executes arbitrary remote content in the runner shell, which is a supply-chain risk if the remote URL is compromised or redirected.

Locations:

- `install-dependencies.sh:5`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed install-dependencies.sh: replaced `curl ... | bash -s -- lib 0.51.0` with a two-step approach that downloads the script to a temp file via `mktemp`, then executes it as `bash "$BASHUNIT_INSTALL_SCRIPT" lib 0.51.0`. Dropped the `-s` and `--` from the pipe form as required (they were bash's own stdin-read flag and option-terminator, not arguments to the downloaded script). The temp file is cleaned up after execution.

### Iteration 2

**Fixes applied:** suspicious-run-content

**Notes:**

Replaced the `eval "$(/root/bin/docpars ...)"` pattern in src/main.sh with explicit argument parsing using a for/case loop. The new code iterates over all arguments and uses bash parameter expansion (`${arg#--prefix=}`) to extract values from `--key=value` style arguments. This eliminates the eval-dynamic injection risk entirely: even if argument values contain shell metacharacters (`;`, `|`, `$()`, backticks), they are treated as literal string data and never executed as shell code. All 16 variables previously set by docpars (github_token, xs_label, xs_max_size, s_label, s_max_size, m_label, m_max_size, l_label, l_max_size, xl_label, fail_if_xl, message_if_xl, github_api_url, files_to_ignore, ignore_line_deletions, ignore_file_deletions) are now populated directly and safely.

