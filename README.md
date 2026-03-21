# homebrew-tap

Homebrew tap for [mmobeus](https://github.com/mmobeus) projects.

## Usage

```
brew tap mmobeus/tap
brew install luadata
```

## Available formulas

| Formula | Description | Source repo |
|---------|-------------|-------------|
| [luadata](Formula/luadata.rb) | Parse Lua data files and convert to JSON | [mmobeus/luadata](https://github.com/mmobeus/luadata) |

## How it works

Each formula downloads a prebuilt macOS binary (Intel or Apple Silicon) from the
source project's GitHub Release. Formulas are updated automatically when new
releases are published.

### Automatic formula updates

Source repos trigger formula updates via a `repository_dispatch` event. The
[update-formula](.github/workflows/update-formula.yml) workflow receives the new
version and SHA256 hashes, updates the formula file, and pushes the commit.

### Authentication

Source repos authenticate to this repo using a **GitHub App** rather than a
personal access token. This keeps credentials scoped and not tied to any
individual's account.

#### GitHub App setup

The app is named `mmobeus-homebrew-updater` and is configured as follows:

1. **Created at**: GitHub > mmobeus org settings > Developer settings > GitHub Apps
2. **Permissions** (repository-level only):
   - Contents: Read and write
   - Actions: Read and write (to trigger dispatches)
3. **Webhook**: Disabled (not needed)
4. **Installation**: Installed on the mmobeus org, restricted to only the
   `homebrew-tap` repository

#### Secrets in source repos

Source repos need two **organization secrets** (scoped to selected repositories)
to generate a short-lived token at runtime:

| Secret | Value |
|--------|-------|
| `HOMEBREW_APP_ID` | The App ID from the GitHub App's settings page |
| `HOMEBREW_APP_PRIVATE_KEY` | The full contents of the `.pem` private key generated on the app's settings page |

These are stored as org-level secrets with access granted to repos that publish
Homebrew formulas.

#### How source repos use the app

In a GitHub Actions workflow, the source repo mints a short-lived token using
[`actions/create-github-app-token`](https://github.com/actions/create-github-app-token):

```yaml
- name: Generate GitHub App token
  id: app_token
  uses: actions/create-github-app-token@v2
  with:
    app-id: ${{ secrets.HOMEBREW_APP_ID }}
    private-key: ${{ secrets.HOMEBREW_APP_PRIVATE_KEY }}
    owner: mmobeus
    repositories: homebrew-tap

- name: Update Homebrew formula
  env:
    GH_TOKEN: ${{ steps.app_token.outputs.token }}
  run: |
    gh api repos/mmobeus/homebrew-tap/dispatches \
      -f event_type=update-formula \
      -f "client_payload[version]=${VERSION}" \
      -f "client_payload[sha256_amd64]=${SHA_AMD64}" \
      -f "client_payload[sha256_arm64]=${SHA_ARM64}"
```

The token is scoped to `homebrew-tap` only and expires after one hour.

## Adding a new formula

1. Create `Formula/<name>.rb` with architecture-specific URLs pointing to the
   source repo's GitHub Release assets
2. Add an "Update Homebrew formula" step to the source repo's release workflow
   (see above for the pattern)
3. Ensure the source repo has access to the `HOMEBREW_APP_ID` and
   `HOMEBREW_APP_PRIVATE_KEY` org secrets
4. Update the [update-formula workflow](.github/workflows/update-formula.yml) if
   the new formula needs different update logic, or keep it generic
