#######################
## Standard variables
#######################

variable "cluster_name" {
  description = "Name given to the cluster. Value used for the ingress' URL of the application."
  type        = string
}

variable "base_domain" {
  description = "Base domain of the cluster. Value used for the ingress' URL of the application."
  type        = string
}

variable "cluster_issuer" {
  description = "SSL certificate issuer to use. In this module it is used to conditionally add extra arguments to the OIDC configuration."
  type        = string
  default     = "ca-issuer"
}

variable "dependency_ids" {
  description = "IDs of the other modules on which this module depends on."
  type        = map(string)
  default     = {}
}

#######################
## Module variables
#######################

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

variable "oidc_redirect_uris" {
  description = "List of URIs where the authentication server is allowed to return during the authentication flow."
  type        = list(string)
  default = [
    "*"
  ]
}

variable "user_map" {
  description = "List of users to be added to the DevOps Stack Realm. Note that all fields are mandatory."
  type = map(object({
    username   = string
    email      = string
    first_name = string
    last_name  = string
  }))
  default = { # TODO Decide what we name the default user, just a matter of style
    devopsadmin = {
      username   = "devopsadmin"
      email      = "devopsadmin@devops-stack.io"
      first_name = "Administrator"
      last_name  = "DevOps Stack"
    }
  }
}
