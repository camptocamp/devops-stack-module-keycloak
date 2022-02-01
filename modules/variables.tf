#######################
## Standard variables
#######################

variable "cluster_info" {
  type = object({
    cluster_name     = string
    base_domain      = string
    argocd_namespace = string
  })
}

variable "cluster_issuer" {
  type    = string
  default = "ca-issuer"
}

variable "namespace" {
  type    = string
  default = "keycloak"
}

variable "extra_yaml" {
  type    = list(string)
  default = []
}

#######################
## Module variables
#######################

variable "keycloak" {
  description = "Keycloak settings"
  type        = any
  default     = {}
}
