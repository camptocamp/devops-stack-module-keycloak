variable "cluster_name" {
  description = "Name given to the cluster. Value used for the ingress' URL of the application."
  type        = string
}

variable "base_domain" {
  description = "Base domain of the cluster. Value used for the ingress' URL of the application."
  type        = string
}

variable "dependency_ids" {
  description = "TODO"
  type        = map(string)
  default     = {}
}

variable "keycloak_admin" {
  description = "Username and password for the default admistrator user of the Keycloak instance."
  type = object({
    username = string
    password = string
  })
  sensitive = true
}

variable "tls_insecure_skip_verify" {
  description = "Ignore insecure connections when the Terraform provider connects to the Keycloak instance."
  type        = bool
  default     = false
}
