variable "database" {
  description = "Keycloak external DB server info."
  type = object({
    vendor   = string
    host     = string
    username = string
    password = string
  })
  default = null
}

variable "cluster_name" {
  type = string
}

# Variable used to add annotation to ingress. Must only be set when cert-manager is declared as a dependency.
# TODO set condition to add annotation.
# TODO group "cluster_issuer" and cert-manager module id.
variable "cluster_issuer" {
  type    = string
  default = "ca-issuer"
}

variable "base_domain" {
  type = string
}

variable "target_revision" {
  description = "Override of target revision of the application chart."
  type        = string
  default     = "v1.0.0-alpha.1" # x-release-please-version
}

variable "argocd_namespace" {
  type    = string
  default = "argocd"
}

variable "namespace" {
  type    = string
  default = "keycloak"
}

variable "helm_values" {
  description = "Helm override values."
  type        = any
  default     = []
}

variable "dependency_ids" {
  type    = map(string)
  default = {}
}
