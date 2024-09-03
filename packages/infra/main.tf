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

variable "CLOUDFLARE_API_TOKEN" {
  type      = string
  sensitive = true
}

variable "CLOUDFLARE_ZONE_ID" {
  type      = string
  sensitive = true
}

variable "CLOUDFLARE_ACCOUNT_ID" {
  type      = string
  sensitive = true
}

variable "API_URL" {
  type = string
}

variable "WEBSITE_URL" {
  type = string
}

variable "ENVIRONMENT" {
  type = string
}

variable "BRANCH_NAME" {
  type = string
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

resource "cloudflare_workers_script" "sonaura-worker" {
  account_id         = var.CLOUDFLARE_ACCOUNT_ID
  content            = file("worker.js")
  name               = "api-${var.BRANCH_NAME}"
  compatibility_date = "2024-08-21"
}

resource "cloudflare_workers_domain" "sonaura-worker-domain" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  hostname   = var.API_URL
  service    = cloudflare_workers_script.sonaura-worker.name
  zone_id    = var.CLOUDFLARE_ZONE_ID
}

resource "cloudflare_pages_project" "marketing-pages" {
  account_id        = var.CLOUDFLARE_ACCOUNT_ID
  name              = "marketing-${var.BRANCH_NAME}"
  production_branch = var.BRANCH_NAME
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
        ENVIRONMENT  = var.ENVIRONMENT
        NEXT_PUBLIC_API_URL = var.API_URL
      }
    }
  }
}

resource "cloudflare_record" "marketing-pages_domain_zone" {
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = var.WEBSITE_URL
  content = cloudflare_pages_project.marketing-pages.domains[0]
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_pages_domain" "marketing-pages_domain" {
  account_id   = var.CLOUDFLARE_ACCOUNT_ID
  domain       = var.WEBSITE_URL
  project_name = cloudflare_pages_project.marketing-pages.name
}

