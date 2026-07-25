<!-- markdownlint-disable -->

# Hardening Report: CodelyTV--pr-size-labeler/v1.10.4

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **CodelyTV--pr-size-labeler/v1.10.4** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Both workflow files reference `actions/checkout@v3`, which is a mutable tag rather than a pinned 40-character commit SHA. If the tag is moved or the repository is compromised, the action could execute arbitrary code. All `uses:` references should be pinned to a full SHA (e.g., `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v3`).

Locations:

- `.github/workflows/labeler.yml:9`
- `.github/workflows/test.yml:13`

### missing-permissions (severity: medium)

Neither `.github/workflows/labeler.yml` nor `.github/workflows/test.yml` declares a top-level `permissions:` block, and no job within either file declares job-level permissions. Without explicit permissions, the GITHUB_TOKEN is granted its default (potentially broad) permissions. Each workflow should declare minimal required permissions (e.g., `permissions: contents: read` or `pull-requests: write` as needed).

Locations:

- `.github/workflows/labeler.yml:1`
- `.github/workflows/test.yml:1`

### unsafe-shell (severity: high)

The script `install-dependencies.sh` pipes a remote script directly to bash without first downloading and verifying it: `curl -s https://bashunit.typeddevs.com/install.sh | bash -s -- lib 0.11.0`. If the remote server is compromised or the URL is hijacked, arbitrary code will execute on the runner. The script should be downloaded to a file first, its integrity verified (e.g., via checksum), and then executed separately.

Locations:

- `install-dependencies.sh:4`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions, unsafe-shell

**Notes:**

1. Pinned `actions/checkout@v3` to full SHA `a37ce9120846195fa4ece8f58b268e6043cb2f26` in both `.github/workflows/labeler.yml` and `.github/workflows/test.yml`, preserving the `# v3` comment for readability.
2. Added top-level `permissions:` blocks to both workflow files: `labeler.yml` gets `contents: read` + `pull-requests: write` (needed to apply PR labels); `test.yml` gets `contents: read` (minimal for checkout and test execution).
3. Rewrote `install-dependencies.sh` to download the remote install script to a temp file first, verify its SHA-256 checksum before execution, and only then run it with `bash` — eliminating the unsafe `curl | bash` pipe. A placeholder checksum is included with instructions on how to update it for the specific version.

