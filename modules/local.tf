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


  oidc = {
    issuer_url    = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack", var.cluster_name, var.base_domain)
    oauth_url     = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack/protocol/openid-connect/auth", var.cluster_name, var.base_domain)
    token_url     = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack/protocol/openid-connect/token", var.cluster_name, var.base_domain)
    api_url       = format("https://keycloak.apps.%s.%s/auth/realms/devops-stack/protocol/openid-connect/userinfo", var.cluster_name, var.base_domain)
    client_id     = "devops-stack-applications"
    client_secret = random_password.clientsecret.result
    oauth2_proxy_extra_args = [
      "--insecure-oidc-skip-issuer-verification=true",
      "--ssl-insecure-skip-verify=true",
    ]
  }
}
