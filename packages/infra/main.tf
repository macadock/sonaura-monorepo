terraform {
  backend "s3" {
    bucket                      = "sonaura-terraform-state"
    key                         = "terraform/terraform.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
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

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudflare_account_id" {
  type = string
}

variable "api_url" {
  type = string
}

variable "website_url" {
  type = string
}

variable "environment" {
  type = string
}

variable "workspace_name" {
  type = string
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_workers_script" "sonaura-worker" {
  account_id         = var.cloudflare_account_id
  content            = file("worker.js")
  name               = "api-${var.workspace_name}"
  compatibility_date = "2024-08-21"
}

resource "cloudflare_workers_domain" "sonaura-worker-domain" {
  account_id = var.cloudflare_account_id
  hostname   = var.api_url
  service    = cloudflare_workers_script.sonaura-worker.name
  zone_id    = var.cloudflare_zone_id
}

resource "cloudflare_pages_project" "marketing-pages" {
  account_id        = var.cloudflare_account_id
  name              = "marketing"
  production_branch = "main"

  deployment_configs {
    production {
      compatibility_date  = "2024-08-21"
      compatibility_flags = ["nodejs_compat"]

      service_binding {
        name        = "api"
        service     = cloudflare_workers_script.sonaura-worker.name
        environment = "production"
      }

      environment_variables = {
        ENVIRONMENT  = var.environment
        NEXT_API_URL = var.api_url
      }
    }
  }
}

resource "cloudflare_pages_domain" "marketing-pages_domain" {
  account_id   = var.cloudflare_account_id
  domain       = var.website_url
  project_name = cloudflare_pages_project.marketing-pages.name
}