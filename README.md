# PR Version Check Github Action

Checks if the version field in a given JSON file has been incremented compared to master. Principally
for checking on PRs to be merged into master.

## Usage:

```yaml
name: "Check for version update in PR to Master"

on:
  pull_request:
    # Sequence of patterns matched against refs/heads
    branches:    
    - master

jobs:
  master-pr-check-version:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Check if version changed
      uses: rpiambulance/action-pr-version-check
      with:
        file: package.json # optional, defaults to "package.json"
```
