workflow "Deploy master branch" {
  on = "push"
  resolves = ["Deploy with Serverless"]
}

action "Only on master branch" {
  uses = "actions/bin/filter@b2bea07"
  args = "branch master"
}

action "Install dependencies" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "install"
  needs = ["Only on master branch"]
}

action "Deploy with Serverless" {
  uses = "serverless/github-action@master"
  args = "deploy"
  needs = ["Install dependencies"]
  secrets = ["SERVERLESS_ACCESS_KEY"]
}
