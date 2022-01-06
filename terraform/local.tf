locals {
  keycloak_defaults = {
    user_map = {}
    domain   = "keycloak.apps.${var.cluster_name}.${var.base_domain}"
  }

  keycloak = merge(
    local.keycloak_defaults,
    var.keycloak,
  )
}
