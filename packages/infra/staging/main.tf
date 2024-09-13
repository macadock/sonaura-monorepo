terraform {
  backend "s3" {
    bucket                      = "sonaura-terraform-state"
    key                         = "staging"
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

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

resource "cloudflare_workers_script" "sonaura-worker" {
  account_id         = var.CLOUDFLARE_ACCOUNT_ID
  content            = file(var.WORKERS_SCRIPT_PATH)
  name               = "api-staging"
  compatibility_date = "2024-08-21"

  secret_text_binding {
    name = "SUPABASE_URL"
    text = var.SUPABASE_URL
  }
  secret_text_binding {
    name = "SUPABASE_ANON_KEY"
    text = var.SUPABASE_ANON_KEY
  }
}

resource "cloudflare_workers_domain" "sonaura-worker-domain" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  hostname   = var.API_URL
  service    = cloudflare_workers_script.sonaura-worker.name
  zone_id    = var.CLOUDFLARE_ZONE_ID
}

resource "cloudflare_pages_project" "marketing-pages" {
  account_id        = var.CLOUDFLARE_ACCOUNT_ID
  name              = "marketing-staging"
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
        ENVIRONMENT         = var.ENVIRONMENT
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