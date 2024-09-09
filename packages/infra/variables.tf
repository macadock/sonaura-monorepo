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

variable "WORKERS_SCRIPT_PATH" {
  type    = string
  default = "worker.js"
}