# J-RN Action

GitHub actions for J-RN.

## Usage

### Workflows

Requirements:

- `python3`
  + e.g. `uses: actions/setup-python@v2`

Examples:

```yaml
name: j-rn
on:
  push:
  pull_request:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
jobs:
  j-rn-action:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/setup-python@v2
    - uses: actions/checkout@v2
    - uses: J-RN/j-rn-action
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
```
