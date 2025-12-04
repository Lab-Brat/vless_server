terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "FizzyBiscuits"

    workspaces {
      name = "vless-server"
    }
  }
}
