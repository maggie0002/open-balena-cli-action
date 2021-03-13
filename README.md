# Open Balena CLI

### TL;DR
This is actions only for using with OpenBalena as alternative to BalenaCloud push.

Continuously deliver your applications to [OpenBalena](https://www.balena.io/open/).

Based on [Balena Push](https://github.com/theaccordance/balena-push) from [Joe Mainwaring](https://github.com/theaccordance).

**IMPORTANT** This actions doesnt promise full functionality!
To use it for CI/CD process you need to setup your own Github Runner using Full guide below.

## Full guide
Link to the full guide for using this Action here [OpenBalena push alternative](https://docs.solar-control.tech/openbalena/open-balena-push-analog).


## Inputs

### `balena_api_token`

**Required**: A OpenBalena API Token, used to authenticate with OpenBalena.  API keys can be created in the BalenaCLI via `balena api-key create`

### `balena_command`

**Required**: The balena command you would like to run with the action.

### `open_balena_address`

**Required**: Provide address of intance for your OpenBalena cloud.

### `root_cert`

**Required**: Provide content of your root cert for your OpenBalena cloud.

**IMPORTANT!**: Need to inline your ca.crt before put it to the Github Secrets. You can use `awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}'  ca.crt` command for this purpose

### `application_path`

_Optional_: Provide a sub-path to the location for application being deployed to BalenaCloud.  Defaults to the workspace root.



## Workflow Example
```yaml
name: OpenBalena Deploy

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
        uses: Solar-Control/open-balena-cli-action@v2.0.0
        if: success()
        with:
          balena_api_token: ${{secrets.BALENA_API_TOKEN}}
          balena_command: "deploy my-awesome-app --logs"
          open_balena_address: ${{secrets.OPEN_BALENA_ADDRESS}}
          root_cert: ${{secrets.OPEN_BALENA_ROOT_CERT}}
```
