#######################
## Standard variables
#######################

variable "cluster_name" {
  type = string
}

variable "base_domain" {
  type = string
}

variable "oidc" {
  type = any
  default = {}
}

variable "kubernetes" {
  type = any
}

variable "argocd" {
  type = object({
    server     = string
    auth_token = string
    namespace  = string
    domain     = string
  })
}

variable "cluster_issuer" {
  type    = string
  default = "ca-issuer"
}

variable "namespace" {
  type    = string
  default = "kube-prometheus-stack"
}


#######################
## Module variables
#######################

variable "keycloak" {
  description = "Keycloak settings"
  type        = any
  default     = {}
}
