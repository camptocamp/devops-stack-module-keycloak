locals {
  keycloak_defaults = {
    user_map = {
      jdoe = {
        name       = "Doe"
        first_name = "John"
        email      = "jdoe@example.com"
      }
    }
    domain   = "keycloak.apps.${var.cluster_name}.${var.base_domain}"
  }

  keycloak = merge(
    local.keycloak_defaults,
    var.keycloak,
  )

  user_map = { for username, infos in local.keycloak.user_map : username => merge(infos, tomap({ password = random_password.keycloak_passwords[username].result })) }
}
