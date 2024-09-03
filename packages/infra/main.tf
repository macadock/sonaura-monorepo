terraform {
  cloud {
    organization = "Sonaura"
    workspaces {
      name = "production"
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

resource "cloudflare_workers_script" "sonaura-worker" {
  account_id         = var.account_id
  content            = file("worker.js")
  name               = "api"
  compatibility_date = "2024-08-21"
}

resource "cloudflare_workers_domain" "sonaura-worker-domain-production" {
  account_id  = var.account_id
  hostname    = "api.${var.domain}"
  service     = cloudflare_workers_script.sonaura-worker.name
  zone_id     = var.zone_id
  environment = "production"
}

resource "cloudflare_workers_domain" "sonaura-worker-domain-staging" {
  account_id  = var.account_id
  hostname    = "api-staging.${var.domain}"
  service     = cloudflare_workers_script.sonaura-worker.name
  zone_id     = var.zone_id
  environment = "staging"
}

resource "cloudflare_pages_project" "sonaura-marketing-pages" {
  account_id        = var.account_id
  name              = "marketing"
  production_branch = "main"

  source {
    type = "github"
    config {
      owner                         = "macadock"
      repo_name                     = "sonaura-monorepo"
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "custom"
      preview_branch_includes       = ["dev"]
      preview_branch_excludes       = ["main"]
    }
  }

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
        ENVIRONMENT  = "production"
        NEXT_API_URL = cloudflare_workers_domain.sonaura-worker-domain-production.hostname
      }
    }

    preview {
      compatibility_date  = "2024-08-21"
      compatibility_flags = ["nodejs_compat"]

      service_binding {
        name        = "api"
        service     = cloudflare_workers_script.sonaura-worker.name
        environment = "staging"
      }

      environment_variables = {
        ENVIRONMENT  = "staging"
        NEXT_API_URL = cloudflare_workers_domain.sonaura-worker-domain-staging.hostname
      }
    }
  }
}

resource "cloudflare_pages_domain" "sonaura-marketing-pages_domain" {
  account_id   = var.account_id
  domain       = "dev.${var.domain}"
  project_name = cloudflare_pages_project.sonaura-marketing-pages.name
}