locals {
  keycloak_defaults = {
    user_map = {
      jdoe = {
        name       = "Doe"
        first_name = "John"
        email      = "jdoe@example.com"
      }
    }
    domain   = "keycloak.apps.${var.cluster_info.cluster_name}.${var.cluster_info.base_domain}"
  }

  keycloak = merge(
    local.keycloak_defaults,
    var.keycloak,
  )

  user_map = { for username, infos in local.keycloak.user_map : username => merge(infos, tomap({ password = random_password.keycloak_passwords[username].result })) }


  oidc = {
    issuer_url    = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack", var.cluster_info.cluster_name, var.cluster_info.base_domain)
    oauth_url     = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack/protocol/openid-connect/auth", var.cluster_info.cluster_name, var.cluster_info.base_domain)
    token_url     = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack/protocol/openid-connect/token", var.cluster_info.cluster_name, var.cluster_info.base_domain)
    api_url       = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack/protocol/openid-connect/userinfo", var.cluster_info.cluster_name, var.cluster_info.base_domain)
    client_id     = "devops-stack-applications"
    client_secret = random_password.clientsecret.result
    oauth2_proxy_extra_args = [
      "--insecure-oidc-skip-issuer-verification=true",
      "--ssl-insecure-skip-verify=true",
    ]
  }

  default_yaml = [ templatefile("${path.module}/values.tmpl.yaml", {
    oidc           = local.oidc,
    cluster_info   = var.cluster_info,
    cluster_issuer = var.cluster_issuer,
    keycloak       = local.keycloak,
    user_map       = local.user_map
  }) ]
  all_yaml = concat(local.default_yaml, var.extra_yaml)
}
