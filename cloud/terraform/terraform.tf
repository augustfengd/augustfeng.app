terraform {
  cloud {
    organization = "augustfengd"

    workspaces {
      name = "augustfeng-app"
    }
  }
}
