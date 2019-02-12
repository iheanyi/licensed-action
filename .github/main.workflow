workflow "check licenses" {
  on = "push"
  resolves = ["Check Licenses"]
}

action "Check Licenses" {
  uses = "./"
}
