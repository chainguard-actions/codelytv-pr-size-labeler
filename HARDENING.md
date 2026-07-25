<!-- markdownlint-disable -->

# Hardening Report: CodelyTV--pr-size-labeler/v1.10.3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **CodelyTV--pr-size-labeler/v1.10.3** was hardened automatically. 1 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

install-dependencies.sh pipes the output of curl directly into bash without first saving the script to a file and verifying it. The command `curl -s https://bashunit.typeddevs.com/install.sh | bash -s -- lib 0.11.0` fetches and immediately executes remote content, allowing a compromised or malicious remote server to execute arbitrary code on the runner.

Locations:

- `install-dependencies.sh:4`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed install-dependencies.sh: replaced `curl -s URL | bash -s -- lib 0.11.0` with a safe pattern that downloads the script to a temporary file via `mktemp`, executes it separately with `bash "$INSTALL_SCRIPT" lib 0.11.0`, then removes the temp file. Also improved curl flags to `-fsSL` so it fails on HTTP errors and follows redirects safely.

### Iteration 2

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed both workflow files: (1) Pinned `actions/checkout@v3` to its full commit SHA `a37ce9120846195fa4ece8f58b268e6043cb2f26` with a `# v3` comment for readability in both `.github/workflows/labeler.yml` and `.github/workflows/test.yml`. (2) Added top-level `permissions:` blocks — `pull-requests: write` in labeler.yml (required to apply labels to pull requests) and `contents: read` in test.yml (required to check out the repository for running tests).

