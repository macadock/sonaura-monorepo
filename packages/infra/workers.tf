resource "cloudflare_workers_script" "sonaura-worker" {
  account_id         = var.CLOUDFLARE_ACCOUNT_ID
  content            = file("../../apps/api/dist/index.js")
  name               = "api-${var.BRANCH_NAME}"
  compatibility_date = "2024-08-21"
  module             = true

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