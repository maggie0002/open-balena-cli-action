# Open Balena CLI

### TL;DR
This is actions only for using with OpenBalena as alternative to BalenaCloud push part

Continuously deliver your applications to [OpenBalena](https://www.balena.io/open/).

Based on [Balena Push](https://github.com/theaccordance/balena-push) from [Joe Mainwaring](https://github.com/theaccordance).

## Inputs

### `balena_api_token`

**Required**: A OpenBalena API Token, used to authenticate with OpenBalena.  API keys can be created in the [user settings for BalenaCloud](https://dashboard.balena-cloud.com/preferences/access-tokens).

### `balena_command`

**Required**: The balena command you would like to run with the action.

### `open_balena_address`

**Required**: Provide address of intance for your OpenBalena cloud.

### `root_cert`

**Required**: Provide content of your root cert for your OpenBalena cloud.

### `application_path`

_Optional_: Provide a sub-path to the location for application being deployed to BalenaCloud.  Defaults to the workspace root.



## Workflow Example
```yaml
name: BalenaCloud Deploy

on:
  push:
    # Only run workflow for pushes to specific branches
    branches:
      - master

jobs:
  balena-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Balena Deploy
        uses: solar-control/open-balena-cli-action@v1
        if: success()
        with:
          balena_api_token: ${{secrets.BALENA_API_TOKEN}}
          balena_command: "deploy my-awesome-app --logs"
          open_balena_address: ${{secrets.OPEN_BALENA_ADDRESS}}
          root_cert: ${{secrets.OPEN_BALENA_ROOT_CERT}}
```
