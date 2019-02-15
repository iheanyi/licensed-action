workflow "check licenses" {
  on = "push"
  resolves = [
    "Check Licenses with Custom Configuration"
  ]
}

action "Check Licenses" {
  uses = "./"
}

action "Check Licenses with Custom Configuration" {
  uses = "./"
  needs = ["Check Licenses"]
  env = {
    CONFIG_PATH = ".github/custom-licensed.yml"
  }
}
