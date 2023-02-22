locals {
  oidc = {
    issuer_url    = format("https://keycloak.apps.%s.%s/realms/devops-stack", var.cluster_name, var.base_domain)
    oauth_url     = format("https://keycloak.apps.%s.%s/realms/devops-stack/protocol/openid-connect/auth", var.cluster_name, var.base_domain)
    token_url     = format("https://keycloak.apps.%s.%s/realms/devops-stack/protocol/openid-connect/token", var.cluster_name, var.base_domain)
    api_url       = format("https://keycloak.apps.%s.%s/realms/devops-stack/protocol/openid-connect/userinfo", var.cluster_name, var.base_domain)
    client_id     = "devops-stack-applications"
    client_secret = resource.random_password.client_secret.result
    oauth2_proxy_extra_args = var.cluster_issuer == "ca-issuer" ? [
      "--insecure-oidc-skip-issuer-verification=true",
      "--ssl-insecure-skip-verify=true",
    ] : []
  }
}
