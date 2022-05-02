#######################
## Standard variables
#######################

variable "cluster_name" {
  type = string
}

variable "base_domain" {
  type = string
}

variable "argocd" {
  type = object({
    namespace = string
    domain    = string
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

variable "dependency_ids" {
  type = map(string)

  default = {}
}

#######################
## Module variables
#######################

variable "keycloak" {
  description = "Keycloak settings"
  type        = any
  default     = {}
}
