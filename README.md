# go-pr-release-action
[go-pr-release](https://github.com/tomtwinkle/go-pr-release) custom action for Github Action.

## Usage
For example, the workflow to create a pull request for release with go-pr-release is as follows.

```yaml
name: go-pr-release

on:
  push:
    branches:
      - develop

jobs:
  go-pr-release:
    name: go-pr-release
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: go-pr-release
      uses: tomtwinkle/go-pr-release-action@main
      env:
        GO_PR_RELEASE_TOKEN: ${{ secrets.GITHUB_TOKEN }} # Required
        GO_PR_RELEASE_RELEASE: main                      # Required. Release Branch: Destination to be merged
        GO_PR_RELEASE_DEVELOP: develop                   # Required. Develop Branch: Merge source
        GO_PR_RELEASE_LABELS: release                    # Optional. PullRequest labels. Multiple labels can be specified, separated by `commas`
        GO_PR_RELEASE_TITLE: ""                          # Optional. specify the title of the pull request
        GO_PR_RELEASE_TEMPLATE: ".github/template.tmpl"  # Optional. Specify a template file that can be described in `go template`
        GO_PR_RELEASE_REVIEWERS: tomtwinkle              # Optional. PullRequest reviewers. Multiple reviewers can be specified, separated by `commas`
        GO_PR_RELEASE_DRY_RUN: false                     # Optional. if true, display only the results to be created without creating PullRequest
```

## Environment variables

The same as [go-pr-release configuration](https://github.com/tomtwinkle/go-pr-release#configuration) can be used.
