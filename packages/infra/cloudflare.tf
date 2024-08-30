terraform {
  cloud {
    organization = "Sonaura"
    workspaces {
      name = "infra"
    }
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>4"
    }
  }
}

variable "cloudflare_api_token" {
  type = string
}

variable "zone_id" {
  default = "b546f34cbd7d6d568a8c82ef9a5b5351"
}

variable "account_id" {
  default = "4569021434a99a933cf61a890e6ef2c2"
}

variable "domain" {
  default = "sonaura.fr"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_r2_bucket" "sonaura-r2-marketing-bucket" {
  name       = "marketing"
  account_id = var.account_id
}

resource "cloudflare_worker_script" "sonaura-worker" {
  account_id = var.account_id
  content    = file("dist/worker.js")
  name       = "api"
}