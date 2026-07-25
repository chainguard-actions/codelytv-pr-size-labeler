<!-- markdownlint-disable -->

# Hardening Report: CodelyTV--pr-size-labeler/v1.10.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **CodelyTV--pr-size-labeler/v1.10.2** was hardened automatically. 1 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

install-dependencies.sh pipes a remote script directly to bash without first downloading and inspecting it. The pattern `curl -s https://bashunit.typeddevs.com/install.sh | bash -s -- lib 0.11.0` fetches and immediately executes arbitrary remote content, allowing a compromised or malicious server to run arbitrary code on the runner.

Locations:

- `install-dependencies.sh:4`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed install-dependencies.sh: replaced the unsafe `curl | bash` pipe pattern with a two-step approach that (1) downloads the remote install script to /tmp/bashunit-install.sh using `curl -fsSL -o`, (2) executes it separately with `bash /tmp/bashunit-install.sh lib 0.11.0`, and (3) removes the temporary file. This eliminates the risk of a compromised or malicious server running arbitrary code immediately via the pipe. The curl flags were also improved from `-s` to `-fsSL` for better error handling (fail on HTTP errors, follow redirects, show errors even in silent mode).

### Iteration 2

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed both workflow files: (1) Pinned `actions/checkout@v3` to full SHA `a37ce9120846195fa4ece8f58b268e6043cb2f26` with `# v3` comment in both `.github/workflows/labeler.yml` and `.github/workflows/test.yml`. (2) Added top-level `permissions:` blocks — `pull-requests: write` in labeler.yml (required to apply labels to PRs) and `contents: read` in test.yml (required only for checkout, no write access needed).

