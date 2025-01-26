terraform {
  backend "remote" {
    organization = "augustfengd"

    workspaces {
      name = "augustfeng-app"
    }
  }
}
