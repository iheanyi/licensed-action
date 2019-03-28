# licensed-action
A GitHub Action for checking your open-source licenses.

## Usage

In order to work properly, you must have a proper [licensed configuration](https://github.com/github/licensed#configuration) in your repository.

```hcl
workflow "check licenses" {
  on = "push"
  resolves = [
    "Check Licenses"
  ]
}

action "Check Licenses" {
  uses = "iheanyi/licensed-action@master"
  secrets = ["GITHUB_TOKEN"]
}
```

## Secrets

`GITHUB_TOKEN` - **Optional.** Required for pushing up cached licenses to the repository.

## Environment

`CONFIG_PATH` - **Optional.** Path to your [licensed](https://github.com/github/licensed) configuration file if it is not in the base working directory.
