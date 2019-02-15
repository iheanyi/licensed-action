workflow "check licenses" {
  on = "push"
  resolves = [
    "Check Licenses with Custom Configuration",
    "Check Licenses"
  ]
}

action "Check Licenses" {
  uses = "./"
}

action "Check Licenses with Custom Configuration" {
  uses = "./"
  env = {
    CONFIG_PATH = ".github/custom-licensed.yml"
  }
}
