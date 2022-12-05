locals {
  # helm_values = [{
  #   keycloak = {
  #     ingress = {
  #       enabled = true
  #       annotations = {
  #         "cert-manager.io/cluster-issuer"                   = "${var.cluster_issuer}"
  #         "traefik.ingress.kubernetes.io/router.entrypoints" = "websecure"
  #         "traefik.ingress.kubernetes.io/router.middlewares" = "traefik-withclustername@kubernetescrd"
  #         "traefik.ingress.kubernetes.io/router.tls"         = "true"
  #         "ingress.kubernetes.io/ssl-redirect"               = "true"
  #         "kubernetes.io/ingress.allow-http"                 = "false"
  #       }
  #       hosts = [
  #         {
  #           host = "keycloak.apps.${var.base_domain}"
  #           path = "/"
  #         },
  #         {
  #           host = "keycloak.apps.${var.cluster_name}.${var.base_domain}"
  #           path = "/"
  #         },
  #       ]
  #       tls = [{
  #         secretName = "keycloak-tls"
  #         hosts = [
  #           "keycloak.apps.${var.base_domain}",
  #           "keycloak.apps.${var.cluster_name}.${var.base_domain}"
  #         ]
  #       }]
  #     }
  #   }
  #   service = {
  #     annotations = {
  #       "traefik.ingress.kubernetes.io/service.serversscheme" = "https"
  #     }
  #   }
  #   keycloakClient = {
  #     client = {
  #       clientId = "${replace(local.oidc.client_id, "\"", "\\\"")}"
  #       secret   = "${replace(local.oidc.client_secret, "\"", "\\\"")}"
  #       redirectUris = [
  #         "*"
  #       ]
  #     }
  #   }
  #   keycloakUsers = {

  #   }
  # }]

  keycloak_defaults = {
    user_map = {
      jdoe = {
        name       = "Doe"
        first_name = "John"
        email      = "jdoe@example.com"
      }
    }
    domain = "keycloak.apps.${var.cluster_name}.${var.base_domain}"
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

  default_yaml = [templatefile("${path.module}/values.tmpl.yaml", {
    oidc           = local.oidc,
    base_domain    = var.base_domain,
    cluster_issuer = var.cluster_issuer,
    keycloak       = local.keycloak,
    user_map       = local.user_map
  })]
  all_yaml = concat(local.default_yaml, []) # TODO I've put and empty map to easily remove the variable extra_yaml since I already removed it from variables.tf
}
