resource "cloudflare_pages_project" "marketing-pages" {
  account_id        = var.CLOUDFLARE_ACCOUNT_ID
  name              = "marketing-${var.BRANCH_NAME}"
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